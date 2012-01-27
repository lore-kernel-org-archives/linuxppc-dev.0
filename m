Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
 by ozlabs.org (Postfix) with ESMTP id 9291C1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 17:43:19 +1100 (EST)
Received: from edison.ad.selinc.com (edison.ad.selinc.com [10.100.0.15])
 by duster.selinc.com (8.14.4/8.14.4) with ESMTP id q0R6hFEg026526
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2012 22:43:15 -0800
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Subject: Another FSL SPI driver question (warning long post)
Message-ID: <OF5EB2B20E.C04CCB0B-ON88257992.001D645A-88257992.0024EC66@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 26 Jan 2012 22:43:17 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Kumar,

I'm using the 3.0.3 kernel on an MPC8308 and utilizing the spi_fsl_spi 
driver to talk with an Cypress NvRAM device.  I've gotten that working 
now, but I've come across something I don't understand in the driver and 
I'm not sure if it's just me or if there's a bug.  My issue relates to 
chip selects, their active state, and their specification in the device 
tree (lots of moving parts here, so I hope I describe it well enough to be 
understood).  The chip select for the NvRAM is active low, but setting 
everything up they way I _think_ it should be for an active low signal 
gets me an active high signal. 

The device tree entry is:

      spi@7000 {
         #address-cells = <1>;
         #size-cells = <0>;
         cell-index = <0>;
         compatible = "fsl,spi";
         reg = <0x7000 0x1000>;
         interrupts = <16 0x8>;
         interrupt-parent = <&ipic>;
         mode = "cpu";
         gpios = <&gpio1 16 1>;

         nvram@0 {
            compatible = "spidev";
            spi-max-frequency = <40000000>;
            reg = <0>;
         };
      };

And the relevant driver code is the fsl_spi_chipselect and the 
fsl_spi_cs_control functions shown below (line numbers are for reference 
only and don't match lines numbers in .../drivers/spi/spi_fsl_spi.c):

1  static void fsl_spi_chipselect(struct spi_device *spi, int value)
2  {
3       struct mpc8xxx_spi *mpc8xxx_spi = 
spi_master_get_devdata(spi->master);
4       struct fsl_spi_platform_data *pdata = 
spi->dev.parent->platform_data;
5       bool pol = spi->mode & SPI_CS_HIGH;
6       struct spi_mpc8xxx_cs   *cs = spi->controller_state;
7 
8       if (value == BITBANG_CS_INACTIVE) {
9               if (pdata->cs_control)
10                      pdata->cs_control(spi, !pol);
11      }
12
13      if (value == BITBANG_CS_ACTIVE) {
14              mpc8xxx_spi->rx_shift = cs->rx_shift;
15              mpc8xxx_spi->tx_shift = cs->tx_shift;
16              mpc8xxx_spi->get_rx = cs->get_rx;
17              mpc8xxx_spi->get_tx = cs->get_tx;
18
19              fsl_spi_change_mode(spi);
20
21              if (pdata->cs_control)
22                      pdata->cs_control(spi, pol);
23      }
24 }
25
26 static void fsl_spi_cs_control(struct spi_device *spi, bool on)
27 {
28      struct device *dev = spi->dev.parent;
29      struct mpc8xxx_spi_probe_info *pinfo = 
to_of_pinfo(dev->platform_data);
30      u16 cs = spi->chip_select;
31      int gpio = pinfo->gpios[cs];
32      bool alow = pinfo->alow_flags[cs];
33
34      gpio_set_value(gpio, on ^ alow);
35 }

The variable "pol" comes from spi->mode & SPI_CS_HIGH (line 5) and 
spi->mode gets it's value based on the spi-cs-high attribute in the device 
tree via .../drivers/of/of_spi.c like this:

if (of_find_property(nc, "spi-cs-high", NULL))
        spi->mode |= SPI_CS_HIGH;

In my case I want an active low CS so I don't include this attribute and 
spi->mode doesn't get the bit set.  "alow" (line 32) ultimately comes from 
the flags part of the gpios specifier in the SPI node of my device tree 
via the of_fsl_spi_probe function like this:

gpio = of_get_gpio_flags(np, i, &flags);  <- flags gets a direct copy of 
flags in the gpios specifier
pinfo->alow_flags[i] = flags & OF_GPIO_ACTIVE_LOW;

OF_GPIO_ACTIVE_LOW is an enum with a value of 0x1, implying that a value 
of "1" in the flags in my gpios specifier is saying the GPIO signal is 
active low.  So if my understanding is right, I've got everything set up 
in my device tree correctly to have an active low CS.

Now to the crux of the problem, line 34, the gpio_set_value call.  When an 
SPI transaction is started and the CS needs to be driven to it's active 
state (low in my case) fsl_spi_chipselect is called with value = 
BITBANG_CS_ACTIVE, which leads to line 22, calling fsl_spi_cs_control with 
pol = 0 because spi->mode doesn't have the SPI_CS_HIGH bit set (line 5) 
which becomes "on" in fsl_spi_cs_control.  alow = 1(line 32) because flags 
is 1 in the gpios specifier.  "on" = 0 XORed with "alow" = 1 equals 1 when 
gpio_set_value is called, setting my chipselect HIGH not low.  Then when 
the transaction is done fsl_spi_chipselect is called with value = 
BITBANG_CS_INACTIVE which leads to line 10 calling fsl_spi_cs_control with 
!pol = 1, alow is still a 1 and 1 XOR 1 = 0 when gpio_set_value is called, 
setting my chipselect to LOW.

I did an experiment in which I added the spi-cs-high attribute to my 
device tree (which should have made the signal active high) and the result 
was the signal operated in the opposite way from what the name of the 
attribute implies.

So (if my understanding of the device tree entries is correct) the logic 
on line 34 appears to be flawed, but since I'm not 100% sure of my 
understanding I wanted to ask people smarter than I am.

More over, I don't think I understand why a device tree entry is used to 
indicate which state to change the chipselect to.  Wouldn't it make more 
sense if lines 10 and 22 pass in a "1" for "set the CS to the active 
state" and a "0" for "set the CS to the inactive state"?  You could even 
use the already existing BITBANG_* macros.  Something like this:

1  static void fsl_spi_chipselect(struct spi_device *spi, int value)
2  {
3       struct mpc8xxx_spi *mpc8xxx_spi = 
spi_master_get_devdata(spi->master);
4       struct fsl_spi_platform_data *pdata = 
spi->dev.parent->platform_data;
5       bool pol = spi->mode & SPI_CS_HIGH;
6       struct spi_mpc8xxx_cs   *cs = spi->controller_state;
7 
8       if (value == BITBANG_CS_INACTIVE) {
9               if (pdata->cs_control)
10                      pdata->cs_control(spi, BITBANG_CS_INACTIVE);  <-- 
change
11      }
12
13      if (value == BITBANG_CS_ACTIVE) {
14              mpc8xxx_spi->rx_shift = cs->rx_shift;
15              mpc8xxx_spi->tx_shift = cs->tx_shift;
16              mpc8xxx_spi->get_rx = cs->get_rx;
17              mpc8xxx_spi->get_tx = cs->get_tx;
18
19              fsl_spi_change_mode(spi);
20
21              if (pdata->cs_control)
22                      pdata->cs_control(spi, BITBANG_CS_ACTIVE); 
<--change
23      }
24 }
25
26 static void fsl_spi_cs_control(struct spi_device *spi, bool on)
27 {
28      struct device *dev = spi->dev.parent;
29      struct mpc8xxx_spi_probe_info *pinfo = 
to_of_pinfo(dev->platform_data);
30      u16 cs = spi->chip_select;
31      int gpio = pinfo->gpios[cs];
32      bool alow = pinfo->alow_flags[cs];
33
34      gpio_set_value(gpio, on ^ alow);
35 }

Comments?  Am I totally screwed up in my understanding?

Thanks.

Bruce

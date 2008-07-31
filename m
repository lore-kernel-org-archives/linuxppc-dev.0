Return-Path: <glikely@secretlab.ca>
Date: Thu, 31 Jul 2008 13:59:11 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable
	via FDT
Message-ID: <20080731195911.GA29610@secretlab.ca>
References: <4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com> <48921187.1090101@grandegger.com>
	<48921179.1080403@freescale.com> <48921888.3020900@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48921888.3020900@grandegger.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 09:54:48PM +0200, Wolfgang Grandegger wrote:
> Thinking more about it, it would be best to add the property  
> "i2c-clock-divider" to the soc node and implement fsl_get_i2c_freq() in  
> a similar way:
>
>         soc8541@e0000000 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 device_type = "soc";
>                 ranges = <0x0 0xe0000000 0x100000>;
>                 reg = <0xe0000000 0x1000>;      // CCSRBAR 1M
>                 bus-frequency = <0>;
>                 i2c-clock-divider = <2>;
>
> U-Boot could then fixup that value like bus-frequency() and the i2c-mpc  
> driver simply calls fsl_get_i2c_freq().

Ugh.  This is specifically related to the i2c device, so please place
the property in the i2c device.  Remember, device tree design is not
about what will make the implementation simplest, but rather about what
describes the hardware in the best way.

Now, if you can argue that i2c-clock-frequency is actually a separate
clock domain defined at the SoC level, not the i2c device level, then I
will change my opinion.

g.

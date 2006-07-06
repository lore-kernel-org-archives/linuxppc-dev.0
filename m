Return-Path: <robinpv@aiware.co.jp>
Received: from cat.aiware.co.jp (ml.aiware.jp [222.228.111.22])
	by ozlabs.org (Postfix) with ESMTP id 6B3A967A3A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jul 2006 17:16:42 +1000 (EST)
Received: from [192.168.25.80] (neko.aiware.jp [222.228.111.24])
	by cat.aiware.co.jp (Postfix) with ESMTP id 7A070F486A
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jul 2006 16:16:37 +0900 (JST)
Message-ID: <44ACB8EE.6000406@aiware.co.jp>
Date: Thu, 06 Jul 2006 16:17:02 +0900
From: robinpv <robinpv@aiware.co.jp>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: MPC5200 PCI resource allocation problem
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I am using the MPC5200 based board. I have a PCI 2250 bridge, with 2 
RTL8110S ethernet chips on the bridge.
I am using the lite5200 as reference code.
When i run the linux(2.6.16.1), during bootup the following messages are 
displayed,

PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of PCI bridge 1
PCI: bridge 1 resource 0 moved to b0fff000..b0ffffff
PCI: Cannot allocate resource region 1 of PCI bridge 1
PCI: bridge 1 resource 1 moved to aff00000..afffffff
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: bridge 1 resource 2 moved to 9ff00000..9fffffff

Looking at the iomem and ioports dump, shows that MMIO region has been 
allocated.
But in the ethernet driver when i try to access the ethernet registers. 
all the register content are shown as FFFF.
Also in the mpc52xx_pci.h, the default value for these macros are...
#define MPC52xx_PCI_IO_BASE       0xb0000000
#define MPC52xx_PCI_IO_START    0x00000000
For this setting, IO resource allocation fails
changing to
#define MPC52xx_PCI_IO_START    0xB0000000
passes through.

Can some suggest what could be the problem and how to go about.??

-------------------------------------------------------------------
the iomem dump is as follows
80000000-9fffffff : PCI prefetchable memory
  9ff00000-9fffffff : PCI Bus #01
a0000000-afffffff : PCI memory
  a0000000-a07fffff : 0000:00:10.0
  a0800000-a09fffff : 0000:00:10.0
    a0840000-a0840057 : ohci_hcd
  a0a00000-a0a000ff : 0000:00:11.0
    a0a00000-a0a000ff : SiI680
  a0a40000-a0a7ffff : 0000:00:1a.0
  aff00000-afffffff : PCI Bus #01
    aff00000-aff000ff : 0000:01:02.0
      aff00000-aff000ff : r8169 <= Ethernet 1
    aff00100-aff001ff : 0000:01:03.0
      aff00100-aff001ff : r8169 <=Ethernet 2
f0000900-f000097f : mpc52xx-mscan.0
f0000980-f00009ff : mpc52xx-mscan.1
f0000f00-f0000f1f : mpc52xx-spi
f0001000-f00010ff : ppc-soc-ohci
f0001300-f000130f : mpc52xx-bdlc
f0002000-f000209f : mpc52xx-psc.0
  f0002000-f000209f : mpc52xx_psc_uart
f0002200-f000229f : mpc52xx-psc.1
f0002400-f000249f : mpc52xx-psc.2
f0002600-f000269f : mpc52xx-psc.3
f0002800-f000289f : mpc52xx-psc.4
f0002c00-f0002c9f : mpc52xx-psc.5
f0003000-f00033ff : mpc52xx-fec
f0003a00-f0003aff : mpc52xx-ata
f0003d00-f0003d1f : fsl-i2c.0
f0003d40-f0003d5f : fsl-i2c.1
-------------------------------------------------------
the ioports dump is
  b0000000-b0000007 : 0000:00:11.0
  b0000008-b000000b : 0000:00:11.0
  b000000c-b000000f : 0000:00:11.0
  b0000010-b0000017 : 0000:00:11.0
  b0000020-b000002f : 0000:00:11.0
  b0fff000-b0ffffff : PCI Bus #01
    b0fff000-b0fff0ff : 0000:01:02.0
      b0fff000-b0fff0ff : r8169 <=Ethernet 1
    b0fff400-b0fff4ff : 0000:01:03.0
      b0fff400-b0fff4ff : r8169 <=Ethernet 2
----------------------------------------------------------

With Regards,
Robin

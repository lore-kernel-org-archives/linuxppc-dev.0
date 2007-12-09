Return-Path: <jsamch@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 5DC57DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Dec 2007 16:51:31 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2680316wag
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 08 Dec 2007 21:51:30 -0800 (PST)
Message-ID: <169c03cb0712082151k74e504bvc6e21bb57534ef28@mail.gmail.com>
Date: Sun, 9 Dec 2007 00:51:30 -0500
From: "Jean-Samuel Chenard" <jsamch@macs.ece.mcgill.ca>
Sender: jsamch@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx ML310 Linux 2.6 PCI bridge
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14531_27785716.1197179490757"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_14531_27785716.1197179490757
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Thanks to the valuable information provided by this discussion group and
particularly by Grant Likely from Secret Lab Technologies, I was able to
setup and run Linux 2.6 on my ML-310 development platform.

On the ML-310, if I want to use the Ethernet port and some other
peripherals, I need to go through the PCI bus via the opb_pci core on the
FPGA.

However, when I enable PCI support in the kernel, I get the following error
messages:

arch/ppc/syslib/ppc4xx_setup.c: In function `ppc4xx_map_io':
arch/ppc/syslib/ppc4xx_setup.c:118: error: `PPC4xx_PCI_IO_VADDR' undeclared
(first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:118: error: (Each undeclared identifier is
reported only once
arch/ppc/syslib/ppc4xx_setup.c:118: error: for each function it appears in.=
)
arch/ppc/syslib/ppc4xx_setup.c:119: error: `PPC4xx_PCI_IO_PADDR' undeclared
(first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:119: error: `PPC4xx_PCI_IO_SIZE' undeclared
(first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:120: error: `PPC4xx_PCI_CFG_VADDR' undeclare=
d
(first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:121: error: `PPC4xx_PCI_CFG_PADDR' undeclare=
d
(first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:121: error: `PPC4xx_PCI_CFG_SIZE' undeclared
(first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:122: error: `PPC4xx_PCI_LCFG_VADDR'
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:123: error: `PPC4xx_PCI_LCFG_PADDR'
undeclared (first use in this function)
arch/ppc/syslib/ppc4xx_setup.c:123: error: `PPC4xx_PCI_LCFG_SIZE' undeclare=
d
(first use in this function)
make[1]: *** [arch/ppc/syslib/ppc4xx_setup.o] Error 1

My Xilinx Platform Studio has the proper PCI bridge component, but the
exported constants in xparameters_ml300.h are not helping me figure out the
mapping that I should give to those PPC4xx values (the parameters contain a
lot of XPAR_PCI32_BRIDGE_* constants).  I'm guessing that the address
mappings must be set from some of those for the PCI range to appear in the
PowerPC address space.  Please correct me if I'm misunderstanding something
here...

I only saw one mention of this error related to the ML-310 in a discussion
dating in 2005 and the answer was that the 2.6 kernel was not supporting th=
e
Virtex-II Pro too well at the time.  Has this changed and does anyone have
had success using the PCI bridge in Linux 2.6 on an ML-310 development
platform ?

Thanks,

Jean-Samuel
--=20
Integrated Microsystems Laboratory
McGill University, Montr=E9al, QC, CANADA
Web Page: http://chaos.ece.mcgill.ca

------=_Part_14531_27785716.1197179490757
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br><br>Thanks to the valuable information provided by this discussion g=
roup and particularly by Grant Likely from Secret Lab Technologies, I was a=
ble to setup and run Linux 2.6 on my ML-310 development platform.<br><br>
On the ML-310, if I want to use the Ethernet port and some other peripheral=
s, I need to go through the PCI bus via the opb_pci core on the FPGA.<br><b=
r>However, when I enable PCI support in the kernel, I get the following err=
or messages:
<br><br>arch/ppc/syslib/ppc4xx_setup.c: In function `ppc4xx_map_io&#39;:<br=
>arch/ppc/syslib/ppc4xx_setup.c:118: error: `PPC4xx_PCI_IO_VADDR&#39; undec=
lared (first use in this function)<br>arch/ppc/syslib/ppc4xx_setup.c:118: e=
rror: (Each undeclared identifier is reported only once
<br>arch/ppc/syslib/ppc4xx_setup.c:118: error: for each function it appears=
 in.)<br>arch/ppc/syslib/ppc4xx_setup.c:119: error: `PPC4xx_PCI_IO_PADDR&#3=
9; undeclared (first use in this function)<br>arch/ppc/syslib/ppc4xx_setup.=
c:119: error: `PPC4xx_PCI_IO_SIZE&#39; undeclared (first use in this functi=
on)
<br>arch/ppc/syslib/ppc4xx_setup.c:120: error: `PPC4xx_PCI_CFG_VADDR&#39; u=
ndeclared (first use in this function)<br>arch/ppc/syslib/ppc4xx_setup.c:12=
1: error: `PPC4xx_PCI_CFG_PADDR&#39; undeclared (first use in this function=
)
<br>arch/ppc/syslib/ppc4xx_setup.c:121: error: `PPC4xx_PCI_CFG_SIZE&#39; un=
declared (first use in this function)<br>arch/ppc/syslib/ppc4xx_setup.c:122=
: error: `PPC4xx_PCI_LCFG_VADDR&#39; undeclared (first use in this function=
)
<br>arch/ppc/syslib/ppc4xx_setup.c:123: error: `PPC4xx_PCI_LCFG_PADDR&#39; =
undeclared (first use in this function)<br>arch/ppc/syslib/ppc4xx_setup.c:1=
23: error: `PPC4xx_PCI_LCFG_SIZE&#39; undeclared (first use in this functio=
n)
<br>make[1]: *** [arch/ppc/syslib/ppc4xx_setup.o] Error 1<br><br>My Xilinx =
Platform Studio has the proper PCI bridge component, but the exported const=
ants in xparameters_ml300.h are not helping me figure out the mapping that =
I should give to those PPC4xx values (the parameters contain a lot of XPAR_=
PCI32_BRIDGE_* constants).&nbsp; I&#39;m guessing that the address mappings=
 must be set from some of those for the PCI range to appear in the PowerPC =
address space.&nbsp; Please correct me if I&#39;m misunderstanding somethin=
g here...
<br><br>I only saw one mention of this error related to the ML-310 in a dis=
cussion dating in 2005 and the answer was that the 2.6 kernel was not suppo=
rting the Virtex-II Pro too well at the time.&nbsp; Has this changed and do=
es anyone have had success using the PCI bridge in Linux=20
2.6 on an ML-310 development platform ?<br clear=3D"all"><br>Thanks,<br><br=
>Jean-Samuel<br>-- <br>Integrated Microsystems Laboratory<br>McGill Univers=
ity, Montr=E9al, QC, CANADA<br>Web Page: <a href=3D"http://chaos.ece.mcgill=
.ca">
http://chaos.ece.mcgill.ca</a>

------=_Part_14531_27785716.1197179490757--

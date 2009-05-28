Return-Path: <isaac.nancy@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 99509DDEDC
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 05:05:53 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so2549717ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 12:05:52 -0700 (PDT)
MIME-Version: 1.0
Sender: isaac.nancy@gmail.com
Date: Thu, 28 May 2009 12:05:52 -0700
Message-ID: <1bcc666d0905281205p63ee8119td5578a749bce8377@mail.gmail.com>
Subject: 8544 external interrupt configuration problems
From: Nancy Isaac <nancy.isaac@pobox.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd670120dbbed046afda612
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd670120dbbed046afda612
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have a custom board that's using powerpc 8544. I am trying to setup the
external interrupts using the device tree and I am having no luck getting
the interrupt.  I think my problem is that I don't have the hwirq to virq
mapping correctly. We are using the freescale 8544ds as our base.  We have a
PCI bus but we are not using PCIE.  In my kernel configuration, I have
CONFIG_PCIEPORTBUS disabled.  The PCI interrupt is connected to IRQ0 and it
is working fine.  But, my FPGA has three interrupts, IRQ1, IRQ2 and IRQ3.  I
configure this in the device tree and I've tried many different numbers for
the interrupt.

In the KConfig for ppc85xx, the configuration is the following

config MPC85xx_DS
    bool "Freescale MPC8544 DS"
    #select PPC_I8259
    select DEFAULT_UIMAGE
    select FSL_PCIE

config MPC85xx
    bool
    select PPC_UDBG_16550
    select PPC_INDIRECT_PCI
    select FSL_PCIE
    select SERIAL_8250_SHARE_IRQ if SERIAL_8250
    default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
        || MPC85xx_MDS || MPC85xx_DS

My .config has the following configuration for PCI ( I am showing the PCI
configuration b/c 8544 seems to have different interrupt setup when PCIE is
configured)

CONFIG_ZONE_DMA=y
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
CONFIG_PPC_INDIRECT_PCI=y
CONFIG_FSL_SOC=y
CONFIG_FSL_PCIE=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_DEBUG=y

My device tree has the following entry for my fpga:

CpuCpld\@f0000000{
                        compatible = "MPC8544DS";
                        device_type = "CpuCpld";
                        reg = <f0000000 00000040>;
                        interrupts = <41 2 42 2 43 2>;
                        interrupt-parent = <&mpic>;
};

My driver does the mapping to the virq:

 np = of_find_node_by_type(NULL, "CpuCpld");
    if (!np) {
        ret = -ENODEV;
    }
    cpldCpuDrv->MateIntIrq = irq_of_parse_and_map(np, 0);
    cpldCpuDrv->FtaIrq =  irq_of_parse_and_map(np, 1);
    cpldCpuDrv->ExtractIrq =  irq_of_parse_and_map(np, 2);
    cpldCpuDrv->XauiIrq =  irq_of_parse_and_map(np, 0);

    of_node_put(np);

Does anyone know what the virq should be for these external interrupts?
I've tried specifying the actual irq numbers 1,2 and 3 and that doesn't work
either.
Is there some PCI configuration that's getting in the way?  I've tried
disabling the FSL_PCIE and I get the same behavior.

Any help or pointers will be appreciated.

Thanks
Nancy

--000e0cd670120dbbed046afda612
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I have a custom board that&#39;s using powerpc 8544. I am trying=
 to setup the external interrupts using the device tree and I am having no =
luck getting the interrupt.=A0 I think my problem is that I don&#39;t have =
the hwirq to virq mapping correctly. We are using the freescale 8544ds as o=
ur base.=A0 We have a PCI bus but we are not using PCIE.=A0 In my kernel co=
nfiguration, I have CONFIG_PCIEPORTBUS disabled.=A0 The PCI interrupt is co=
nnected to IRQ0 and it is working fine.=A0 But, my FPGA has three interrupt=
s, IRQ1, IRQ2 and IRQ3.=A0 I configure this in the device tree and I&#39;ve=
 tried many different numbers for the interrupt. <br>
<br>In the KConfig for ppc85xx, the configuration is the following<br><br>c=
onfig MPC85xx_DS<br>=A0=A0=A0 bool &quot;Freescale MPC8544 DS&quot;<br>=A0=
=A0=A0 #select PPC_I8259<br>=A0=A0=A0 select DEFAULT_UIMAGE<br>=A0=A0=A0 se=
lect FSL_PCIE<br><br>
config MPC85xx<br>=A0=A0=A0 bool<br>=A0=A0=A0 select PPC_UDBG_16550<br>=A0=
=A0=A0 select PPC_INDIRECT_PCI<br>=A0=A0=A0 select FSL_PCIE<br>=A0=A0=A0 se=
lect SERIAL_8250_SHARE_IRQ if SERIAL_8250<br>=A0=A0=A0 default y if MPC8540=
_ADS || MPC85xx_CDS || MPC8560_ADS \<br>
=A0=A0=A0=A0=A0=A0=A0 || MPC85xx_MDS || MPC85xx_DS<br><br>My .config has th=
e following configuration for PCI ( I am showing the PCI configuration b/c =
8544 seems to have different interrupt setup when PCIE is configured)<br><b=
r>CONFIG_ZONE_DMA=3Dy<br>
# CONFIG_MPIC_WEIRD is not set<br># CONFIG_PPC_I8259 is not set<br>CONFIG_P=
PC_INDIRECT_PCI=3Dy<br>CONFIG_FSL_SOC=3Dy<br>CONFIG_FSL_PCIE=3Dy<br>CONFIG_=
PCI=3Dy<br>CONFIG_PCI_DOMAINS=3Dy<br># CONFIG_PCIEPORTBUS is not set<br>CON=
FIG_PCI_DEBUG=3Dy<br>
<br>My device tree has the following entry for my fpga:<br><br>CpuCpld\@f00=
00000{<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 compatible =3D &quot;MPC8544DS&quot;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 device_type =3D &quot;CpuCpld&qu=
ot;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 reg =3D &lt;f0000000 00000040&gt;;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inter=
rupts =3D &lt;41 2 42 2 43 2&gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D &lt;&amp;mpic&gt;;<b=
r>};<br><br>My driver does the mapping to the virq:<br><br>=A0np =3D of_fin=
d_node_by_type(NULL, &quot;CpuCpld&quot;);<br>
=A0=A0=A0 if (!np) {<br>=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENODEV;<br>=A0=A0=A0=
 }<br>=A0=A0=A0 cpldCpuDrv-&gt;MateIntIrq =3D irq_of_parse_and_map(np, 0);<=
br>=A0=A0=A0 cpldCpuDrv-&gt;FtaIrq =3D=A0 irq_of_parse_and_map(np, 1);<br>=
=A0=A0=A0 cpldCpuDrv-&gt;ExtractIrq =3D=A0 irq_of_parse_and_map(np, 2);<br>
=A0=A0=A0 cpldCpuDrv-&gt;XauiIrq =3D=A0 irq_of_parse_and_map(np, 0);<br><br=
>=A0=A0=A0 of_node_put(np);<br><br>Does anyone know what the virq should be=
 for these external interrupts?<br>I&#39;ve tried specifying the actual irq=
 numbers 1,2 and 3 and that doesn&#39;t work either.<br>
Is there some PCI configuration that&#39;s getting in the way?=A0 I&#39;ve =
tried disabling the FSL_PCIE and I get the same behavior.<br><br>Any help o=
r pointers will be appreciated.<br><br>Thanks<br>Nancy<br><br><br>

--000e0cd670120dbbed046afda612--

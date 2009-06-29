Return-Path: <j.s.denova@gmail.com>
MIME-Version: 1.0
Date: Mon, 29 Jun 2009 17:25:16 +0200
Message-ID: <621779fd0906290825i6bdc1e99tf6be68e3de56e9a6@mail.gmail.com>
Subject: Device tree for c67x00
From: =?ISO-8859-1?Q?Jorge_S=E1nchez_de_Nova?= <j.s.denova@gmail.com>
To: Linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0015174c13aa0fadc4046d7e4c93
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0015174c13aa0fadc4046d7e4c93
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

 I am trying to load the c67x00 driver in my Xilinx ML403 (PowerPC) based
platform. I am running a merged tree between DENX+Adeos/Xenomai and Xilinx
(2.6.29.4). I have the XPS_EPC core interfaced to the Cypress CY7C67300.
Before, in PPC I used to have something like this in my virtex_devices.c

/*
 * Cypress USB C67x00 shortcut macro for single instance
 */
#define XPAR_C67x00_USB(num) { \
 .name = "c67x00", \
 .id = num, \
 .num_resources = 2, \
 .resource = (struct resource[]) { \
         { \
         .start = XPAR_C67X00_USB_PRH##num##_BASEADDR, \
         .end = XPAR_C67X00_USB_PRH##num##_BASEADDR + 0xf, \
         .flags = IORESOURCE_MEM, \
         }, \
         { \
         .start  = XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_PIN_INTR, \
         .end    = XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_PIN_INTR, \
         .flags  = IORESOURCE_IRQ, \
          }, \
  }, \
 .dev.platform_data = &(struct c67x00_platform_data) { \
 .sie_config = C67X00_SIE1_HOST | C67X00_SIE2_PERIPHERAL_A, \
 .hpi_regstep = 0x02, /* A0 not connected on 16bit bus */ \
 }, \
}

Together with the xparameters.h #defines. And even if I never managed to get
it working, the kernel was loading it. Now I am trying to have the
equivalent information in the device-tree .dts with no luck. Something like
this:

                xps_epc_0: usb@80800000 {
          compatible = "cy,c67300 cy,c67x00";
                  interrupt-parent = <&xps_intc_0>;
          interrupts = < 0 2 >;
                  reg = < 0x80800000 0x10000 >;
            xlnx,family = "virtex4";
                  } ;

(inspired by another mail in this list).

It doesn't work at all since it doesn't load anything. I have looked at the
driver and there is apparently no openfirmware support for it, so maybe the
dts info won't work without it. Am I wrong? Does this means that the c67x00
needs OF support to work in this configuration? How can I make it otherwise?


Thanks,
Jorge

--0015174c13aa0fadc4046d7e4c93
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi, <br><br>=A0I am trying to load the c67x00 driver in my Xilinx ML403 (Po=
werPC) based platform. I am running a merged tree between DENX+Adeos/Xenoma=
i and Xilinx (2.6.29.4). I have the XPS_EPC core interfaced to the Cypress =
CY7C67300. Before, in PPC I used to have something like this in my virtex_d=
evices.c <br>
<br>/*<br>=A0* Cypress USB C67x00 shortcut macro for single instance<br>=A0=
*/<br>#define XPAR_C67x00_USB(num) { \<br>=A0.name =3D &quot;c67x00&quot;, =
\<br>=A0.id =3D num, \<br>=A0.num_resources =3D 2, \<br>=A0.resource =3D (s=
truct resource[]) { \<br>
=A0=A0=A0 =A0=A0=A0 =A0{ \<br>=A0=A0=A0 =A0=A0=A0 =A0.start =3D XPAR_C67X00=
_USB_PRH##num##_BASEADDR, \<br>=A0=A0=A0 =A0=A0=A0 =A0.end =3D XPAR_C67X00_=
USB_PRH##num##_BASEADDR + 0xf, \<br>=A0=A0=A0 =A0=A0=A0 =A0.flags =3D IORES=
OURCE_MEM, \<br>=A0=A0=A0 =A0=A0=A0 =A0}, \<br>=A0=A0=A0 =A0=A0=A0 =A0{ \<b=
r>=A0=A0=A0 =A0=A0=A0 =A0.start=A0 =3D XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT_P=
IN_INTR, \<br>
=A0=A0=A0 =A0=A0=A0 =A0.end=A0=A0=A0 =3D XPAR_OPB_INTC_0_SYSTEM_USB_HPI_INT=
_PIN_INTR, \<br>=A0=A0=A0 =A0=A0=A0 =A0.flags=A0 =3D IORESOURCE_IRQ, \<br>=
=A0=A0=A0 =A0=A0=A0 =A0 }, \<br>=A0 }, \<br>=A0.dev.platform_data =3D &amp;=
(struct c67x00_platform_data) { \<br>=A0.sie_config =3D C67X00_SIE1_HOST | =
C67X00_SIE2_PERIPHERAL_A, \<br>
=A0.hpi_regstep =3D 0x02, /* A0 not connected on 16bit bus */ \<br>=A0}, \<=
br>}<br><br>Together with the xparameters.h #defines. And even if I never m=
anaged to get it working, the kernel was loading it. Now I am trying to hav=
e the equivalent information in the device-tree .dts with no luck. Somethin=
g like this: <br>
<br>=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 xps_epc_0: usb@80800000 {<br>=
=A0=A0=A0 =A0=A0=A0 =A0 compatible =3D &quot;cy,c67300 cy,c67x00&quot;;<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 interrupt-parent =3D &l=
t;&amp;xps_intc_0&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0 interrupts =3D &lt; 0 2 &=
gt;;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 reg =3D &lt; 0x=
80800000 0x10000 &gt;;<br>
=A0 =A0=A0=A0 =A0=A0=A0 =A0 xlnx,family =3D &quot;virtex4&quot;;<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } ;<br><br>(inspired by anoth=
er mail in this list). <br><br>It doesn&#39;t work at all since it doesn&#3=
9;t load anything. I have looked at the driver and there is apparently no o=
penfirmware support for it, so maybe the dts info won&#39;t work without it=
. Am I wrong? Does this means that the c67x00 needs OF support to work in t=
his configuration? How can I make it otherwise? <br>
<br>Thanks, <br>Jorge<br>

--0015174c13aa0fadc4046d7e4c93--

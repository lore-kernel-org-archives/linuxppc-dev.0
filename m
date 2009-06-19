Return-Path: <lada.podivin@gmail.com>
Received: from mail-fx0-f213.google.com (mail-fx0-f213.google.com
	[209.85.220.213])
	by bilbo.ozlabs.org (Postfix) with ESMTP id BA7EAB72FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 18:00:55 +1000 (EST)
Received: by fxm9 with SMTP id 9so1842419fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 01:00:52 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 19 Jun 2009 10:00:52 +0200
Message-ID: <e35801cc0906190100i1a0429eahade975319b5246df@mail.gmail.com>
Subject: kilauea/405ex external interrupts
From: Lada Podivin <lada.podivin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001485f7c48e5cb8c2046caeecbd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001485f7c48e5cb8c2046caeecbd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,
I'm writing a linux driver that uses an external interrupt (ppc 405ex). I'm
using GPIO pin 30 (external IRQ 1) connected to UIC1. I'm aware of the
virtual interrupt stuff, so I added a new node to my device tree in order to
get proper virtual IRQ number. This node describes an external event and its
connection to UIC via the mentioned ext. int. Here is a sample of the
divce-tree:
...

UIC1: interrupt-controller1 {
        compatible = "ibm,uic-405ex","ibm,uic";
        interrupt-controller;
        cell-index = <1>;
        dcr-reg = <0x0d0 0x009>;
        #address-cells = <0>;
        #size-cells = <0>;
        #interrupt-cells = <2>;
        interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
        interrupt-parent = <&UIC0>;
};

EXTEVENT: external_event {
        device_type = "external";
        #address-cells = <0>;
        #size-cells = <0>;
        #interrupt-cells = <2>;
        interrupts = <0x1e 0x1>;
        interrupt-parent = <&UIC1>;
};
...

Then I use function "irq_of_parse_and_map()" which returns the virtual IRQ
number 22. So, "request_irq()" seems to be satisfied with this number. I can
see this interrupt in the /proc/interrupts. But! When I connect a signal
source to the pin 30, nothing happens - the interrupt service routine isn't
called.

Am I suppose to configure anything else? (e. g. pin multiplexing, further
device-tree tuning...) Thank you!

Best regards,
Ladi

--001485f7c48e5cb8c2046caeecbd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>I&#39;m writing a linux driver that uses an external interrupt (ppc =
405ex). I&#39;m using GPIO pin 30 (external IRQ 1) connected to UIC1. I&#39=
;m aware of the virtual interrupt stuff, so I added a new node to my device=
 tree in order to get proper virtual IRQ number. This node describes an ext=
ernal event and its connection to UIC via the mentioned ext. int. Here is a=
 sample of the divce-tree:<br>
...<br><br>UIC1: interrupt-controller1 {<br>=A0=A0=A0 =A0=A0=A0 compatible =
=3D &quot;ibm,uic-405ex&quot;,&quot;ibm,uic&quot;;<br>=A0=A0=A0 =A0=A0=A0 i=
nterrupt-controller;<br>=A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;1&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 dcr-reg =3D &lt;0x0d0 0x009&gt;;<br>
=A0=A0=A0 =A0=A0=A0 #address-cells =3D &lt;0&gt;;<br>=A0=A0=A0 =A0=A0=A0 #s=
ize-cells =3D &lt;0&gt;;<br>=A0=A0=A0 =A0=A0=A0 #interrupt-cells =3D &lt;2&=
gt;;<br>=A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x1e 0x4 0x1f 0x4&gt;; /* ca=
scade */<br>=A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;&amp;UIC0&gt;;<br>
};<br><br>EXTEVENT: external_event {<br>=A0=A0=A0 =A0=A0=A0 device_type =3D=
 &quot;external&quot;;<br>=A0=A0=A0 =A0=A0=A0 #address-cells =3D &lt;0&gt;;=
<br>=A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0&gt;;<br>=A0=A0=A0 =A0=A0=A0 #=
interrupt-cells =3D &lt;2&gt;;<br>=A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x=
1e 0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;&amp;UIC1&gt;;<br>};<br>...<br=
><br>Then I use function &quot;irq_of_parse_and_map()&quot; which returns t=
he virtual IRQ number 22. So, &quot;request_irq()&quot; seems to be satisfi=
ed with this number. I can see this interrupt in the /proc/interrupts. But!=
 When I connect a signal source to the pin 30, nothing happens - the interr=
upt service routine isn&#39;t called. <br>
<br>Am I suppose to configure anything else? (e. g. pin multiplexing, furth=
er device-tree tuning...) Thank you!<br><br>Best regards,<br>Ladi<br>

--001485f7c48e5cb8c2046caeecbd--

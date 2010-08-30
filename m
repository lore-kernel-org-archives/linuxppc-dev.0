Return-Path: <deebuls@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id D46F0B70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 16:02:07 +1000 (EST)
Received: by ywg8 with SMTP id 8so2086812ywg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 29 Aug 2010 23:02:05 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 30 Aug 2010 11:32:05 +0530
Message-ID: <AANLkTim5FXeRvx2TiPMGSkwqdbOeei6bL5PebK7+toLZ@mail.gmail.com>
Subject: MPC85xx - accessing external interrupt
From: deebul nair <deebuls@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001636164a55322faf048f0434c5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636164a55322faf048f0434c5
Content-Type: text/plain; charset=ISO-8859-1

Hi all

I am trying to use the external interrupts on the Powerpc architecture
MPC8542 .

My  problem is that my driver is trying to request the external
interrupt IRQ1, and I dont know what number use in INTR_NUM:

request_irq(INTR_NUM, , , , )

As per the MPC85xx documentation
Documentation/powerpc/dts-bindings/fsl/mpic.txt
about the implementation of interrupts virtual numbers
the external interrupt virtual irq number for IRQ1 should be 1

but when i try to give INTR_NUM ins request_irq as 1 it gives error .

When i use irq_create_mapping() it gives me output as 16.. and it registers
.. but the problem is it is not fixed
neither it gives interrupts .
when i remove and add it registers to some other addresses

i even tried irq_of_parse_map()

for_each_node_by_type(np,"interrupt-controller"){
    if(of_device_is_compatible(np,"chrp,open-pic")){
           found=np;
           break;
}
}

virq = irq_of_parse_and_map(found, irq);

this always returns 0
whatever may be the irq value..
as a result the driver gives error for irq 0



-- 
Cheeers

Deebul !!!!!!

--001636164a55322faf048f0434c5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><br clear=3D"all">Hi all </div>
<div>=A0</div>
<div>I am trying to use the external interrupts on the Powerpc architecture=
 MPC8542 .</div>
<div>=A0</div>
<div>My=A0 problem is that my driver is trying to request the external <br>=
interrupt IRQ1, and I dont know what number use in INTR_NUM: <br><br>reques=
t_irq(INTR_NUM, , , , ) </div>
<div>=A0</div>
<div>As per the MPC85xx documentation Documentation/powerpc/dts-bindings/fs=
l/mpic.txt </div>
<div>about the implementation of interrupts virtual numbers </div>
<div>the external interrupt=A0virtual irq number=A0for IRQ1 should be=A01</=
div>
<div>=A0</div>
<div>but when i try to give INTR_NUM ins request_irq as 1 it gives error .<=
/div>
<div>=A0</div>
<div>When i use irq_create_mapping() it gives me output as 16.. and it regi=
sters .. but the problem is it is not fixed </div>
<div>neither it gives interrupts .</div>
<div>when i remove and add it registers to some other addresses</div>
<div>=A0</div>
<div>i even tried irq_of_parse_map()</div>
<div>=A0</div>
<div>for_each_node_by_type(np,&quot;interrupt-controller&quot;){</div>
<div>=A0=A0=A0 if(of_device_is_compatible(np,&quot;chrp,open-pic&quot;)){</=
div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 found=3Dnp;</div>
<div>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;</div>
<div>}</div>
<div>}</div>
<div><br>virq =3D irq_of_parse_and_map(found, irq);</div>
<div>=A0</div>
<div>this always returns 0</div>
<div>whatever may be the irq value..</div>
<div>as a result the driver gives error for irq 0</div>
<div>=A0</div>
<div><br><br>-- <br>Cheeers<br><br>Deebul !!!!!!<br><br></div>

--001636164a55322faf048f0434c5--

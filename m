Return-Path: <wangbj.ml@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CE433B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 00:27:43 +1000 (EST)
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195]) by ozlabs.org (Postfix) with ESMTP id 0DE8BDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 00:27:42 +1000 (EST)
Received: by yxe33 with SMTP id 33so2024398yxe.17
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2009 07:27:40 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 14 Aug 2009 22:27:39 +0800
Message-ID: <17dc9c530908140727l6423bebawaed8808f195d4d20@mail.gmail.com>
Subject: Configure CPM2 PORTC pin (PC9) for external interrupt?
From: Baojun Wang <wangbj.ml@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=001636ed667abd995804711ada16
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636ed667abd995804711ada16
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

hi, list:

  I need to configure CPM2 PORTC pin (PC9) for external interrupt, when I
read the MPC8555ERM.pdf and cpm2-pic.c, I find that PC9 interrupt number is
56, and I request the IRQ in this way:

  hw_irq = 56;
  virq = irq_create_mapping(cpm2_host, hw_irq);

  reqeust_irq(virq, ...);

  I can request the irq successfully, but the interrupt is never generated
(ISR is not called) to the PC9 pins, even though the hardware said an
interrupt was raised. (the hardware have a register with a special bit)

  Should I configure the cpm2 io port first to allow PORTC interrupt? I have
read the cpm2 io port documentation, and I initialize the PC9 as:

  PPARC[pc9_bit] = 0;    /* for general purpose IO, not dedicated */
  PSORC[pc9_bit] = 0;    /* no special option */
  PDIRC[pc9_bit] = 0;     /* for both input/output */

  Am I missing some thing? Any suggestion will be greatly appreciated.

  Best Regards,
- Wang

--001636ed667abd995804711ada16
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi, list:<br><br>=A0 I need to configure CPM2 PORTC pin (PC9) for external =
interrupt, when I read the MPC8555ERM.pdf and cpm2-pic.c, I find that PC9 i=
nterrupt number is 56, and I request the IRQ in this way:<br><br>=A0 hw_irq=
 =3D 56;<br>
=A0 virq =3D irq_create_mapping(cpm2_host, hw_irq);<br><br>=A0 reqeust_irq(=
virq, ...);<br><br>=A0 I can request the irq successfully, but the interrup=
t is never generated (ISR is not called) to the PC9 pins, even though the h=
ardware said an interrupt was raised. (the hardware have a register with a =
special bit)<br>
<br>=A0 Should I configure the cpm2 io port first to allow PORTC interrupt?=
 I have read the cpm2 io port documentation, and I initialize the PC9 as:<b=
r><br>=A0 PPARC[pc9_bit] =3D 0;=A0=A0=A0 /* for general purpose IO, not ded=
icated */<br>
=A0 PSORC[pc9_bit] =3D 0;=A0=A0=A0 /* no special option */<br>=A0 PDIRC[pc9=
_bit] =3D 0;=A0=A0=A0=A0 /* for both input/output */<br>=A0 <br>=A0 Am I mi=
ssing some thing? Any suggestion will be greatly appreciated.<br><br>=A0 Be=
st Regards,<br>- Wang<br>

--001636ed667abd995804711ada16--

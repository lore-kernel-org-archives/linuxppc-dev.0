Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 4BC88DDF77
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 15:57:36 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1375292yxb.39
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Mar 2009 21:57:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <44C5CFA72BC0E242A53B64DC1E67DEB80A695E7512@SI-MBX10.de.bosch.com>
References: <44C5CFA72BC0E242A53B64DC1E67DEB80A695E6FE2@SI-MBX10.de.bosch.com>
	<fa686aa40903120632yb46c34bxdecf21f01996bf42@mail.gmail.com>
	<44C5CFA72BC0E242A53B64DC1E67DEB80A695E7512@SI-MBX10.de.bosch.com>
Date: Sun, 15 Mar 2009 22:57:34 -0600
Message-ID: <fa686aa40903152157u558727a8ydebbfa49480d71a8@mail.gmail.com>
Subject: Re: DTS device tree node for dual port RAM
From: Grant Likely <grant.likely@secretlab.ca>
To: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2009 at 9:19 AM, EXTERNAL Lange Matthias (AA-DGW/ENG1)
<Matthias.Lange@beissbarth.com> wrote:
>> What hardware irq# are you using? =A0See this link for a description of
>> what the interrupts property should look like for external IRQs:
>
> I am using hardware irq# 0 which is wired to the critical input line. Tha=
t's why I was defining the interrupts property to <0 0 0>. So my device tre=
e node now looks like this

Okay, good.  I just wanted to make sure.

> dpram@40000000 {
> =A0 =A0 =A0 =A0compatible =3D "beissbarth,orion-dpram";
> =A0 =A0 =A0 =A0interrupts =3D <0 0 0>;
> =A0 =A0 =A0 =A0interrupt-parent =3D <&mpc5200_pic>;
> };

This is unrelated to your question, but I'm wondering why you don't
have a reg property in your node.

> If I am understanding it correctly I now need to implement a OF platform =
driver in which I can use irq_of_parse_and_map() to get the virq for my dev=
ice.

That is the easiest way, yes.  Actually, all you need to call
irq_of_parse_and_map() is a pointer to the device_node which can be
obtained by directly searching the tree.  However, writing an
of_platform driver is a better way to get the device_node in this
case.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

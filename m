Return-Path: <Matthias.Lange@beissbarth.com>
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by ozlabs.org (Postfix) with ESMTP id 16F97DE0BD
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 02:19:27 +1100 (EST)
Received: from vsmta3.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta6.fe.bosch.de (Postfix) with ESMTP id 72BDF37005A
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 16:15:55 +0100 (CET)
Received: from fe-imc01.de.bosch.com (vsgw3.fe.internet.bosch.com [10.4.98.16])
	by vsmta3.fe.internet.bosch.com (Postfix) with ESMTP id 1DE467B80E3
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 16:19:25 +0100 (CET)
From: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
To: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
Date: Thu, 12 Mar 2009 16:19:22 +0100
Subject: RE: DTS device tree node for dual port RAM
Message-ID: <44C5CFA72BC0E242A53B64DC1E67DEB80A695E7512@SI-MBX10.de.bosch.com>
References: <44C5CFA72BC0E242A53B64DC1E67DEB80A695E6FE2@SI-MBX10.de.bosch.com>
	<fa686aa40903120632yb46c34bxdecf21f01996bf42@mail.gmail.com>
In-Reply-To: <fa686aa40903120632yb46c34bxdecf21f01996bf42@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:
> linuxppc-dev-bounces+matthias.lange=3Dbeissbarth.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+matthias.lange=3Dbeissbarth.com@ozl
> abs.org] On Behalf Of Grant Likely
> Sent: Thursday, March 12, 2009 2:32 PM
> To: EXTERNAL Lange Matthias (AA-DGW/ENG1)
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: DTS device tree node for dual port RAM
>
> On Thu, Mar 12, 2009 at 5:24 AM, EXTERNAL Lange Matthias (AA-DGW/ENG1)
> <Matthias.Lange@beissbarth.com> wrote:
> > Hi,

[...]

>
> >                interrupts =3D <0 0 0>;
>
> What hardware irq# are you using?  See this link for a description of
> what the interrupts property should look like for external IRQs:

I am using hardware irq# 0 which is wired to the critical input line. That'=
s why I was defining the interrupts property to <0 0 0>. So my device tree =
node now looks like this

dpram@40000000 {
        compatible =3D "beissbarth,orion-dpram";
        interrupts =3D <0 0 0>;
        interrupt-parent =3D <&mpc5200_pic>;
};

If I am understanding it correctly I now need to implement a OF platform dr=
iver in which I can use irq_of_parse_and_map() to get the virq for my devic=
e.

Regards,
Matthias Lange.

>
> http://patchwork.ozlabs.org/patch/11349/
>
> To use this property, the irq_of_parse_and_map() function will
> translate from the device tree to a Linux IRQ number.
>
> >                interrupt-parent =3D <&mpc5200_pic>;
>
> You probably also want a reg =3D <0 0 0x00400000>; property for mapping
> the address range.
>
> >        };
> > };
> >
> > What am I doing wrong? What am I missing?
> >
> > Thanks,
> > Matthias Lange.
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

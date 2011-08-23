Return-Path: <B35362@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6A0D4B6F9B
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 19:52:02 +1000 (EST)
Message-ID: <4E53798D.7050307@freescale.com>
Date: Tue, 23 Aug 2011 17:57:33 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron>
	<20110822152530.GA16794@parrot.com>
	<4E527E0F.1010500@freescale.com> <4E528036.5070801@parrot.com>
	<4E52819C.8080204@freescale.com> <4E5319E8.50903@freescale.com>
	<4E53614E.2070103@parrot.com>
In-Reply-To: <4E53614E.2070103@parrot.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Li Yang-R58472 <r58472@freescale.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Scott Wood <scottwood@freescale.com>, Ivan Djelic <ivan.djelic@parrot.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E4=BA=8E 2011=E5=B9=B408=E6=9C=8823=E6=97=A5 16:14, Matthieu CASTET =E5=86=
=99=E9=81=93:
> LiuShuo a =C3=A9crit :
>> =E4=BA=8E 2011=E5=B9=B408=E6=9C=8823=E6=97=A5 00:19, Scott Wood =E5=86=
=99=E9=81=93:
>>> On 08/22/2011 11:13 AM, Matthieu CASTET wrote:
>>>> Scott Wood a =C3=A9crit :
>>>>> To eliminate it we'd need to do an extra data transfer without reis=
suing
>>>>> the command, which Shuo was unable to get to work.
>>>>>
>>>> That's weird because our controller seems quite flexible [1].
>>>>
>>>> Something like that should work ?
>>>>
>>>>               out_be32(&lbc->fir,
>>>>                        (FIR_OP_CM2<<   FIR_OP0_SHIFT) |
>>>>                        (FIR_OP_CA<<   FIR_OP1_SHIFT) |
>>>>                        (FIR_OP_PA<<   FIR_OP2_SHIFT) |
>>>>                        (FIR_OP_WB<<   FIR_OP3_SHIFT));
>>>> refill FCM buffer with next 2k data
>>>>
>>>>               out_be32(&lbc->fir,
>>>>                        (FIR_OP_WB<<   FIR_OP3_SHIFT) |
>>>>                        (FIR_OP_CM3<<   FIR_OP4_SHIFT) |
>>>>                        (FIR_OP_CW1<<   FIR_OP5_SHIFT) |
>>>>                        (FIR_OP_RS<<   FIR_OP6_SHIFT));
>>> Something like that is what I originally suggested, but Shuo said it
>>> didn't work (even in theory, it requires a CE-don't-care NAND chip,
>>> since bus atomicity is broken).
>>>
>>> Shuo, what specifically did you try, and what did you see happen?
>>>
>>> -Scott
>> First, if we want to read 4K data with once command issuing, we can't
>> use HW_ECC.
> Yes, but as ivan said doesn't the cost of 2 read isn't bigger than soft=
ware ecc ?
>
>> Even if we use SW_ECC, we always get lots of weird '0xFF's between 1st
>> 2k and 2nd 2k data.
> Did you understand where those 0xff comes (what's the size of them. Doe=
sn't the
> controller try to insert spare aera ?)
I don't understand. I set FBCR to 2048, the controller will read the=20
main area without spare area.
But the size of them is nearly spare area size( more or less a few bytes)=
.
I can't guess the behavior of the controller then, so I select another wa=
y.

Could you try to do it and explain how those 0xff comes ?
> Could you detail the sequence you used ?
>
First half :
                   out_be32(&lbc->fbcr, 2048);
                   out_be32(&lbc->fir,
                            (FIR_OP_CM0 << FIR_OP0_SHIFT) |
                            (FIR_OP_CA << FIR_OP1_SHIFT) |
                            (FIR_OP_PA << FIR_OP2_SHIFT) |
                            (FIR_OP_CM1 << FIR_OP3_SHIFT) |
                            (FIR_OP_RBW << FIR_OP4_SHIFT));


Sencond half :
                 out_be32(&lbc->fbcr, 2048);
                 out_be32(&lbc->fir,
                            (FIR_OP_RB << FIR_OP0_SHIFT) |
                            (FIR_OP_RBW << FIR_OP1_SHIFT));


-Liu Shuo

> Matthieu
>
>

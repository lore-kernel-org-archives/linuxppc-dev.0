Return-Path: <matthieu.castet@parrot.com>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
	by ozlabs.org (Postfix) with ESMTP id 406E5B6F8A
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 20:13:59 +1000 (EST)
Message-ID: <4E537D64.2000504@parrot.com>
Date: Tue, 23 Aug 2011 12:13:56 +0200
From: Matthieu CASTET <matthieu.castet@parrot.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron>
	<20110822152530.GA16794@parrot.com>
	<4E527E0F.1010500@freescale.com> <4E528036.5070801@parrot.com>
	<4E52819C.8080204@freescale.com> <4E5319E8.50903@freescale.com>
	<4E53614E.2070103@parrot.com> <4E53798D.7050307@freescale.com>
In-Reply-To: <4E53798D.7050307@freescale.com>
Content-Type: text/plain; charset="UTF-8"
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

LiuShuo a écrit :
> 于 2011年08月23日 16:14, Matthieu CASTET 写道:
>> LiuShuo a écrit :
>>> 于 2011年08月23日 00:19, Scott Wood 写道:
>>>> On 08/22/2011 11:13 AM, Matthieu CASTET wrote:
>>>>> Scott Wood a écrit :
>>>>>> To eliminate it we'd need to do an extra data transfer without reissuing
>>>>>> the command, which Shuo was unable to get to work.
>>>>>>
>>>>> That's weird because our controller seems quite flexible [1].
>>>>>
>>>>> Something like that should work ?
>>>>>
>>>>>               out_be32(&lbc->fir,
>>>>>                        (FIR_OP_CM2<<   FIR_OP0_SHIFT) |
>>>>>                        (FIR_OP_CA<<   FIR_OP1_SHIFT) |
>>>>>                        (FIR_OP_PA<<   FIR_OP2_SHIFT) |
>>>>>                        (FIR_OP_WB<<   FIR_OP3_SHIFT));
>>>>> refill FCM buffer with next 2k data
>>>>>
>>>>>               out_be32(&lbc->fir,
>>>>>                        (FIR_OP_WB<<   FIR_OP3_SHIFT) |
>>>>>                        (FIR_OP_CM3<<   FIR_OP4_SHIFT) |
>>>>>                        (FIR_OP_CW1<<   FIR_OP5_SHIFT) |
>>>>>                        (FIR_OP_RS<<   FIR_OP6_SHIFT));
>>>> Something like that is what I originally suggested, but Shuo said it
>>>> didn't work (even in theory, it requires a CE-don't-care NAND chip,
>>>> since bus atomicity is broken).
>>>>
>>>> Shuo, what specifically did you try, and what did you see happen?
>>>>
>>>> -Scott
>>> First, if we want to read 4K data with once command issuing, we can't
>>> use HW_ECC.
>> Yes, but as ivan said doesn't the cost of 2 read isn't bigger than software ecc ?
>>
>>> Even if we use SW_ECC, we always get lots of weird '0xFF's between 1st
>>> 2k and 2nd 2k data.
>> Did you understand where those 0xff comes (what's the size of them. Doesn't the
>> controller try to insert spare aera ?)
> I don't understand. I set FBCR to 2048, the controller will read the 
> main area without spare area.
> But the size of them is nearly spare area size( more or less a few bytes)..
> I can't guess the behavior of the controller then, so I select another way.
> 
> Could you try to do it and explain how those 0xff comes ?
>> Could you detail the sequence you used ?
>>
> First half :
>                    out_be32(&lbc->fbcr, 2048);
shouldn't you read 2k+64 here ? At the end you want 4k plus spare aera (128) ?

>                    out_be32(&lbc->fir,
>                             (FIR_OP_CM0 << FIR_OP0_SHIFT) |
>                             (FIR_OP_CA << FIR_OP1_SHIFT) |
>                             (FIR_OP_PA << FIR_OP2_SHIFT) |
>                             (FIR_OP_CM1 << FIR_OP3_SHIFT) |
>                             (FIR_OP_RBW << FIR_OP4_SHIFT));
> 
> 
> Sencond half :
>                  out_be32(&lbc->fbcr, 2048);
>                  out_be32(&lbc->fir,
>                             (FIR_OP_RB << FIR_OP0_SHIFT) |
>                             (FIR_OP_RBW << FIR_OP1_SHIFT));
Why do you do FIR_OP_RBW ?
FIR_OP_RB already fetch the data.

Matthieu

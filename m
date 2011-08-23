Return-Path: <B35362@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 819AAB6F8D
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 13:03:55 +1000 (EST)
Message-ID: <4E5319E8.50903@freescale.com>
Date: Tue, 23 Aug 2011 11:09:28 +0800
From: LiuShuo <b35362@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>
	<4E4D452C.7050805@parrot.com> <4E4DD661.5080006@freescale.com>
	<4E4E2571.20409@parrot.com> <4E4EA70B.9050203@freescale.com>
	<1314010719.2644.114.camel@sauron>
	<20110822152530.GA16794@parrot.com>
	<4E527E0F.1010500@freescale.com> <4E528036.5070801@parrot.com>
	<4E52819C.8080204@freescale.com>
In-Reply-To: <4E52819C.8080204@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Li Yang-R58472 <r58472@freescale.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Matthieu CASTET <matthieu.castet@parrot.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	Ivan Djelic <ivan.djelic@parrot.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=E4=BA=8E 2011=E5=B9=B408=E6=9C=8823=E6=97=A5 00:19, Scott Wood =E5=86=99=
=E9=81=93:
> On 08/22/2011 11:13 AM, Matthieu CASTET wrote:
>> Scott Wood a =C3=A9crit :
>>> To eliminate it we'd need to do an extra data transfer without reissu=
ing
>>> the command, which Shuo was unable to get to work.
>>>
>> That's weird because our controller seems quite flexible [1].
>>
>> Something like that should work ?
>>
>>              out_be32(&lbc->fir,
>>                       (FIR_OP_CM2<<  FIR_OP0_SHIFT) |
>>                       (FIR_OP_CA<<  FIR_OP1_SHIFT) |
>>                       (FIR_OP_PA<<  FIR_OP2_SHIFT) |
>>                       (FIR_OP_WB<<  FIR_OP3_SHIFT));
>> refill FCM buffer with next 2k data
>>
>>              out_be32(&lbc->fir,
>>                       (FIR_OP_WB<<  FIR_OP3_SHIFT) |
>>                       (FIR_OP_CM3<<  FIR_OP4_SHIFT) |
>>                       (FIR_OP_CW1<<  FIR_OP5_SHIFT) |
>>                       (FIR_OP_RS<<  FIR_OP6_SHIFT));
> Something like that is what I originally suggested, but Shuo said it
> didn't work (even in theory, it requires a CE-don't-care NAND chip,
> since bus atomicity is broken).
>
> Shuo, what specifically did you try, and what did you see happen?
>
> -Scott
First, if we want to read 4K data with once command issuing, we can't=20
use HW_ECC.
Even if we use SW_ECC, we always get lots of weird '0xFF's between 1st=20
2k and 2nd 2k data.
They will cover the data in the head of 2nd 2K.
  -----------------------------------------------------------------------=
--------------
| xxxxxx ... 1st 2k xxxxxxx ... | ff ff ff ... ff xxxxxx 2nd 2k xxxxxxx |
  -----------------------------------------------------------------------=
--------------

It is worse to write 4k data with once command issuing. It can't write=20
the 2nd data correctly.

-Liu Shuo

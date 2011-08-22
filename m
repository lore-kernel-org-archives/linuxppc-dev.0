Return-Path: <matthieu.castet@parrot.com>
Received: from co202.xi-lite.net (co202.xi-lite.net [149.6.83.202])
	by ozlabs.org (Postfix) with ESMTP id 69968B6F72
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 03:05:12 +1000 (EST)
Message-ID: <4E528C45.5060704@parrot.com>
Date: Mon, 22 Aug 2011 19:05:09 +0200
From: Matthieu CASTET <matthieu.castet@parrot.com>
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
Content-Type: text/plain; charset="UTF-8"
Cc: Artem Bityutskiy <dedekind1@gmail.com>, LiuShuo <b35362@freescale.com>,
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

Scott Wood a écrit :
> On 08/22/2011 11:13 AM, Matthieu CASTET wrote:
>> Scott Wood a écrit :
>>> To eliminate it we'd need to do an extra data transfer without reissuing
>>> the command, which Shuo was unable to get to work.
>>>
>> That's weird because our controller seems quite flexible [1].
>>
>> Something like that should work ?
>>
>>             out_be32(&lbc->fir,
>>                      (FIR_OP_CM2 << FIR_OP0_SHIFT) |
>>                      (FIR_OP_CA  << FIR_OP1_SHIFT) |
>>                      (FIR_OP_PA  << FIR_OP2_SHIFT) |
>>                      (FIR_OP_WB  << FIR_OP3_SHIFT));
>> refill FCM buffer with next 2k data
>>
>>             out_be32(&lbc->fir,
>>                      (FIR_OP_WB  << FIR_OP3_SHIFT) |
>>                      (FIR_OP_CM3 << FIR_OP4_SHIFT) |
>>                      (FIR_OP_CW1 << FIR_OP5_SHIFT) |
>>                      (FIR_OP_RS  << FIR_OP6_SHIFT));
> 
> Something like that is what I originally suggested, but Shuo said it
> didn't work (even in theory, it requires a CE-don't-care NAND chip,
> since bus atomicity is broken).
Are there 4K chip that are not CE-don't-care ?

Also I think it depends how the bus are connected  (shared with other device)
and the controller.

Matthieu

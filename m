Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 985CCB6F71
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 08:30:31 +1000 (EST)
Message-ID: <4E60077A.8070304@freescale.com>
Date: Thu, 1 Sep 2011 17:30:18 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH v3] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
References: <1313634783-8855-1-git-send-email-b35362@freescale.com>	<4E4D3CE0.7020602@freescale.com>
	<4E5366AF.7040108@freescale.com> <4E537AC4.6000301@parrot.com>
	<4E546672.3070100@freescale.com> <4E563133.5070006@parrot.com>
	<4E5F5360.6060400@freescale.com>
In-Reply-To: <4E5F5360.6060400@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	Li Yang-R58472 <r58472@freescale.com>,
	Matthieu CASTET <matthieu.castet@parrot.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/01/2011 04:41 AM, LiuShuo wrote:
> After doing some tests, I found that the elbc controller can read/write
> 4k with one command
> if we insert a FIR_OP_NOP between first half reading/wring and second
> half reading/writing.(delay for something ?)

>From the docs:

> A NOP instruction that appears in FIR ahead of the last instruction
> is executed with the timing of a regular command instruction, but
> neither LFCLE nor LFWE are asserted.  Thus a NOP instruction may be
> used to insert a pause matching the time taken for a regular command
> write.

So the NOP does generate a delay.  Would be nice to know exactly why
it's required.

Have you tried doing this under load with parallel NOR activity?  With
CE-don't-care operation, during the times when CE is not asserted, does
it matter what happens with CLE/ALE/RE?  These signals could be driven
for another chipselect during that time.

-Scott

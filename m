Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21D4F679A6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 21:31:32 +1000 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Wed, 25 May 2005 13:31:22 +0200
References: <200505242119.29197.niklaus.giger@member.fsf.org>
	<20050524133123.A23084@cox.net>
In-Reply-To: <20050524133123.A23084@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505251331.22597.niklaus.giger@member.fsf.org>
Cc: rtai@rtai.org, linuxppc-embedded@ozlabs.org
Subject: Re: Newbie question about accessing memory in kernel space
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Dienstag, 24. Mai 2005 22.31 schrieb Matt Porter:
> On Tue, May 24, 2005 at 09:19:28PM +0200, Niklaus Giger wrote:
> > Hi

> > Oops: kernel access of bad area, sig: 11 [#1]
>
> <snip>
>
> > What is wrong with my code?
>
> You mapped the device into user virtual address space.  The TLB
> replacement code is unable to load a TLB entry for a page outside
> of kernel space...so you crash.
>
> Don't use io_block_map()...it allows you to shoot yourself in the
> foot very easily (as you just witnessed). Use ioremap() to map
> your device.
ioremap() fixed my problem.

Thanks a lot for your help.

Best regards

Niklaus

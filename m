Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCF62B6F75
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2011 04:24:38 +1000 (EST)
Date: Tue, 19 Jul 2011 13:24:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng2 <daniel.ng1234@gmail.com>
Subject: Re: setbat() in udbg_init_cpm() required to avoid driver lockup
Message-ID: <20110719132430.5b6bfe95@schlenkerla.am.freescale.net>
In-Reply-To: <32088424.post@talk.nabble.com>
References: <32088424.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 18 Jul 2011 22:39:01 -0700
Daniel Ng2 <daniel.ng1234@gmail.com> wrote:

> 
> Our USB Device Controller (UDC) driver seems to get stuck in a loop waiting
> for the CPM Command Register to indicate that the CPM has finished executing
> a command. (It should do this by setting the cpmcr 'Command Done' bit).
>
> This only happens if I disable the 'Early Debug' Kernel Hacking .config
> parameter. If Early Debug is enabled, then the problem goes away.
> 
> I've narrowed it down to this line in udbg_init_cpm(void):
> 
> setbat(1, 0xf0000000, 0xf0000000, 0x40000, PAGE_KERNEL_NCG);
> 
> -without this line, the driver gets stuck in the loop.
> 
> Can anyone suggest why?

Is your USB driver accessing effective addresses from 0xf0000000 to
0xf0040000?  It should be using ioremap().

> Also, what undesireable effects might there be of keeping the above call to
> setbat()?

It's squatting on a chunk of virtual address space without properly
reserving it.  This is bad enough for a debug hack (and should be fixed).
Don't extend it to normal operation -- especially not as a substitute for
understanding the root cause of your problem.

-Scott

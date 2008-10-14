Return-Path: <neko@genesi-usa.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.250])
	by ozlabs.org (Postfix) with ESMTP id 9970CDDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 13:14:35 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so906065hsz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 19:14:24 -0700 (PDT)
Message-ID: <48F40077.5060003@genesi-usa.com>
Date: Mon, 13 Oct 2008 21:14:15 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>	
	<20081008154212.GA21723@secretlab.ca>	
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>	
	<48EDD905.6070609@mikroswiat.pl>	
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>	
	<48EE2553.30903@genesi-usa.com>
	<1223764226.8157.182.camel@pasglop>	
	<48F15B7D.3060608@genesi-usa.com>	
	<20081013152028.GA18639@ld0162-tx32.am.freescale.net>
	<1223931027.8157.272.camel@pasglop>
	<48F3B7A2.3010004@freescale.com>
In-Reply-To: <48F3B7A2.3010004@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Dominik Bozek <domino@mikroswiat.pl>, linuxppc-embedded@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Benjamin Herrenschmidt wrote:
>>
>> Yuck.
> 
> Hmm?  It's simple and achieves the desired result (avoiding 
> non-preemptible regions without unduly restricting the ability to 
> extract performance from the hardware).
> 
> Would it be nicer to avoid FP/Altivec in the kernel altogether?  Sure. 
> If the benchmarking says that we're better off with it, though, then so 
> be it.

There should definitely be a nice API for an in-kernel AltiVec context
save/restore. When preemption happens doesn't it do some equivalent of
the userspace context switch? Why can't the preemption system take care
of it?

At worst case you make the worst case latency bigger, but at best case
you gain performance across the board.

One thing which is worrying me is that now that Ben has thrown down the
gauntlet (note, I'm not going to be coding a line, but I know a man who
can :) how on earth do we benchmark the differences here?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

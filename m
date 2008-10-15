Return-Path: <neko@genesi-usa.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id 75266DDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 12:37:32 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so1159382hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 18:37:30 -0700 (PDT)
Message-ID: <48F54950.1070302@genesi-usa.com>
Date: Tue, 14 Oct 2008 20:37:20 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EE2553.30903@genesi-usa.com> <1223764226.8157.182.camel@pasglop>
	<48F15B7D.3060608@genesi-usa.com>
	<20081013152028.GA18639@ld0162-tx32.am.freescale.net>
	<1223931027.8157.272.camel@pasglop>
	<48F3B7A2.3010004@freescale.com> <48F40077.5060003@genesi-usa.com>
	<1223951959.8157.318.camel@pasglop>
	<20081014151041.GB12934@ld0162-tx32.am.freescale.net>
In-Reply-To: <20081014151041.GB12934@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
> BTW, it's actually simpler than I originally described (I had implemented
> this years ago in the TimeSys kernel for x86 and some other arches that
> already use FP or similar resources for memcpy, but the memory was a
> little fuzzy); the FP restore code doesn't need to test anything, it
> always restores from the regular spot.  The kernel code wishing to use FP
> saves the user context in an alternate save area (it could even be on the
> stack, allowing atomic context to use it as well, if it's not too large),
> and restores it when it's done.

Sure, it's simple, the problem is that VRSAVE isn't maintained in the 
kernel, which means for AltiVec context switches you need to save and 
restore 32 128-bit registers every time. And that takes a LONG time..

Just imagine if you did a ~512 byte memcpy, you could guarantee that it 
would take twice as long as it should!

There are ways around it, like assembly and fixed registers, and saving 
the ones you use (this is the sort of thing gcc does for you usually, 
but you can do it by hand just as well) and restoring the ones you 
trashed afterwards, but that makes code messier and less readable.

Not insurmountable problems, but it makes using AltiVec harder. You
would have to really justify a speed increase. I think you could get
that on cryptography functions easily. For page zero/copying, I think 
you would also get the increase to outweigh the prologue/epilogue 
required and also the loss of preemption.

TCP/IP copy with checksum? Probably absolutely definitely..

Straight memcpy? I am not so sure.

Like I said I am far more worried about how you'd get a reasonable
benchmark out of it. Profiling kernels is a messy business..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

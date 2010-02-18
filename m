Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8068FB7CB9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 20:08:49 +1100 (EST)
Date: Thu, 18 Feb 2010 10:08:45 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc/head fsl: move the temp 4KiB mapping to TLB0
Message-ID: <20100218090845.GB17791@Chamillionaire.breakpoint.cc>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<1263573697-17839-3-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<4714F80D-5102-4C25-BA62-0034D775C63B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <4714F80D-5102-4C25-BA62-0034D775C63B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Kumar Gala | 2010-02-17 21:09:08 [-0600]:

>
>On Jan 15, 2010, at 10:41 AM, Sebastian Andrzej Siewior wrote:
>
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> 
>> Right now the setup code takes ESEL of the current mapping and puts the
>> temporary into ESEL (old_ESEL & 1 ) + 1 which is either one or two.
>> This is actually not required since all slots in TLB0 are invalid by now
>> and can be used.
>> This patch moved the temp mapping to TLB0, ESEL[0]. The invalidation of
>> TLB0 does not care about IPPROT so that part can go as well.
>> The benefit is that now the setup code may set every slot of TLB1 while
>> before that it was not allowed to touch ESEL one or two depending on the
>> old_ESEL.
>> 
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> arch/powerpc/kernel/head_fsl_booke.S |   20 +++++---------------
>> 1 files changed, 5 insertions(+), 15 deletions(-)
>
>this is problematic, we can't assume that TLB0 is safe.  It possible some other software is running on a second core and does a broadcast tlbivax which will wipe what's in TLB0.

Ah right SMP. So if CPU0 would wait until CPU1-X are up and kick them
one by one could make it work but is not that pretty.
So let me think of something. I will probably just skip the current
mapping while making new ones for kexec.

>- k

Sebastian

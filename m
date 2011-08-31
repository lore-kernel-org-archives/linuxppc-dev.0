Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 52CC8B6F81
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 19:17:19 +1000 (EST)
Message-ID: <4E5DFC41.7030606@windriver.com>
Date: Wed, 31 Aug 2011 17:17:53 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>	
	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>	
	<4E1FCFEF.7070702@windriver.com>	
	<20110715134232.56373e03@schlenkerla.am.freescale.net>	
	<82C960D7DF4A1F47B94FC1C67A29BEE384D577@ALA-MBA.corp.ad.wrs.com>	
	<20110718105627.245c9fa4@schlenkerla.am.freescale.net>	
	<4E2561F0.5040701@windriver.com> <1314683064.2488.76.camel@pasglop>
In-Reply-To: <1314683064.2488.76.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>> As I understand it, the problem comes from the fact that stwu combines the
>>> creation of a stack frame with storing into that stack frame.  If they were
>> Yes.
>>
>>> separate instructions you'd have a new exception frame at a lower address
>>> by the time you actually store to the non-exception frame.
>> So when kprobe we should use a unique stack frame to skip that stack frame the
>> kprobed stwu want to create.
> 
> I still don't like that patch. Potentially the problem exist for all
> variants of powerpc, not just booke, and I'm not sure I like adding yet

Yes.

> another exception stack.

But I think we should extend easily this for other powerpc variants. And only
when enable CONFIG_KPROBES that dedicated exception stack is valid, so its not
such a big risk :)

> 
> Another (non-great) approach would be to special case stwu to the stack,
> and instead of doing the store while emulating the instruction, keep the
> store address around and do it later, after the stack has been unwound,
> in the exit path (a TIF flag to hit the slow path and then do it in the
> slow path).

Actually I also considered one idea that we do stw-update in the exit path like
your proposal. But I'm not sure if its worth intruding a new TIF flag only for
'stwu'. And if I understand what your exit path means properly, we should do
this on ret_from_except_full,

...
exc_exit_restart:
        lwz     r11,_NIP(r1)
        lwz     r12,_MSR(r1)
	
	Looks we have to add something to update as 'stwu' since _NIP/_MSR are also
corrupted potentially. So I feel we'll make this complicated if we really do here.

exc_exit_start:
        mtspr   SPRN_SRR0,r11
        mtspr   SPRN_SRR1,r12
        REST_2GPRS(11, r1)
        lwz     r1,GPR1(r1)
        .globl exc_exit_restart_end
exc_exit_restart_end:
        PPC405_ERR77_SYNC
        rfi
        b       .                       /* prevent prefetch past rfi */

If I'm wrong please correct me.

> 
> It sounds hackish but it makes it easier to fix everybody at once, there
> are "issues" with changing stacks especially on ppc64 and it would
> definitely be affected as well if the stack frame created is larger than
> our gap.

If we provide another exception stack like we did debug exception on ppc64, are
there those "issues" you said?

Thanks
Tiejun

> 
> Cheers,
> Ben.
> 
> 

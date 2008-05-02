Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8744FDDDEF
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 13:48:18 +1000 (EST)
Message-Id: <DC173CDE-FBC4-4EA0-8022-3F993B6466BF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080502012118.96ED926FA07@magilla.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: how to check for "optional" ppc chip features (MSR_BE)
Date: Thu, 1 May 2008 22:48:12 -0500
References: <20080502012118.96ED926FA07@magilla.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2008, at 8:21 PM, Roland McGrath wrote:

> I've been looking at PowerISA_Public.pdf that I downloaded from some  
> ppc
> site.  It describes various things as "need not be supported on all
> implementations", for example the MSR_BE bit.  Is there a generic  
> way to
> detect if such a feature is supported, or a known table of models that
> support features, or what?
>
> Right now I'm considering MSR_BE (branch tracing).  I have a patch  
> to use
> this (arch_has_block_step, enabling a PTRACE_SINGLEBLOCK).  The only
> machine handy to test is a Mac G5 (PPC970FX, 3.0 (pvr 003c 0300)).   
> I know
> this chip supports MSR_BE.  But that's only because I wrote an  
> affirmative
> test case and tried it and saw it work right.

Look at arch/powerpc/kernel/cputable.c to see how we handle issues  
like this.

> Before submitting the kernel changes, I want to get the CPU model
> conditionalization correct (a runtime check on some feature bit mask  
> is
> fine here, if CONFIG_* alone does not indicate for sure).

I believe all PPC that implement MSR[SE] also support MSR[BE].  The  
"Book-E" class PPCs have a different mechanism to single branch  
completion (these are embedded PPC products).

I've been working on changes related to the Book-E class machines and  
would be happy to try and port what you're looking over.

- k

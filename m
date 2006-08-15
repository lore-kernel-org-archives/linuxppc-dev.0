Return-Path: <boutcher@cs.umn.edu>
Received: from mail.cs.umn.edu (mail.cs.umn.edu [128.101.33.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.cs.umn.edu",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E38E367B57
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 14:16:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17633.16443.337119.547709@hound.rchland.ibm.com>
Date: Mon, 14 Aug 2006 22:32:11 -0500
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH] powerpc: Instrument Hypervisor Calls
In-Reply-To: <20060814232144.GG3213@w-mikek2.ibm.com>
References: <20060814232144.GG3213@w-mikek2.ibm.com>
From: boutcher@cs.umn.edu (Dave Boutcher)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 14 Aug 2006 16:21:44 -0700, Mike Kravetz <kravetz@us.ibm.com> said:
> Here is an updated version of the patch to instrument hypervisor
> calls.  In this version, all statistic updates are performed in
> assembly code.  Statistics are made available via debugfs.
> Instrumentation is enabled via a config option and there is zero
> cost if not enabled.

...

> +#define HCALL_INST_POSTCALL					\
> +	/* get time and PURR snapshots after hcall */		\
> +	mftb	r7;			/* timebase after */	\

if you just add a "mr r8,r7" here you will get consistent
behaviour (either TB and PURR if PURR is supported, or TB
everywhere.)  The processor will pretty much optimize that
away if the FTR section is not no-op-ed.

> +BEGIN_FTR_SECTION;						\
> +	mfspr	r8,SPRN_PURR;		/* PURR after */	\
> +END_FTR_SECTION_IFSET(CPU_FTR_PURR);				\

Dave B

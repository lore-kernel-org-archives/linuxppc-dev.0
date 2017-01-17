Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2fHb2GyJzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 16:46:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/perf: use MSR to report privilege level on P9 DD1
In-Reply-To: <1483434793-1814-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1483434793-1814-1-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 17 Jan 2017 16:46:47 +1100
Message-ID: <87fukib5mg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:

> "use_siar" variable is primarily used for deciding the sampled address
> and the privilege level to be reported for a sample. perf_read_regs()
> function updates the "use_siar" and "regs->result" based on the pmu
> flags along with other checks. To force the use of MSR to report the
> privilege level and to use "regs->nip" to report the instruction pointer,
> set "PPMU_NO_CONT_SAMPLING" flag and remove "PPMU_HAS_SIER" from the
> ppmu->flags.

This still won't work for marked events AFAICS:

	if (TRAP(regs) != 0xf00)
		use_siar = 0;
	else if (marked)
		use_siar = 1;
	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
		use_siar = 0;
	else if (!(ppmu->flags & PPMU_NO_SIPR) && regs_sipr(regs))
		use_siar = 0;
	else
		use_siar = 1;

So perhaps we just want a USE_SIAR flag?

And I don't see how HAS_SIER is related? Or is SIER broken too?

cheers

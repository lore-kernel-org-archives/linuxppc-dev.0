Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A3AB92C00C5
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Apr 2013 03:11:56 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 11:11:53 -0600
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9CC9C6E8040
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 13:11:47 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3PHBomB292162
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 13:11:50 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3PHBn1Y009958
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Apr 2013 13:11:50 -0400
Date: Thu, 25 Apr 2013 10:11:33 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/4] powerpc/perf: Convert mmcra_sipr/sihv() to
 regs_sipr/sihv()
Message-ID: <20130425171133.GB28848@us.ibm.com>
References: <1365582765-6939-1-git-send-email-michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365582765-6939-1-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| From: Michael Ellerman <michaele@au1.ibm.com>
| 
| On power8 the SIPR and SIHV are not in MMCRA, so convert the routines
| to take regs and change the names accordingly.
| 
| Signed-off-by: Michael Ellerman <michaele@au1.ibm.com>
| ---
|  arch/powerpc/perf/core-book3s.c |   20 +++++++++++---------
|  1 file changed, 11 insertions(+), 9 deletions(-)
| 
| diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
| index fcfafa0..cb1618d 100644
| --- a/arch/powerpc/perf/core-book3s.c
| +++ b/arch/powerpc/perf/core-book3s.c
| @@ -112,24 +112,24 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
|  		*addrp = mfspr(SPRN_SDAR);
|  }
| 
| -static bool mmcra_sihv(unsigned long mmcra)
| +static bool regs_sihv(struct pt_regs *regs)
|  {
|  	unsigned long sihv = MMCRA_SIHV;
| 
|  	if (ppmu->flags & PPMU_ALT_SIPR)
|  		sihv = POWER6_MMCRA_SIHV;
| 
| -	return !!(mmcra & sihv);
| +	return !!(regs->dsisr & sihv);
|  }
| 
| -static bool mmcra_sipr(unsigned long mmcra)
| +static bool regs_sipr(struct pt_regs *regs)
|  {
|  	unsigned long sipr = MMCRA_SIPR;
| 

Would it make sense to add this here:

	if (ppmu->flags & PPMU_NO_SIPR)
		return 0;
so ....

|  	if (ppmu->flags & PPMU_ALT_SIPR)
|  		sipr = POWER6_MMCRA_SIPR;
| 
| -	return !!(mmcra & sipr);
| +	return !!(regs->dsisr & sipr);
|  }
| 
|  static inline u32 perf_flags_from_msr(struct pt_regs *regs)
| @@ -143,7 +143,6 @@ static inline u32 perf_flags_from_msr(struct pt_regs *regs)
| 
|  static inline u32 perf_get_misc_flags(struct pt_regs *regs)
|  {
| -	unsigned long mmcra = regs->dsisr;
|  	unsigned long use_siar = regs->result;
| 
|  	if (!use_siar)
| @@ -163,10 +162,12 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
|  	}
| 
|  	/* PR has priority over HV, so order below is important */
| -	if (mmcra_sipr(mmcra))
| +	if (regs_sipr(regs))
|  		return PERF_RECORD_MISC_USER;
| -	if (mmcra_sihv(mmcra) && (freeze_events_kernel != MMCR0_FCHV))
| +
| +	if (regs_sihv(regs) && (freeze_events_kernel != MMCR0_FCHV))
|  		return PERF_RECORD_MISC_HYPERVISOR;
| +
|  	return PERF_RECORD_MISC_KERNEL;
|  }
| 
| @@ -182,6 +183,8 @@ static inline void perf_read_regs(struct pt_regs *regs)
|  	int marked = mmcra & MMCRA_SAMPLE_ENABLE;
|  	int use_siar;
| 
| +	regs->dsisr = mmcra;
| +
|  	/*
|  	 * If this isn't a PMU exception (eg a software event) the SIAR is
|  	 * not valid. Use pt_regs.
| @@ -205,12 +208,11 @@ static inline void perf_read_regs(struct pt_regs *regs)
|  		use_siar = 1;
|  	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
|  		use_siar = 0;
| -	else if (!(ppmu->flags & PPMU_NO_SIPR) && mmcra_sipr(mmcra))
| +	else if (!(ppmu->flags & PPMU_NO_SIPR) && regs_sipr(regs))

... this becomes

	else if (regs_sipr(regs))

mmcra_sipr() is used currently in two places and both places check
the NO_SIPR flag.

The reason is that this line gets modified in PATCH 3/4 to:

	else if (!regs_no_sipr(regs) && regs_sipr(regs))

which is kind of hard to read. if (!not_X && X)

Sukadev

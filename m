Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406JnR2x9QzF1t9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 18:53:15 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2M7oDHR194280
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 03:53:12 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gv89kgdjq-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 03:53:12 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 22 Mar 2018 07:53:10 -0000
Date: Thu, 22 Mar 2018 13:23:05 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/5] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <b6aff6c7194bd7bb97828db63ca0c82ee4598918.1521627906.git.naveen.n.rao__49352.2364100956$1521630977$gmane$org@linux.vnet.ibm.com>
In-Reply-To: <b6aff6c7194bd7bb97828db63ca0c82ee4598918.1521627906.git.naveen.n.rao__49352.
 2364100956$1521630977$gmane$org@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1521705085.6fya98gc1m.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Naveen N. Rao wrote:
> We have some C code that we call into from real mode where we cannot
> take any exceptions. Though the C functions themselves are mostly safe,
> if these functions are traced, there is a possibility that we may take
> an exception. For instance, in certain conditions, the ftrace code uses
> WARN(), which uses a 'trap' to do its job.
>=20
> For such scenarios, introduce a new field in paca 'ftrace_disabled',
> which is checked on ftrace entry before continuing. This field can then
> be set to a non-zero value to disable/pause ftrace, and reset to zero to
> resume ftrace.
>=20
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Changes since v1:
> - Do not guard the paca field check within CONFIG_KVM.
> - Move the early return code out of the usual path to optimize for=20
>   better cache performance in the normal case when ftrace is enabled.
>=20
>  arch/powerpc/include/asm/paca.h                |  1 +
>  arch/powerpc/kernel/asm-offsets.c              |  1 +
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 14 ++++++++++++++
>  arch/powerpc/kernel/trace/ftrace_64_pg.S       |  4 ++++
>  4 files changed, 20 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/p=
aca.h
> index d2bf71dddbef..4f47adc2a408 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -211,6 +211,7 @@ struct paca_struct {
>  	u16 in_mce;
>  	u8 hmi_event_available;		/* HMI event is available */
>  	u8 hmi_p9_special_emu;		/* HMI P9 special emulation */
> +	u8 ftrace_disabled;
>  #endif
> =20
>  	/* Stuff for accurate time accounting */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index ea5eb91b836e..8e4fc96ff6bc 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -240,6 +240,7 @@ int main(void)
>  	OFFSET(PACA_RFI_FLUSH_FALLBACK_AREA, paca_struct, rfi_flush_fallback_ar=
ea);
>  	OFFSET(PACA_EXRFI, paca_struct, exrfi);
>  	OFFSET(PACA_L1D_FLUSH_SIZE, paca_struct, l1d_flush_size);
> +	OFFSET(PACA_FTRACE_DISABLED, paca_struct, ftrace_disabled);
> =20
>  #endif
>  	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerp=
c/kernel/trace/ftrace_64_mprofile.S
> index 3f3e81852422..8f2380304ef1 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> @@ -47,6 +47,12 @@ _GLOBAL(ftrace_caller)
>  	/* Save all gprs to pt_regs */
>  	SAVE_GPR(0, r1)
>  	SAVE_10GPRS(2, r1)
> +
> +	/* Ok to continue? */
> +	lbz	r3, PACA_FTRACE_DISABLED(r13)
> +	cmpdi	r3, 0
> +	beq	ftrace_no_trace
	^^^ bne

:facepalm:

- Naveen

=

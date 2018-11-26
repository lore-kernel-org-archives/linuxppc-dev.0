Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_INVALID,DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478FC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 12:43:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388742081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 12:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFJznkR0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388742081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4343NW3tMjzDqRm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 23:43:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eFJznkR0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=acme@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="eFJznkR0"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4343DL0RvMzDqVM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 23:36:02 +1100 (AEDT)
Received: from quaco.infradead.org (unknown [190.15.121.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 022E021508;
 Tue, 27 Nov 2018 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543322160;
 bh=q0cRdGjGM2SFFTvlc2bU+VfmMipjJoTNl3Z2nAH5dFE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eFJznkR04RyvDCiztqXWvAPkRy4D2ekcOw3/dy374vgx07o9J0CJXmJkLsL5pNnfZ
 wAzSPkfXPhOpbcT6QsatAmNkoTC2vs2d6lFKqKrfrjHKIY7DucKL3BeWyxiafXHCo8
 kI1jMsEkIa7l66u1ev77z/MCvD86wkQhUiFxFMeo=
Received: by quaco.infradead.org (Postfix, from userid 1000)
 id 5489C4111F; Mon, 26 Nov 2018 16:38:21 -0300 (-03)
Date: Mon, 26 Nov 2018 16:38:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND] powerpc/perf: Update perf_regs structure to
 include SIER
Message-ID: <20181126193821.GD18491@kernel.org>
References: <1543255448-27552-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543255448-27552-1-git-send-email-maddy@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Thomas Richter <tmricht@linux.vnet.ibm.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Em Mon, Nov 26, 2018 at 11:34:08PM +0530, Madhavan Srinivasan escreveu:
> On each sample, Sample Instruction Event Register (SIER) content
> is saved in pt_regs. SIER does not have a entry as-is in the pt_regs
> but instead, SIER content is saved in the "dar" register of pt_regs.
> 
> Patch adds another entry to the perf_regs structure to include the "SIER"
> printing which internally maps to the "dar" of pt_regs.

I think the patch is ok, when we talked in Vancouver I thought I saw
something like this before, i.e. adding more registers to a perf_regs.h
file, this was the cset:

  commit 0da0017f72554c005c1a04c3adc5da9eb64fa7e5
  Author: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
  Date:   Wed Nov 8 07:30:15 2017 +0100

      s390/perf: extend perf_regs support to include floating-point registers

That I came across because it broke the perf build, making me add this
cset:

  commit 10b9baa701d5023897f70a4acb3bf0235da3dc4f
  Author: Arnaldo Carvalho de Melo <acme@redhat.com>
  Date:   Tue Nov 28 11:08:41 2017 -0300

    tools arch s390: Do not include header files from the kernel sources

:-)

Michael? What about the ppc specific details?

- Arnaldo
 
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/uapi/asm/perf_regs.h       | 1 +
>  arch/powerpc/perf/perf_regs.c                   | 1 +
>  tools/arch/powerpc/include/uapi/asm/perf_regs.h | 1 +
>  tools/perf/arch/powerpc/include/perf_regs.h     | 3 ++-
>  tools/perf/arch/powerpc/util/perf_regs.c        | 1 +
>  5 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
> index 9e52c86ccbd3..ff91192407d1 100644
> --- a/arch/powerpc/include/uapi/asm/perf_regs.h
> +++ b/arch/powerpc/include/uapi/asm/perf_regs.h
> @@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
>  	PERF_REG_POWERPC_TRAP,
>  	PERF_REG_POWERPC_DAR,
>  	PERF_REG_POWERPC_DSISR,
> +	PERF_REG_POWERPC_SIER,
>  	PERF_REG_POWERPC_MAX,
>  };
>  #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
> index 09ceea6175ba..c262aea22ad9 100644
> --- a/arch/powerpc/perf/perf_regs.c
> +++ b/arch/powerpc/perf/perf_regs.c
> @@ -69,6 +69,7 @@ static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
>  	PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
>  	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
>  	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
> +	PT_REGS_OFFSET(PERF_REG_POWERPC_SIER, dar),
>  };
>  
>  u64 perf_reg_value(struct pt_regs *regs, int idx)
> diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
> index 9e52c86ccbd3..ff91192407d1 100644
> --- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
> +++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
> @@ -46,6 +46,7 @@ enum perf_event_powerpc_regs {
>  	PERF_REG_POWERPC_TRAP,
>  	PERF_REG_POWERPC_DAR,
>  	PERF_REG_POWERPC_DSISR,
> +	PERF_REG_POWERPC_SIER,
>  	PERF_REG_POWERPC_MAX,
>  };
>  #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
> diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
> index 00e37b106913..1076393e6f43 100644
> --- a/tools/perf/arch/powerpc/include/perf_regs.h
> +++ b/tools/perf/arch/powerpc/include/perf_regs.h
> @@ -62,7 +62,8 @@ static const char *reg_names[] = {
>  	[PERF_REG_POWERPC_SOFTE] = "softe",
>  	[PERF_REG_POWERPC_TRAP] = "trap",
>  	[PERF_REG_POWERPC_DAR] = "dar",
> -	[PERF_REG_POWERPC_DSISR] = "dsisr"
> +	[PERF_REG_POWERPC_DSISR] = "dsisr",
> +	[PERF_REG_POWERPC_SIER] = "sier"
>  };
>  
>  static inline const char *perf_reg_name(int id)
> diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
> index ec50939b0418..07fcd977d93e 100644
> --- a/tools/perf/arch/powerpc/util/perf_regs.c
> +++ b/tools/perf/arch/powerpc/util/perf_regs.c
> @@ -52,6 +52,7 @@ const struct sample_reg sample_reg_masks[] = {
>  	SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
>  	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
>  	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
> +	SMPL_REG(sier, PERF_REG_POWERPC_SIER),
>  	SMPL_REG_END
>  };
>  
> -- 
> 2.7.4

-- 

- Arnaldo

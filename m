Return-Path: <SRS0=3fZu=5I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DFFC10F26
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 06:49:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547CB20736
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 06:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbEQCI+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547CB20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48m4jT4k0MzDqdt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2020 17:49:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1042;
 helo=mail-pj1-x1042.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tbEQCI+P; dkim-atps=neutral
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48m4fz4PYTzDqG8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2020 17:46:51 +1100 (AEDT)
Received: by mail-pj1-x1042.google.com with SMTP id mj6so5713263pjb.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2020 23:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=gFZwaKmbodmW8S/JPXnb1SxWDqQPd5EkH3uRIUqt3i8=;
 b=tbEQCI+PEuSQB6iJyvJlsOWN3rq5tMVdoDcFCRkd/NSrP5E8Ah57c7CLjdnrxnLg2g
 8T9t0Vhb169SjCDNk4qobQPpGzKxBn35jBjd/5puH8VmaS7HIoyR9QACO/T6jYglqwHi
 bzxYShU2M0C7YAL36jA/qc8z0VZVdjKL/cfBbArm2HmrxdbfiS/1NPfM6E1sRYl9h2rP
 wGuC051nr+sZemKir5hNJkGCoZT3fHuRmtWYNc1HjIi57z7O81ZyCnJ8t2xSH0sSIwQO
 iSAE5Taa88mc44vTefq0tGaZeTDQDyII71T+YuJMYkStGPMt7AR5qjlaKWcyV6ad5u5R
 jKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=gFZwaKmbodmW8S/JPXnb1SxWDqQPd5EkH3uRIUqt3i8=;
 b=LRIwD3XIM1CuBZWkRPXBMZCGVuhxEkf9byEEkEtpQVOen4fERwS9arlKOUczFH1KEJ
 wIgYSfJdzpIqLJIYstIYee4QwAh9wSk0gyF+InyjzDHF1Pm/xyDzIQo2p/M0eid7QFKI
 LM/7oDPJ90A9RzMHiDxH6lFiRqX2MZAcPeCON+D5P8PeuTMES023J42hq4Hr8h+848kP
 dVf3Gfxqem4lvJGBLA7B4y4xuhjo0U8he11kdNBXE2c8m7SCjEnAWIaQ53iNrbKk7kmQ
 NBjNMqgQs0HEDS3jEssS06LHy21rZP1EDu/8DJYxHIWookQdP/nAMOfFIPxTTwoUR0Tp
 8D+Q==
X-Gm-Message-State: ANhLgQ0J9AaCRUS2LLgsLjAS5ZNDV4hU4LDQOEMFe5AFjS2Yl+fcT9VO
 6pbZd4g086JGJxpNIKu6mYg=
X-Google-Smtp-Source: ADFU+vtEKhCTAQuHc/RKrkksqR7bczMH6AKHxLnOc57xRwcWyo1++tmM53woLjLVnoikWtWFrFnyiA==
X-Received: by 2002:a17:90b:4906:: with SMTP id
 kr6mr5812306pjb.13.1584946008591; 
 Sun, 22 Mar 2020 23:46:48 -0700 (PDT)
Received: from localhost (14-202-190-183.tpgi.com.au. [14.202.190.183])
 by smtp.gmail.com with ESMTPSA id x189sm12472621pfb.1.2020.03.22.23.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 23:46:48 -0700 (PDT)
Date: Mon, 23 Mar 2020 16:43:04 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 07/16] powerpc: Introduce functions for instruction
 nullity and equality
To: Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20200320051809.24332-1-jniethe5@gmail.com>
 <20200320051809.24332-8-jniethe5@gmail.com>
In-Reply-To: <20200320051809.24332-8-jniethe5@gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1584945440.a20p67lxd6.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: alistair@popple.id.au, dja@axtens.net, bala24@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jordan Niethe's on March 20, 2020 3:18 pm:
> In preparation for an instruction data type that can not be directly
> used with the '=3D=3D' operator use functions for checking equality and
> nullity.
>=20
> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
> ---
>  arch/powerpc/kernel/optprobes.c      |  2 +-
>  arch/powerpc/kernel/trace/ftrace.c   | 33 +++++++++++++++-------------
>  arch/powerpc/lib/code-patching.c     | 16 +++++++-------
>  arch/powerpc/lib/feature-fixups.c    |  2 +-
>  arch/powerpc/lib/test_emulate_step.c |  4 ++--
>  arch/powerpc/xmon/xmon.c             |  4 ++--
>  6 files changed, 32 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optpro=
bes.c
> index 1025a7a3b3a8..6027425a85f2 100644
> --- a/arch/powerpc/kernel/optprobes.c
> +++ b/arch/powerpc/kernel/optprobes.c
> @@ -259,7 +259,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kp=
robe *op, struct kprobe *p)
>  				(unsigned long)emulate_step_addr,
>  				BRANCH_SET_LINK);
> =20
> -	if (!branch_op_callback || !branch_emulate_step)
> +	if (ppc_inst_null(branch_op_callback) || ppc_inst_null(branch_emulate_s=
tep))

Is an instruction null, or zeroes?

Oh, most of this comes from create_branch and things. Hmm, would rather
see those functions modified to take a &insn and return an int err.


> @@ -437,7 +438,7 @@ int ftrace_make_nop(struct module *mod,
>  	 * then we had to use a trampoline to make the call.
>  	 * Otherwise just update the call site.
>  	 */
> -	if (test_24bit_addr(ip, addr)) {
> +	if (!ppc_inst_null(test_24bit_addr(ip, addr))) {
>  		/* within range */
>  		old =3D ftrace_call_replace(ip, addr, 1);
>  		new =3D PPC_INST(PPC_INST_NOP);

test_24bit_addr shouldn't be passing a ppc_inst back, but a bool.

Thanks,
Nick
=

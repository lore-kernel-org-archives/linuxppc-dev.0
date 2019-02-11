Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E8AC282C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 00:49:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973002146F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 00:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="mpmTjciw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973002146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yRxn3B8bzDqMX
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 11:49:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="mpmTjciw"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43yRw80DxszDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 11:47:51 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id v28so4180515pgk.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 16:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=46DX/PEBbJzSWDO26uIQhDm8DWT7IDwWCEHb6Nwvgb8=;
 b=mpmTjciwH65L9P2i6yE2UGuM6BPBwNQsP5WxygSSWac6t7NRYLrAeK4Qw7AE6Az5BB
 U0so5r6GZVh3DIJyHIPqcY5+TNFcSKtocI9ChwlfV97MxzDixAGsBFM95q1xfjWmedsq
 uBYYn7eHAy/IvxnPSvMCfs4Tcp4XYt7fxo1z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=46DX/PEBbJzSWDO26uIQhDm8DWT7IDwWCEHb6Nwvgb8=;
 b=niVy5Ro+zEYYPmW2yw6YvmgK8TzSBQ5GYpTmd+APylud2/IV5mk0ZIzkNJT2jC2ohF
 +wiOjTfXyT0fq7sI4BXF5Ujwr6lGdC+FeTnBoic3O6qxkZUhzldElLBL6jCzXeD7uJKT
 lXe08h35UR/PxYULudqz06RQo43WG9ZlpvnPNRK4SJrGAvOdbRpj/wu2M6ZSZoKHlRPF
 H/pZojCMGJkmqUDq16AtmBvzddyOZVH7fYkTZT6xfGfa5YmefUeQxC0vSi3zywNMzS0E
 +HJSHqA4AWUcxDhk4vg/Dh14EecLoZA8XK4OtbeDX7f35NKNrOrC072rBYo5U3PuOPGo
 Xsfg==
X-Gm-Message-State: AHQUAuYsEbMUx1i++9l/kDJXMtIjfDcijA1utiQPTLAiMtXO7mnmic4o
 OKFOZyV52rCWCzNZ1xHrfMC0NQ==
X-Google-Smtp-Source: AHgI3IaqU3aIqf8DsJAeHnG6eJ9FXW3gXAgff/bvUFvsx/t6fcgEBI16r9Yzml1j9FE6zj/JtQ672g==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr34623262pfv.216.1549846069557; 
 Sun, 10 Feb 2019 16:47:49 -0800 (PST)
Received: from localhost (124-171-97-196.dyn.iinet.net.au. [124.171.97.196])
 by smtp.gmail.com with ESMTPSA id w12sm8659512pgp.38.2019.02.10.16.47.47
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 10 Feb 2019 16:47:48 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Sandipan Das <sandipan@linux.ibm.com>, mpe@ellerman.id.au
Subject: Re: [RFC PATCH 3/5] powerpc: sstep: Add instruction emulation
 selftests
In-Reply-To: <196d2330aef453b4eb3cb66febeb79110aadd567.1549253769.git.sandipan@linux.ibm.com>
References: <cover.1549253769.git.sandipan@linux.ibm.com>
 <196d2330aef453b4eb3cb66febeb79110aadd567.1549253769.git.sandipan@linux.ibm.com>
Date: Mon, 11 Feb 2019 11:47:44 +1100
Message-ID: <87bm3j40cv.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Sandipan,

I'm not really confident to review the asm, but I did have a couple of
questions about the C:

> +#define MAX_INSNS	32
This doesn't seem to be used...

> +int execute_instr(struct pt_regs *regs, unsigned int instr)
> +{
> +	extern unsigned int exec_instr_execute[];
> +	extern int exec_instr(struct pt_regs *regs);

These externs sit inside the function scope. This feels less than ideal
to me - is there a reason not to have these at global scope?

> +
> +	if (!regs || !instr)
> +		return -EINVAL;
> +
> +	/* Patch the NOP with the actual instruction */
> +	patch_instruction(&exec_instr_execute[0], instr);
> +	if (exec_instr(regs)) {
> +		pr_info("execution failed, opcode = 0x%08x\n", instr);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}

> +late_initcall(run_sstep_tests);
A design question: is there a reason to run these as an initcall rather
than as a module that could either be built in or loaded separately? I'm
not saying you have to do this, but I was wondering if you had
considered it?

Lastly, snowpatch reports some checkpatch issues for this and your
remaining patches: https://patchwork.ozlabs.org/patch/1035683/ (You are
allowed to violate checkpatch rules with justification, FWIW)

Regards,
Daniel
> -- 
> 2.19.2

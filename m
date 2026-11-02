Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80D606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C399qxrP
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJ8GD1v6Dz2xHX;
	Mon, 02 Nov 2026 22:13:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793618020;
	cv=none; b=EVhbUd9LEFUnPloIXJN7yCBBmP85yJhsH88OZp+g7IV6cQ/OgZh0IGR5qY7wXHeDCfpS+OlVaDO+A7bplaCOesY0VzGK1Re9UOP75WzVdMT7/3BANSxcjs6tLym1cAr2CgB3FYbtx8+9CwVaTgfVBoRNUkXj9p3kBJ/VbcaRegFbnzn6nqbToAoKTzlHDu4uMIv7Zkbj6Fk8CfoxJKjCpPF0DkaCPkMF7ov/vX3wHYsEn2xi82vYbWMh/T8DOsIiypZxafmO5xucvPBtBm4js/hrWJ+ZnyRWQ/vqamqDcO1CsNsD/CC04KE1jYJABBkXU7BFxesC2ZN4cA0aSW8KoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793618020; c=relaxed/relaxed;
	bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=B+AG2lp/t3RvzUctnaVG1e+sYiGapLVrj0RuMRMAK7lPyA1b3wfz6V8iRhAW0HtLZ3UrOza9WLgBJ9F7UBtAL/s4fjEkMskXV+xLs9trVYZ+P8hbmiuRFN+MrpviTrTXmaWJYfPTDVd2rCEO7SqE4Cmb3AlRfUTChEV6sf1Gjm4rhEkM+6ZLt4KugZfeeehWZaNYP7ceSwPuinnSBW409re2wwp6mUyzAq5o3VGVVzsRKdh6or2ZlmJApE1CTl7K1RdEwCOCpCDy4m6Gt2nz8wTZ2iA3CrwBSjrcvsxFSDW2dRcI+uU9mZB6g/4f1bpFj9Io3r9MQWhtXodOE0j/Nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C399qxrP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C399qxrP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJ8GB5p3pz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 22:13:38 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-36a1947498bso1070853eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618016; x=1794222816; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
        b=C399qxrP730TFcKMex/Cytaaf44CEcVnUbOevNctpxcFJcLDTr8z6Or58bT32K3KCK
         a8NltkSvBiUJqBAEh2oanD8bBNzvzTAFsVkw6SHvTzRIIUfaiPlMHLzgS1bgSA2LLycq
         tJp0Bf/xEFwE+GV3ilHlep+dfoZHoHCZn28HrjibZZbNVEV7sD6wDGSHmzOoqYjZaEV8
         E8k2elwEZFueej+cmEPN/aM18fjfY1xlMpONwnvj+LaMnw+wMpYems1SxwmfQrp/osfu
         vyqoPV6o6dTAjIwWdEUteAsTBh9zcdAt+necLeQfscQsnOtTJ7BBKkrcoyoMQohykW1S
         I1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618016; x=1794222816;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8Rvs+APlES4o/Y+QNKx+Wsj0zsjMwsSLTHZLYdVhZI=;
        b=RSnxj06bRt0rqXTYFqhiXmxgeZMyL2bGrPlHMAmOhK4DQtow0Vgf3GGpomhTJ+6zqp
         VSKFgENxUaIoHQae9AsckzPBv0xuDEG6LHst5wjz0iyANJLNB5i8TLCZhFEiNLIJuSCa
         PjMs4OF+C/JPx9hFy3sBbmwfJ88VU1BUpM3e24DF30pfcT/UhMWVzBU0CBHyC7DUAXWb
         NwcOlVkQqBoAIvSvnVuUBSrQgOY9dN5FU92K6hjJmgS9goxQ2FiVoqnOPIB7GVkKI0hP
         7l08jm5rHpUCqPWOnYjDyrq16Am2Na/iveSaxlJvC7lVDhrlXjLvb+8+4p6EirKbcm9e
         xSDg==
X-Gm-Message-State: APuU4Z+OBJUr8B09IZzH8QnMIveYTMeXnjtX9cuMC5NLkYyZfQRSpfo8
	pxsKYa7rAoqSyx5Y/rGDFyxtvI8oO0d306dZ7Evr7KP28b1p2J2FacjN
X-Gm-Gg: AYBFou1o7SY04gDf00NilXsWX4/qYngr3KERUGvzW5P70GLV9uVz8cdIrJ1brNj/2C9
	1/MuKB1whpmm4TqwhUL6rec9cNEPiYb3b7FpjaeKkJeJEYpiyCbilIGBfTbRLkKiHWNAyzmYazv
	2z3hYg8pRXcxqodu+Y2MiyTw2MsxX9+ASESOE/6wuTOwmwHlD32F4PA8MPeL/48BiZ/3imbUAJH
	4OHNPHa5UCyv8awxkoBKah6JE+CbYarlLeE7nfiJmU6R67Gm5dzSjlQH+hTU4kTY2aLg5kRHAq5
	zoGy1UEv8K14gm4bJjSDztPTixBXCnm+Tn19SMSWDB2vFqeqv3OdLd3trzdEBUW/fuGompMebmf
	osB4NZa3a4Y5vb+ylw7fQ9xUSwkvTVokv2cRQv2dBYPcZZaflr3gm5i6Q8beNn93dxZR1P7t0G8
	/Der7reRyLaV/uqjklivSMpebJw+2XXTorjHyzlesZq+u7M3NZMMMo4t+XktDLIQ9IKhrt8CUfT
	SH2YsVWLE2IyHnfmv/gq+tfLCdlrwASLJS33B/vKPr3QREMVcTtwkc9qNKO/XTcUzno1Sg90PMC
	f0q7ZEfWwF8iCl+DedEhN8RjKfk=
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id 5a478bee46e88-36a423f04b7mr23743030eec.28.1793618015928;
        Mon, 02 Nov 2026 03:13:35 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm42099651eec.11.2026.11.02.03.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:13:35 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v5] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
In-Reply-To: <20261102091700.253381-1-gautam@linux.ibm.com>
Date: Mon, 02 Nov 2026 16:42:12 +0530
Message-ID: <y0bb5vxv.ritesh.list@gmail.com>
References: <20261102091700.253381-1-gautam@linux.ibm.com>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>

Gautam Menghani <gautam@linux.ibm.com> writes:

> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
>
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
>
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
>
> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> available (currently in case of KVM on PowerNV only), as the XIVE hardware
> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> functionality is not required. This reduces the number of spurious
> interrupts drastically.
>
> Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> Cc: stable@vger.kernel.org # 6.8+
> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v5:
> 1. Drop the redundant check for the presence of the native XIVE
> device. (Ritesh)
>

Thanks Gautam for confirming that.

The patch looks good to me. Feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>



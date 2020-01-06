Return-Path: <SRS0=nzsQ=23=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860F5C33C8C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 17:07:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F7F6206DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Q5qXUAWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7F6206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47s25409qczDqFm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 04:07:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lca.pw
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=cai@lca.pw; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lca.pw header.i=@lca.pw header.b="Q5qXUAWv"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47s23130x6zDqFs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2020 04:06:04 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id a203so40400913qkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jan 2020 09:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=EwZ+SLXyd+u2b7lSTZL/WS+X23E/iu51rmn5Dj8RxnU=;
 b=Q5qXUAWvBBsS0lE0zD06JyRJt1XslmfI2fUrY3Zp6Hi15hdFgGzbEb08oQ1NQSDMdX
 xwbDoXhjO48Vwc+GB1UKy3VfEHx8ZPIIQSiqgOiVf6ZcwxFCVJIQ843zXAhkSi9Y1s5X
 HAUj7LQK+6WsqGqD7nuCUN7cc20OOmh7zCFylmDfN69tEZzTEtF2E2CmfXgWo/BUAWo5
 oVqChTiF+R4imFAc/YjlYyN7sh4egG0B+g2oHmE7eKOdNx4VaTbyDcMsW8cbE5RwyIXR
 DCYcSTdUHV3C7EBjCfB2GyUuX/ESGUr9yqt9Z/f8B+5L+4csrTsyQfG6AlP9i2cvJrw5
 Wevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=EwZ+SLXyd+u2b7lSTZL/WS+X23E/iu51rmn5Dj8RxnU=;
 b=gjZSHGlNi77uH5kOjyEyNWkJRALCmEfLb1Yeuh8tQ4UP2XjLhgty60xUWLwUZ6D27n
 L48Yxxk52w44O1zMGXm73cU8aUO7xk2qTj+x9nDCxBTnkM4fJClcpxss+Jq6UfmKQWWI
 2gcVGWD2lk/WXosVbgAcL26DgBWaRnjBqUV1sqQ46bAgBBrq1PguI0ZjLpwHmPxkwFfp
 9lMnCeBHi1Q/wFZ3XC70hBz2RWgN0bKzMPRk4dSKXYTLp7AO0TsLWrqVoe/5BeoWkC4T
 YJsErhP8nlZ4P7U+JhXmpda4tO/05Pq31o9owCjbZVQ9sqmGMOjPKxOaFgsrYV/Y85TE
 0sPw==
X-Gm-Message-State: APjAAAWST3tRTNP696XtgIRakPa8fSACMV1WAYYtMYfuF7LgpztFGNSw
 XGIqgXNrHqWm/CbXfAMzOKQZQw==
X-Google-Smtp-Source: APXvYqwJxhahEu6YInys2SPBQzG2qgwGLQ9TdDO43Oo052eW8PdglS1AO9SL6TIVmGaJT+LGtb0lyg==
X-Received: by 2002:a05:620a:78f:: with SMTP id
 15mr9230475qka.295.1578330361188; 
 Mon, 06 Jan 2020 09:06:01 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net.
 [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id w25sm17147166qts.91.2020.01.06.09.06.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jan 2020 09:06:00 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: "ftrace: Rework event_create_dir()" triggers boot error messages
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20191218233101.73044ce3@rorschach.local.home>
Date: Mon, 6 Jan 2020 12:05:58 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F343134-63CB-4D99-97AD-F512B8760C94@lca.pw>
References: <0FA8C6E3-D9F5-416D-A1B0-5E4CD583A101@lca.pw>
 <20191218233101.73044ce3@rorschach.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
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
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



> On Dec 18, 2019, at 11:31 PM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Wed, 18 Dec 2019 22:58:23 -0500
> Qian Cai <cai@lca.pw> wrote:
>=20
>> The linux-next commit "ftrace: Rework event_create_dir()=E2=80=9D [1] =
triggers boot warnings
>> for Clang-build (Clang version 8.0.1) kernels (reproduced on both =
arm64 and powerpc).
>> Reverted it (with trivial conflict fixes) on the top of today=E2=80=99s=
 linux-next fixed the issue.
>>=20
>> configs:
>> https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config
>> =
https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
>>=20
>> [1] =
https://lore.kernel.org/lkml/20191111132458.342979914@infradead.org/
>>=20
>> [  115.799327][    T1] Registered efivars operations
>> [  115.849770][    T1] clocksource: Switched to clocksource =
arch_sys_counter
>> [  115.901145][    T1] Could not initialize trace point =
events/sys_enter_rt_sigreturn
>> [  115.908854][    T1] Could not create directory for event =
sys_enter_rt_sigreturn
>> [  115.998949][    T1] Could not initialize trace point =
events/sys_enter_restart_syscall
>> [  116.006802][    T1] Could not create directory for event =
sys_enter_restart_syscall
>> [  116.062702][    T1] Could not initialize trace point =
events/sys_enter_getpid
>> [  116.069828][    T1] Could not create directory for event =
sys_enter_getpid
>> [  116.078058][    T1] Could not initialize trace point =
events/sys_enter_gettid
>> [  116.085181][    T1] Could not create directory for event =
sys_enter_gettid
>> [  116.093405][    T1] Could not initialize trace point =
events/sys_enter_getppid
>> [  116.100612][    T1] Could not create directory for event =
sys_enter_getppid
>> [  116.108989][    T1] Could not initialize trace point =
events/sys_enter_getuid
>> [  116.116058][    T1] Could not create directory for event =
sys_enter_getuid
>> [  116.124250][    T1] Could not initialize trace point =
events/sys_enter_geteuid
>> [  116.131457][    T1] Could not create directory for event =
sys_enter_geteuid
>> [  116.139840][    T1] Could not initialize trace point =
events/sys_enter_getgid
>> [  116.146908][    T1] Could not create directory for event =
sys_enter_getgid
>> [  116.155163][    T1] Could not initialize trace point =
events/sys_enter_getegid
>> [  116.162370][    T1] Could not create directory for event =
sys_enter_getegid
>> [  116.178015][    T1] Could not initialize trace point =
events/sys_enter_setsid
>> [  116.185138][    T1] Could not create directory for event =
sys_enter_setsid
>> [  116.269307][    T1] Could not initialize trace point =
events/sys_enter_sched_yield
>> [  116.276811][    T1] Could not create directory for event =
sys_enter_sched_yield
>> [  116.527652][    T1] Could not initialize trace point =
events/sys_enter_munlockall
>> [  116.535126][    T1] Could not create directory for event =
sys_enter_munlockall
>> [  116.622096][    T1] Could not initialize trace point =
events/sys_enter_vhangup
>> [  116.629307][    T1] Could not create directory for event =
sys_enter_vhangup
>> [  116.783867][    T1] Could not initialize trace point =
events/sys_enter_sync
>> [  116.790819][    T1] Could not create directory for event =
sys_enter_sync
>> [  117.723402][    T1] pnp: PnP ACPI init
>=20
> I noticed that all of the above have zero parameters. Does the
> following patch fix it?
>=20
> (note, I prefer "ret" and "i" on different lines anyway)
>=20
> -- Steve
>=20
> diff --git a/kernel/trace/trace_syscalls.c =
b/kernel/trace/trace_syscalls.c
> index 53935259f701..abb70c71fe60 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -269,7 +269,8 @@ static int __init =
syscall_enter_define_fields(struct trace_event_call *call)
> 	struct syscall_trace_enter trace;
> 	struct syscall_metadata *meta =3D call->data;
> 	int offset =3D offsetof(typeof(trace), args);
> -	int ret, i;
> +	int ret =3D 0;
> +	int i;
>=20
> 	for (i =3D 0; i < meta->nb_args; i++) {
> 		ret =3D trace_define_field(call, meta->types[i],

Steve, those errors are still there in today=E2=80=99s linux-next. Is =
this patch on the way to the linux-next?


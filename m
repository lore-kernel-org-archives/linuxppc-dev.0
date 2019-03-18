Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0E4C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:33:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D9B2085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D9B2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NJZT0bYgzDqKD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 01:33:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NJXk1k4dzDq7w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 01:31:50 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id EA69172CC8C;
 Mon, 18 Mar 2019 17:31:47 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id C662E7CC74C; Mon, 18 Mar 2019 17:31:47 +0300 (MSK)
Date: Mon, 18 Mar 2019 17:31:47 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190318143147.GB27941@altlinux.org>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Content-Disposition: inline
In-Reply-To: <20190318104925.16600-3-sudeep.holla@arm.com>
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
Cc: Haibo Xu <haibo.xu@arm.com>, Steve Capper <Steve.Capper@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, jdike@addtoit.com, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Bin Lu <bin.lu@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--98e8jtXdkpgskNou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 10:49:21AM +0000, Sudeep Holla wrote:
> Currently each architecture handles PTRACE_SYSEMU in very similar way.
> It's completely arch independent and can be handled in the code helping
> to consolidate PTRACE_SYSEMU handling.
>=20
> Let's introduce a hook 'ptrace_syscall_enter' that arch specific syscall
> entry code can call.
>=20
> Cc: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  include/linux/ptrace.h |  1 +
>  kernel/ptrace.c        | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> index edb9b040c94c..e30f51e3363e 100644
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -407,6 +407,7 @@ static inline void user_single_step_report(struct pt_=
regs *regs)
>  #define current_user_stack_pointer() user_stack_pointer(current_pt_regs(=
))
>  #endif
> =20
> +extern long ptrace_syscall_enter(struct pt_regs *regs);
>  extern int task_current_syscall(struct task_struct *target, long *callno,
>  				unsigned long args[6], unsigned int maxargs,
>  				unsigned long *sp, unsigned long *pc);
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 4fa3b7f4c3c7..c9c505c483df 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -29,6 +29,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/cn_proc.h>
>  #include <linux/compat.h>
> +#include <linux/tracehook.h>
> =20
>  /*
>   * Access another process' address space via ptrace.
> @@ -557,6 +558,27 @@ static int ptrace_detach(struct task_struct *child, =
unsigned int data)
>  	return 0;
>  }
> =20
> +/*
> + * Hook to check and report for PTRACE_SYSEMU, can be called from arch
> + * arch syscall entry code
> + */
> +long ptrace_syscall_enter(struct pt_regs *regs)
> +{
> +#ifdef TIF_SYSCALL_EMU
> +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> +		if (tracehook_report_syscall_entry(regs))
> +			/*
> +			 * We can ignore the return code here as we need
> +			 * return -1 always for syscall emulation irrespective
> +			 * of whether the tracehook report fails or succeed.
> +			 */
> +			;

This is problematic as it causes build errors with -Werror=3Dempty-body,
see https://lore.kernel.org/lkml/20181218205305.26647-1-malat@debian.org/


--=20
ldv

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcj6vTAAoJEAVFT+BVnCUIZdoQAMNcDIAbaXHLJT0H192POtdF
rRwlBaKZeLHo9YKsCNI0YJWD5L6mrw6pzKrIb+O7w3fkel4k/BYhKJj0VKMriGWv
ZhB0qOsRMRj8ytIGzBP+g0EjB+OVO0KBDrR9aKa1Kh3lRIL95sECaoZkcI4xv3dw
5Gs46YNIHaKzXg/0kdAmKb6/FmTqC+0x7dB1KdvuIP8uKFNKOAaLwopTS6fmTVvd
SZPBuzeOhTvSvm73avmwwsLf2agniq9nFRiw1Q/3JWPxoRcJToRSozwudkm64z7J
OClyRZiOsFTvtXd/tiPZVPr17YhNR2f6XQYtqpWCMzSsbLpvO86cTFJcFIzpWfJr
ly+oeURC24KQK2jPjVLBeisugW074Kva0CqGYu/tKAUScWcvoXs6miNYv5/VoiIe
yZWr4WlJ5God4Tnk5Y/BFvm3fhwShy+u56VpLy1hX8QaEZUC+jSp0N9YrS5ufx7U
WMhdEHfXwfuoMtyAUSINxINFabH15RfC9P818lXmBs4tbKJs51OUQZ5OsyPF0MQn
+iPj1Ups+D+1m788lrQE6RsyC4/3piJNehIt7S+5K73UeMek/f2LA5rq+BSjjzBO
iJD6xpWwvqLg5mpAAn7Jdq0Wzz7g16auC2m+6F5pXeTA/a5Ju7qrPh1i1Xwx6qqH
osPsh+YtCIqvfsZn9TSQ
=fKg4
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--

Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82809C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:28:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F082085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F082085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NJT03pdVzDqKM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 01:28:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NJQQ6b5QzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 01:26:20 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 830F972CC53;
 Mon, 18 Mar 2019 17:26:18 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 5A5E57CC74C; Mon, 18 Mar 2019 17:26:18 +0300 (MSK)
Date: Mon, 18 Mar 2019 17:26:18 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190318142618.GA27941@altlinux.org>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-5-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20190318104925.16600-5-sudeep.holla@arm.com>
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


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 10:49:23AM +0000, Sudeep Holla wrote:
> Now that we have a new hook ptrace_syscall_enter that can be called from
> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> can do some cleanup using the same in do_syscall_trace_enter.
>=20
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/powerpc/kernel/ptrace.c | 48 ++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 2e2183b800a8..05579a5dcb12 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -3278,35 +3278,29 @@ long do_syscall_trace_enter(struct pt_regs *regs)
> =20
>  	user_exit();
> =20
> -	flags =3D READ_ONCE(current_thread_info()->flags) &
> -		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> -
> -	if (flags) {
> -		int rc =3D tracehook_report_syscall_entry(regs);
> +	if (unlikely(ptrace_syscall_enter(regs))) {
> +		/*
> +		 * A nonzero return code from tracehook_report_syscall_entry()
> +		 * tells us to prevent the syscall execution, but we are not
> +		 * going to execute it anyway.
> +		 *
> +		 * Returning -1 will skip the syscall execution. We want to
> +		 * avoid clobbering any registers, so we don't goto the skip
> +		 * label below.
> +		 */
> +		return -1;
> +	}

This comment is out of sync with the changed code.


--=20
ldv

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcj6qKAAoJEAVFT+BVnCUIpOUP/j1ZfG80n/XTu6EimciHcs9e
nhN3qmFqVCDXeuvQh8I/xncM25fHK+ftwsUQOij1bT2iecbY/yLxpFpfBcru1bho
Gp0hMlMCEQcxJ/2ArUKjL3HWIaeh8/ut63nLEgGARp0C4Zd14vnjNEZsJBtnZDvZ
/pKKGNKENgMzx/LH/8pouPQoLTLcTctLjpg7QCHhVgyf+cEjkcTPB2z7ityUXUGG
4WlGjWyo6qL9fMmUKrhQ+w1B2FyjsffRv0zKAyOG+p2edHGHEjfqw+Z4s2h8rJLL
nol9SN00msn5wFH83YJmkKolNAIVdDC3seGM2tiX4HROIqKK13MBr4ZqX37mQP7r
DClvWfuvCCH/NaIoyaq6f4YkkSboox2YDZVTjPQ9NPInoRUXZG3MuvL92eGh8wuZ
2sjwMWvBU1a+l+C8u0+U2Q/7FMWG8wYwkARiq5AqkNZmIV8dxhyXtY2+X8G3LIDe
/W1yzi2cYAlMU1oisoA4uYwrFHvUvd2K2jQYHXWvTX6tV7QFdiJNRv9DHdlOqmSL
cnMyjhOXPKL7bxsh39VvHQJHBP1hru9+IuGqGuLUgeF1nSDIbaFY5RsvwzTqzazJ
6z8f+gK+Odmt2B6n5zZnSFqCvzOiyQ3XYuRa9Xbfh8DSaDR5BwzqUp3MQZs6QbRI
DsJJJSfcDOCFdWJIYv+6
=JQDW
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

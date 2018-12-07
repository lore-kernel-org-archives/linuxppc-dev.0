Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FD3C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:22:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E881720850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 01:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E881720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439vny0NjKzDrSC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 12:21:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 439vlV3gCQzDqyZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 12:19:49 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 193CF72CC59;
 Fri,  7 Dec 2018 04:19:47 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 0F8B57CE6D8; Fri,  7 Dec 2018 04:19:47 +0300 (MSK)
Date: Fri, 7 Dec 2018 04:19:47 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181207011946.GA18558@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20181203031823.GE11573@altlinux.org>
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
Cc: Oleg Nesterov <oleg@redhat.com>, Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 06:18:23AM +0300, Dmitry V. Levin wrote:
> From: Elvira Khabirova <lineprinter@altlinux.org>
>=20
> Arch code should use tracehook_*() helpers, as documented
> in include/linux/tracehook.h,
> ptrace_report_syscall() is not expected to be used outside that file.
>=20
> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> v4: rewritten to call tracehook_report_syscall_entry() once, compile-test=
ed
> v3: add a descriptive comment
> v2: explicitly ignore tracehook_report_syscall_entry() return code
>=20
>  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++++-------------
>  1 file changed, 35 insertions(+), 19 deletions(-)

Sorry, this patch does not work, please ignore it.
However, the bug blocks PTRACE_GET_SYSCALL_INFO, so please fix it.

I'm going to use
	if (tracehook_report_syscall_entry(regs))
		return -1;
	return -1;
in the series until you have a better fix.


--=20
ldv

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcCcqyAAoJEAVFT+BVnCUIv3YQANKh5JInm3LUcCg1Lr4QIFuF
tnxoWgCsIctGlXXKzCwFCjeG3M7z8pNZmEkTYYQv1qcj3QVIXl5QT3KHtPx5QL/b
wKlgAHXE2NOHetBRmnz6Stj4lBk2LBWHWIO6RxwXvICCTQGF8HBYFjBtXoZALC4x
jL6BtMtdoysNm57rOPhagujznHz4qtQ9Q/JsaFO/Y2h0JrnbJ7CE9xi9cOAJuuPM
mYx0mN2eIdxQEQRL2UJJUbm0JjVJudC79HosgJ+E9s8uz3L6pb9K4fVkceglqHNe
yb51RFDoCSh2ZoJkoCYyDlLfIAUJ8Yca7kxA6on8471AHnyfap69sYsgOPBV05PW
5T+6vFjlrt4DTh1wj+cHgVcV6tH8QnVlIZkeziorizSGueNsgz+aBxrs2kguK454
DHCOcG1RTc4F9tnl+zHeSrh030qxB/ErjQPhmKCKV6YvbQmKheaVd9GvGjMLvdil
TQx+2MVHg0CWIv9lhEOYGIpYJsMbhjaJ+Ig/Q8kcc2qeIPi2OAmpuNYxgLKJ0CUE
RorHrwwqkRRHlJfo01uoQ++pz54xBT6dNvOlqTWDBoQz8yfkyTS6NDwVh1K5foEe
YCIbE0l+tsxIfE/BiMd9J3YYNWbQa8F1gBUj91w6/8qLroFpzpTCsS6iw9MXZH53
iZgyI2xUitmYWWsLTZFs
=+OO3
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

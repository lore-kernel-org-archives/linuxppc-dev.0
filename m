Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4193C64EB1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:44:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D80520837
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 15:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D80520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BGxZ5nRCzF09c
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 02:44:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 43BGvQ0p9zzDrTy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 02:42:57 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id A590772CC59;
 Fri,  7 Dec 2018 18:42:55 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 972197CE9E5; Fri,  7 Dec 2018 18:42:55 +0300 (MSK)
Date: Fri, 7 Dec 2018 18:42:55 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181207154255.GA28964@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <87y391k2tq.fsf@concordia.ellerman.id.au>
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

On Fri, Dec 07, 2018 at 10:12:49PM +1100, Michael Ellerman wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> writes:
> > On Mon, Dec 03, 2018 at 06:18:23AM +0300, Dmitry V. Levin wrote:
> >> From: Elvira Khabirova <lineprinter@altlinux.org>
> >>=20
> >> Arch code should use tracehook_*() helpers, as documented
> >> in include/linux/tracehook.h,
> >> ptrace_report_syscall() is not expected to be used outside that file.
> >>=20
> >> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> >> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> >> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> >> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> >> ---
> >> v4: rewritten to call tracehook_report_syscall_entry() once, compile-t=
ested
> >> v3: add a descriptive comment
> >> v2: explicitly ignore tracehook_report_syscall_entry() return code
> >>=20
> >>  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++++-------------
> >>  1 file changed, 35 insertions(+), 19 deletions(-)
> >
> > Sorry, this patch does not work, please ignore it.
>=20
> Hmm OK. Why exactly?

Unfortunately, I have no idea why it doesn't work.
All I can say is it breaks strace because the kernel no longer sends
syscall entry stops.

> I wrote more or less the same patch, although I used a temporary bool.
>=20
> > However, the bug blocks PTRACE_GET_SYSCALL_INFO, so please fix it.
>=20
> Sorry, didn't realise it was blocking you.

We are changing ptrace_report_syscall signature to implement
PTRACE_GET_SYSCALL_INFO, and this is the only place in the kernel besides
tracehook_report_syscall_*() that invokes ptrace_report_syscall() directly.

> > I'm going to use
> > 	if (tracehook_report_syscall_entry(regs))
> > 		return -1;
> > 	return -1;
> > in the series until you have a better fix.
>=20
> Yeah that's fine by me. I could send that to Linus for 4.20 if you want
> me to, otherwise I'm fine for you to carry it in your series.

Yes, please.  I'll send a v5 shortly.


--=20
ldv

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcCpT/AAoJEAVFT+BVnCUIMbMQAL8L5afzlG2FpQERgK3jWn4a
Z+3/hu+dsem3sacLEskTymxnyV7lCNvHvz4kcvNB/wfwbbsaEScu4RveZIMq86E3
TCu/kWvfYdrxB/Xux9hoZLyxYG3xhd2Jg8I/4PuHG2p8AeamnykVFqLFXlDxYkJq
gLmbjUxA0flkXoL+Ts9WyIA6X5FYxWY2zaiVgwZ52QSZt6JoyfmiMMYsvAolRtPP
1C0pJo1ZbPkBUTRI0FXIbbjik3y5tDX/6grLCcDIMBL8/UYRfFDchHmnBtrAkKk6
L4XzlNX52qWhj7Zlqy5byF1a8Tlyq1GCaXOVl/d7whTDDy96dWWI5HzONhLlU0RD
QUfTzthXeReNHBMFPW9w3k+iu9DOmlZSy5q8UBq7m8WlNzSAlxvX5fJaTmJA8E57
uWq1/Sn5abplHuZuom4hourp8+mOxFfL6jyoeraqYTNKgWm+0vIDqw3CU5sERfty
f/Fb4OBwzm+VMcuQAa6qO5eQMkN6roaEG4uTS1TpiJNrVJERyUTcIei/q41VPVBU
vagvDi4wERzCKWF0oA611+EKb4UGOlZ9+nC9eKOOLEckf5uOdOu8CVwFtiK994s5
vpB7YSejmG85ujZkiAXI11jhOnGZlkmEMRhSk+RyKRTT8PbUurm929qnbdWkuxlU
DyJAIAZjeq7+uQSRXS/B
=ekme
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

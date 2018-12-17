Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26DFC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:26:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745282133F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 11:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745282133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JJl92PtpzDqYS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 22:26:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 43JJgs61x4zDqX7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 22:23:52 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 0089E72CA5E;
 Mon, 17 Dec 2018 14:23:51 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id E4340964720; Mon, 17 Dec 2018 14:23:50 +0300 (MSK)
Date: Mon, 17 Dec 2018 14:23:50 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ptrace: cleanup do_syscall_trace_enter
Message-ID: <20181217112350.GB5778@altlinux.org>
References: <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org>
 <20181210132806.GA4177@redhat.com>
 <20181210133655.GH11942@altlinux.org>
 <20181216172828.GA25359@altlinux.org>
 <87y38otn5x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <87y38otn5x.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 17, 2018 at 10:20:26PM +1100, Michael Ellerman wrote:
> "Dmitry V. Levin" <ldv@altlinux.org> writes:
> > Invoke tracehook_report_syscall_entry once.
>=20
> Thanks.
>=20
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > ---
> >  arch/powerpc/kernel/ptrace.c | 54 +++++++++++++++++++++---------------
> >  1 file changed, 31 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> > index 714c3480c52d..8794d32c2d9e 100644
> > --- a/arch/powerpc/kernel/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace.c
> > @@ -3263,32 +3263,40 @@ static inline int do_seccomp(struct pt_regs *re=
gs) { return 0; }
> >   */
> >  long do_syscall_trace_enter(struct pt_regs *regs)
> >  {
> > +	u32 cached_flags;
> > +
>=20
> Do you mind if I just call it "flags", I find "cached_flags" a bit
> unwieldy for some reason.
>=20
> I'm happy to fix it up when applying.

No problem, feel free to call it whatever you like.  Thanks,


--=20
ldv

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcF4dGAAoJEAVFT+BVnCUIqN0P/ROF4ZwS3xzAexyXGTVWOSqK
j/l3IVN+IZCQFAXjHBHn8b2p/6/WlQiImJFykJIv1SwkrbXZ66k387FdcbGywlix
T6vK3lq1r4jPqC3QhrBWQvYkpeX5hkmG698r4Z6WoMW9G12Z407ScGpSAlLEDNsR
PspeHVKs0keASgix/Xt7S0MHhryLgDhQjnKFzbJkLzSc8RtThNVtZY2JI/rzVYGQ
apa5KQ+rnhILwyG2yLA0qo4JJynexUeXHuUmXLyTyvlEEMTPloAO4WcFJxITWI++
ofwWoyJQZPDOpfIwo8JXO/mhs/Nds0X1Hnmo+eHOx4D0K91UGhlzfTbZ6IaoMKK0
mtLQPcyjflircLerqZ+HxslzovnVSIc3vLSTaHpqf75qLiEswwz1WucYhjWqvLMc
0ZkXBrsv4R6lVwLDtN0iRBMtUMpR7IbZpyz4qJV8+5vj2rJkOx6ayuk7HfjWN/Ir
UCvR/0lg3oZRPPZjMWf0pi1bjVeM2ivVdz2oCv79nYJ5AhVo46j5HZReFWAT8jrP
ZkqzbZE+cL++oHM/PbWBxDcbaM3Ai6bfm7kI7ti3f7abTC4pqgQIG8xsoZkcv0uc
1B81/fWYG6jtsr0G2mc9sS3EBOBLsLaipgD8BX5YwGAw+y6MMS9o3bLepPFOp+S+
NSfp2wySjVujD8Ti0h0u
=bfGc
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

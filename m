Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B38C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:39:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6632C2084E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6632C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D40y3kGPzDqGZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 00:38:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 43D3yh6b6czDqqW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 00:36:59 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id AABB472CC66;
 Mon, 10 Dec 2018 16:36:56 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id D9F1F7CF1FC; Mon, 10 Dec 2018 16:36:55 +0300 (MSK)
Date: Mon, 10 Dec 2018 16:36:55 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v6] powerpc/ptrace: replace ptrace_report_syscall() with
 a tracehook call
Message-ID: <20181210133655.GH11942@altlinux.org>
References: <87ftw12nyn.fsf@concordia.ellerman.id.au>
 <20181119210139.GA8360@altlinux.org>
 <87efbe166y.fsf@concordia.ellerman.id.au>
 <20181203031823.GE11573@altlinux.org>
 <20181207011946.GA18558@altlinux.org>
 <87y391k2tq.fsf@concordia.ellerman.id.au>
 <20181207154255.GA28964@altlinux.org>
 <20181207155605.GB28964@altlinux.org>
 <20181207185226.GB31278@altlinux.org>
 <20181210132806.GA4177@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <20181210132806.GA4177@redhat.com>
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
Cc: Eugene Syromyatnikov <esyr@redhat.com>, linux-kernel@vger.kernel.org,
 Elvira Khabirova <lineprinter@altlinux.org>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 02:28:07PM +0100, Oleg Nesterov wrote:
> On 12/07, Dmitry V. Levin wrote:
> >
> > Please make either v5 or v6 edition of this fix, or any similar fix,
> > into v4.20.
>=20
> IIUC, v5 above means
>=20
> 	[PATCH v5 23/25] powerpc/ptrace: replace ptrace_report_syscall() with a =
tracehook call
>=20
> you sent in another series...

They just happen to have the same v5 here and there.
In that series I included the most trivial variant of the change.

> >  long do_syscall_trace_enter(struct pt_regs *regs)
> >  {
> > +	struct thread_info *ti;
> > +	u32 cached_flags;
> > +
> >  	user_exit();
> > =20
> > -	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> > -		ptrace_report_syscall(regs);
> > -		/*
> > -		 * Returning -1 will skip the syscall execution. We want to
> > -		 * avoid clobbering any register also, thus, not 'gotoing'
> > -		 * skip label.
> > -		 */
> > -		return -1;
> > -	}
> > +	ti =3D current_thread_info();
> > +	cached_flags =3D READ_ONCE(ti->flags) &
> > +		       (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE |
> > +			_TIF_SYSCALL_TRACEPOINT);
> > =20
> > -	/*
> > -	 * The tracer may decide to abort the syscall, if so tracehook
> > -	 * will return !0. Note that the tracer may also just change
> > -	 * regs->gpr[0] to an invalid syscall number, that is handled
> > -	 * below on the exit path.
> > -	 */
> > -	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> > -	    tracehook_report_syscall_entry(regs))
> > -		goto skip;
> > +	if (cached_flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> > +		int rc =3D tracehook_report_syscall_entry(regs);
> > +
> > +		if (unlikely(cached_flags & _TIF_SYSCALL_EMU)) {
> > +			/*
> > +			 * A nonzero return code from
> > +			 * tracehook_report_syscall_entry() tells us
> > +			 * to prevent the syscall execution, but
> > +			 * we are not going to execute it anyway.
> > +			 *
> > +			 * Returning -1 will skip the syscall execution.
> > +			 * We want to avoid clobbering any register also,
> > +			 * thus, not 'gotoing' skip label.
> > +			 */
> > +			return -1;
> > +		}
> > +
> > +		if (rc) {
> > +			/*
> > +			 * The tracer decided to abort the syscall.
> > +			 * Note that the tracer may also just change
> > +			 * regs->gpr[0] to an invalid syscall number,
> > +			 * that is handled below on the exit path.
> > +			 */
> > +			goto skip;
> > +		}
> > +	}
> > =20
> >  	/* Run seccomp after ptrace; allow it to set gpr[3]. */
> >  	if (do_seccomp(regs))
> > @@ -3293,7 +3309,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
> >  	if (regs->gpr[0] >=3D NR_syscalls)
> >  		goto skip;
> > =20
> > -	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> > +	if (unlikely(cached_flags & _TIF_SYSCALL_TRACEPOINT))
>=20
> I will leave this to maintainers, but to me this change looks good and im=
o it
> also cleanups the code.
>=20
> However I am not sure cached_flags should include _TIF_SYSCALL_TRACEPOINT=
=2E If
> nothing else, the caller can sleep in ptrace_stop() unpredictably long and
> TIF_SYSCALL_TRACEPOINT can be set/cleared meanwhile.

I agree, we shouldn't cache _TIF_SYSCALL_TRACEPOINT.


--=20
ldv

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcDmv3AAoJEAVFT+BVnCUIlrIQAPHIWnElYZge8NS1F64p0iO0
lXFKC/o5wdwokgzUtyLf3ngHyBHrjhJr16swFMKVs5PZoXFQtueXLBwJccvJFwbD
6e2sNrh7g0Mt07dfzEFeKYpYl6z6QLrFUFNDtJXchwnRf8vN6Qt8Eu4H4UDnY5kZ
ic8KgON/Gg0JJ/b7dLqZZcynmBV6+xhgQSCUh0et4eHeCzW9cKJa5p3N46/QC4Kz
ybhuVCiAIei8Xiy51v+/nWbPW+asWWJFJY/HQimNVHbPQwnFrfC2jThpUq7Jcs+5
fkmQtsQHDhvew5+ZL57lt3Xqq+wsbRJWAOIWBVfSj3+iwyJx8LDdtxZr+R0GOF6K
8aV1APcWpDVdqowvYbfYlqCdNHyRWkYPmedIr/VZAJmperyBeCgXx2Ojqs5Wiz20
2hcjXExfQ0m4r79k9TZb82rp2Vq9HqgPs+buQA6tEsxh5iHAsPE+5g4qJWSoXoXY
XkVl+FRNCWSlZCM+hNG17mjR9kf5n3PReFnpEQk+U/2VBo6O2n4j/E/Kfx2ct7T+
l1jm/EaHocoRy+gx0vaDNM+ozwVibqRu8FiAtpJw2hG4Cw9LKMTBGJtQTOVGDitE
aE3L1TfAVHwiRBL1gZTqNMOX+V+Lj3sviL2QE1idOtCPqlyAu9fKU3nJXZc7z7Lw
5Vu3dgy6Nik8QSZRcwR8
=bgMo
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--

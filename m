Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538AAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4FE20872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4FE20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NJnV2YJszDqJ7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 01:42:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NJlc65p1zDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 01:41:16 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 3C2B072CC53;
 Mon, 18 Mar 2019 17:41:15 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 273227CC74C; Mon, 18 Mar 2019 17:41:15 +0300 (MSK)
Date: Mon, 18 Mar 2019 17:41:15 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190318144115.GC27941@altlinux.org>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
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


--V88s5gaDVPzZ0KCq
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

Sorry if I'm late for the party, but the new name looks confusing.
If all it does is related to TIF_SYSCALL_EMU, why does it have a generic
name 'ptrace_syscall_enter' without any hint of being specific to
TIF_SYSCALL_EMU?


--=20
ldv

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcj64KAAoJEAVFT+BVnCUIxpQP/jwIu65MqEkZ5bTrcyYeWRHb
UfiJ2PNmJZ0oW8kKkFfTLL/KpldqRSotVfyVOCu41DfhC1LLouF4LHIlCVObRBj/
2KRgYkPZbfl1dZ7ErIT6O+YxR5n7ygdP379A5DGIbz2gzm0X2q+I2CjFFIbbyBuQ
N8rF1cijb1CCpoHaxDNWtNzTL9gV0fH+kKqNttarKFHV5EYPckR9bat31dktab74
74nI81OVtR3PYJMlWiR9HKS3JBVp9LLZ2wGMmELhwHG6nmEpgoYJwYy4wwlwf+6E
DgYZOa2SWx/cdLrQpSF98UjSDd5qoHe1Aycg1cyfbx+Y5/VQBBi72Jb5EwAbyHtZ
J0sD0bAueGNOiftyPRDaChSjfIygtUvWsdBjPOXyaz7HSwngussKpFHVopg5mEna
ZwzSYFvTcd6mLgX05mKtlQFzYPWHTX/13Hcrtdc+61ABSVbVfkuft5/28H1tO7T5
W9Rwiahj2LS4Ud9IzHAPOvqfQywJSOy2djKvVbh9jDyjyXLh/H7V0ozP3aDLx6U1
VH39RmwNHTVRAlRcEEMtwKvtXUkNvI4aRMwsVfrzv+g2LSx0AgDzcXPRDgbIc5yO
rP35A23jtqYdzjplzZjH+JbpRFS8xXoExHYHryXcA3CGGFpJ/9ztMnlkjAR0N0Y3
q0ftG5tIPuT0RCghzjIm
=YZtt
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

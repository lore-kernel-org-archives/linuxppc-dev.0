Return-Path: <SRS0=3D1i=7S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9125C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 23:56:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3612D206E6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 23:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jqxmSjo8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3612D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49f00j2PrWzDqgn
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2020 09:56:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=protonmail.com (client-ip=185.70.40.134;
 helo=mail-40134.protonmail.ch; envelope-from=skirmisher@protonmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256
 header.s=protonmail header.b=jqxmSjo8; 
 dkim-atps=neutral
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch
 [185.70.40.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49dzyf3mY0zDqjL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2020 09:54:32 +1000 (AEST)
Date: Fri, 05 Jun 2020 23:54:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1591401267;
 bh=JKks3LOMQ1NeFcSN16pzvwRRT3Htb5zFNM9rJBc29R8=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=jqxmSjo84b4+OfM9DtmNEXkt2gAOy9gj58dlnN+ObQlaVihWYs89OX9b1Oz6btKZs
 3yPmNTgoI8z+6HE2dAT1hLu/O9+BCz7SGzfmscljf9FsUKLBHGUiDcoQObmWdkPhWo
 GE9+YODGho/zsVIAvn2tkYS6N9FwxBGDenThiUjM=
To: linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>
From: Will Springer <skirmisher@protonmail.com>
Subject: Re: ppc64le and 32-bit LE userland compatibility
Message-ID: <1787237.g5d078U9FE@sheen>
In-Reply-To: <2498690.q0ZmV6gNhb@sheen>
References: <2047231.C4sosBPzcN@sheen>
 <8be94d2e-8e20-52b6-22e6-152b79a94139@csgroup.eu>
 <2498690.q0ZmV6gNhb@sheen>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Will Springer <skirmisher@protonmail.com>
Cc: libc-alpha@sourceware.org, eery@paperfox.es, daniel@octaforge.org,
 musl@lists.openwall.com, binutils@sourceware.org, libc-dev@lists.llvm.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Saturday, May 30, 2020 3:17:24 PM PDT Will Springer wrote:
> On Saturday, May 30, 2020 8:37:43 AM PDT Christophe Leroy wrote:
> > There is a series at
> > https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D173231
> > to switch powerpc to the Generic C VDSO.
> >=20
> > Can you try and see whether it fixes your issue ?
> >=20
> > Christophe
>=20
> Sure thing, I spotted that after making the initial post. Will report
> back with results.
>=20
> Will [she/her]

Sorry for the wait, I just sat down to work on this again yesterday.

Tested this series on top of stable/linux-5.7.y (5.7.0 at the time of=20
writing), plus the one-line signal handler patch. Had to rewind to the=20
state of powerpc/merge at the time of the mail before the patch would=20
apply, then cherry-picked to 5.6 until I realized the patchset used some=20
functionality that didn't land until 5.7, so I moved it there.

Good news is that `date` now works correctly with the vdso call in 32-bit=
=20
LE. Bad news is it seems to have broken things on the 64-bit side=E2=80=
=94in my=20
testing, Void kicks off runit but hangs after starting eudev, and in a=20
Debian Stretch system, systemd doesn't get to the point of printing=20
anything whatsoever. (I had to `init=3D/bin/sh` to confirm the date worked=
=20
in ppcle, although in ppc64le running `date` also hung the system when it=
=20
made the vdso call...) Not sure how to approach debugging that, so I'd=20
appreciate any pointers.

Will [she/her]




Return-Path: <SRS0=4G4N=V5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B07C433FF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 12:50:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD19D20665
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD19D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zqrj1dG1zDqgG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=bugzilla.kernel.org
 (client-ip=198.145.29.98; helo=mail.wl.linuxfoundation.org;
 envelope-from=bugzilla-daemon@bugzilla.kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.wl.linuxfoundation.org (mail.wl.linuxfoundation.org
 [198.145.29.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zqnR2B55zDqld
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2019 22:47:22 +1000 (AEST)
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 38517285DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2019 12:47:20 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
 id 2C72B285FB; Thu,  1 Aug 2019 12:47:20 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 204371] BUG kmalloc-4k (Tainted: G        W        ): Object
 padding overwritten
Date: Thu, 01 Aug 2019 12:47:19 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Memory Management
X-Bugzilla-Component: Slab Allocator
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: akpm@linux-foundation.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-204371-206035-FJ4o58Kg5c@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204371-206035@https.bugzilla.kernel.org/>
References: <bug-204371-206035@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D204371

--- Comment #5 from Erhard F. (erhard_f@mailbox.org) ---
On Wed, 31 Jul 2019 12:09:54 +0000
bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D204371
>=20
> --- Comment #4 from mpe@ellerman.id.au ---
>
> > I suspect proc_cgroup_show() is innocent and that perhaps
> > bpf_prepare_filter() had a memory scribble.  iirc there has been at
> > least one recent pretty serious bpf fix applied recently.  Can others
> > please take a look?=20=20
>=20
> I haven't been able to reproduce this on a 64-bit or 32-bit powerpc
> machine here. But I don't run gentoo userspace, so I suspect I'm not
> tripping the same path at boot. I did run the seccomp selftest and that
> didn't trip it either.
>=20
> cheers

Doing some fiddling around on another bug (bug #204375), I noticed that I g=
et
this "kmalloc-4k (Tainted: G W ): Object padding overwritten" during boot o=
nly
when I boot from my btrfs partition, but not from my other ext4 partition. =
The
ext4 partition is not a clone, but pretty much the same stuff in the same
versions. My btrfs root is mounted with 'lazytime,compress=3Dzstd:1', syste=
md is
242.

I built a 5.2.5 kernel on the Talos II with CONFIG_SLUB_DEBUG=3Dy but here I
don't hit the bug, even if I boot from a btrfs partition with the same
settings. Have to test it on the G5 yet (kernel .config more similar to the=
 G4
one than the Talos II one).

--=20
You are receiving this mail because:
You are on the CC list for the bug.=

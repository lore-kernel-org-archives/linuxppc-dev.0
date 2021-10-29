Return-Path: <SRS0=h3rJ=PR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE9C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 14:07:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940C960F0F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Oct 2021 14:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 940C960F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HgklS0dGCz3c71
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Oct 2021 01:07:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iMrM6CHZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bugzilla.kernel.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=bugzilla-daemon@bugzilla.kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iMrM6CHZ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hgkkg1M4Pz2xDD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Oct 2021 01:06:51 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id B00E561181
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Oct 2021 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635516408;
 bh=fP9BDD+7DJKGGsneKyZAhEA/up1XD2J0wgKg8KGJEjE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=iMrM6CHZnEqdMYPUUUp1c0+0ot/veX5/5L1FhrIYv9AB1UsoyICud/tLQ0u57MP78
 r+EuQ2/b5EVw93JURiKA3E8769OO+Yprh+KoD2/QgXbOvjAt1sphNIEio4+A+WfiTC
 H7mDR88FMvtDR+fmjL/oIL8Iui4hgwdwrNCgmmBRqYHXd6sv+9z0DLF/BRhUwQBGOm
 C8us4LLxkYmijXcWtp/NoCGCotfMxZ7ZqoT5AdkDIgRx537S4KdddqYIkQeaJdzfH7
 qBVp1dQpNVuWl5o9wPNjcYFEaiR9ASA2a2+088A0v6GaJ4/RVPKsIcDun5cHlqavBr
 zCI38U3HTL11Q==
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 214867] UBSAN: shift-out-of-bounds in
 drivers/of/unittest.c:1933:36
Date: Fri, 29 Oct 2021 14:06:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arnd@arndb.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-214867-206035-GIomzJUZtE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214867-206035@https.bugzilla.kernel.org/>
References: <bug-214867-206035@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D214867

Arnd Bergmann (arnd@arndb.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |arnd@arndb.de

--- Comment #2 from Arnd Bergmann (arnd@arndb.de) ---
This is the function that triggers it:

static void of_unittest_untrack_overlay(int id)
{
        if (overlay_first_id < 0)
                return;
        id -=3D overlay_first_id;
        if (WARN_ON(id >=3D MAX_UNITTEST_OVERLAYS))
                return;
        overlay_id_bits[BIT_WORD(id)] &=3D ~BIT_MASK(id);
}

My guess is that 'id' is negative here, which means it fails to tigger the
WARN_ON() but ends up still being out of range.

Can you try changing it to 'unsigned int id'?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

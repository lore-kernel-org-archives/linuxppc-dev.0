Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D475C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Dec 2021 11:44:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J8sdK5XRfz3cJ9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Dec 2021 22:44:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RccLqVPo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bugzilla.kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=bugzilla-daemon@bugzilla.kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RccLqVPo; 
 dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J8scX1m2Xz2yp0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Dec 2021 22:43:39 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 5D0C0CE1FD9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Dec 2021 11:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86CBCC004DD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Dec 2021 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639050215;
 bh=UtO++GAU+tffWgnu6sxGlAIdat0m2HF7g0gXcsi1ads=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=RccLqVPozIwM4O5o6R8mlLLIMWKIbH2wY9jJyiR5Q6qNChiSgL8lgP0VVfcZ87jdR
 g3e+lhGStYtqALuuzCgkO5XbxwleoJ7gyQZyxxpYNFwlSKYw1ILLZyfdZmtmZrcUWP
 tr3+5jFqDDuDrvRbgl2AE3+FwtXAlHEL39vGgKUnt0oeugmq4zwDcqCouT6yUBFvqc
 DyYLrlU7+2M1eZMlmkylzilPeon/jT1S1Unf74WgqlS5F4m81wi+I12RM+lGv3u4cx
 7iI4lbBgjTuqtqBpTouZLcjVDwTCVX2JmFzF+VwufUj2A6dHLDiLeapAne9f0iZ9nL
 nEmiTT83Tr5iA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
 id 5F97060F48; Thu,  9 Dec 2021 11:43:35 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 214913] [xfstests generic/051] BUG: Kernel NULL pointer
 dereference on read at 0x00000108 NIP [c0000000000372e4]
 tm_cgpr_active+0x14/0x40
Date: Thu, 09 Dec 2021 11:43:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: michael@ellerman.id.au
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-214913-206035-OGs6G81o1I@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214913-206035@https.bugzilla.kernel.org/>
References: <bug-214913-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D214913

Michael Ellerman (michael@ellerman.id.au) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |NEEDINFO

--- Comment #5 from Michael Ellerman (michael@ellerman.id.au) ---
Sorry I don't have any idea which commit could have fixed this.

The process that crashed was "fsstress", do you know if it uses io_uring?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

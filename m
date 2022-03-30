Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C65C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Mar 2022 22:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KTMHw35h7z3c5q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Mar 2022 09:56:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RNMfv9tf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RNMfv9tf; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KTMGs41DSz3c1R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2022 09:55:49 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D945561583
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2022 22:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AC75C340F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2022 22:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648680947;
 bh=5bE3PIh+FhsmcfBHtWzZKsLDlfeNOnhmpbocQZHMiXQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=RNMfv9tf/uSyQKxUtv6awlNTvA5a1+KapMbaEIUFrUkM9F4II44oF79CUvlrR2Wpg
 03vO8qS0TmSe6zUfRRJvNy9RIpeOKkK18E1I4fe2NdTey5kMDADFT1V05b4LTRmflT
 tKNxZR78ibXnjPSZFM1UOVEUh4nHE0iq9Fa78oMntPfFyKZicrKWeE/KNgUyBFydFV
 Ws26vV62lZmg5dVw2kiyhDMUY6l165ijaGBz5QgOU3llJAKR+EDamMi0Ek/w0YyH9V
 6BiQzL7ne8XzvVHxagOChGgOdApy5/Pqm1CkP0AkjuE0x83TC05T34l5fyQKqcWtev
 M9n9PA1x/jFbQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 2D2D1C05FD0; Wed, 30 Mar 2022 22:55:47 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 215781] Highmem support broken on kernels greater 5.15.x on
 ppc32?
Date: Wed, 30 Mar 2022 22:55:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215781-206035-6DQLTP53KV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215781-206035@https.bugzilla.kernel.org/>
References: <bug-215781-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D215781

--- Comment #3 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 300667
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300667&action=3Dedit
kernel .config (5.15.32, PowerMac G4 DP)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

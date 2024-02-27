Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB152C54798
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Feb 2024 15:26:01 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lngqx0gn;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TkhCD37PZz3vYR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Feb 2024 02:26:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lngqx0gn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=bugzilla-daemon@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TkhBR1HjBz3cgg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2024 02:25:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8624661382
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2024 15:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F0E9C43390
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2024 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709047511;
	bh=UryvTjfqMoPpmzsQj06lFqEX2OqETj5ckxvwyycfVjE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lngqx0gnF7edxl5J0xW9ditD7QFL8Nsd5bdaLhwmLmxT4gwwSpt3VNkEnUYsQwZSc
	 X5pX0e3MCCHClULMXt7pxbPZVMJldaKpohKXFhZ+AIB7F+K78sFglZbS7nCwEAxRgi
	 P0dEmy8RZz15D97oEZMuluqh9Eo2Xo48efFuklHtlH44hrOYETkKSFaNaN7MEC1OC2
	 7PI7ifvxSt6b/c5georlalc/YFWvbb4CH70wYkvmsbZa8mEg1wEO1dq8fkqpEF8QGL
	 Y5KjP/rcVQgDY62cEH2eDG8yMle32YY5t94MjdNaEgLO/7fem091jVwirgSAbOL9au
	 Tp+URMCdWeOvg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0FA5CC53BC6; Tue, 27 Feb 2024 15:25:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 207129] PowerMac G4 DP (5.6.2 debug kernel + inline KASAN)
 freezes shortly after booting with "do_IRQ: stack overflow: 1760"
Date: Tue, 27 Feb 2024 15:25:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: christophe.leroy@csgroup.eu
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207129-206035-WIslPzcryo@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207129-206035@https.bugzilla.kernel.org/>
References: <bug-207129-206035@https.bugzilla.kernel.org/>
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D207129

--- Comment #10 from Christophe Leroy (christophe.leroy@csgroup.eu) ---
I built a kernel with your .config, the problem is a size problem.

PPC32 kernels are not designed to be that big.

Extract from generated System.map:
  c2394000 D _etext
  c2800000 T _sinittext
  c2bf5000 B _end

You need to keep the size of the kernel below 32Mbytes, or a deep work is
required to enable the kernel to perform far jumps before the kernel is
relocated.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

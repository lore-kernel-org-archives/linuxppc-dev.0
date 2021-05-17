Return-Path: <SRS0=r+Zg=KM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF7CC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 06:21:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7C461166
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 06:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7C461166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fk8D74CP0z3byC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 May 2021 16:21:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=I8WJRMAT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bugzilla.kernel.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=bugzilla-daemon@bugzilla.kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=I8WJRMAT; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fk8CZ1NyFz2xgN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2021 16:21:14 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D75861221
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 May 2021 06:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621232469;
 bh=eZCA5a91xEXYITRRlFq8s8S47/suiy5RVH/PV/p4pzc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=I8WJRMAThylaHok2MCUsoktuTKN9OersvJcvkyHR6lt0AkSoFDFFVIn4UEXfv3fuV
 CKifkFmW0ZPLKOl5SWac6bnmT8aZmMvuXIhBXNWAcQd+5EgI1X8alIFEVn15U0DAA9
 UwEjHL7w8AAG7FUQEzjp5l6UnWCdiCdnJC2FpQFMbwZfyjKXBJcSbG+pOHm51teika
 L469Pfq+QUoDC/fGzFkDUzBRRMNWhFtKeuFIMRypjMt+hCGVzy17riNuqYbPYxWdDF
 VnsVT9P8qH8TW81SE2dTAbd35EKS8mRKKrv+OTCKWHE4FxZLaYcMEBgJjqZ0xgSzy1
 gGyku/GIkP7KQ==
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 213069] kernel BUG at
 arch/powerpc/include/asm/book3s/64/hash-4k.h:147! Oops: Exception in kernel
 mode, sig: 5 [#1]
Date: Mon, 17 May 2021 06:21:09 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: christophe.leroy@csgroup.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213069-206035-Dy9D6J7JJz@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213069-206035@https.bugzilla.kernel.org/>
References: <bug-213069-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D213069

Christophe Leroy (christophe.leroy@csgroup.eu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |christophe.leroy@csgroup.eu

--- Comment #2 from Christophe Leroy (christophe.leroy@csgroup.eu) ---
The bug is not in powerpc but in function pmd_basic_tests() in
mm/debug_vm_pgtable.c
(https://elixir.bootlin.com/linux/v5.13-rc1/source/mm/debug_vm_pgtable.c#L1=
46)

pfn_pmd() should not be called before the has_transparent_hugepage()
verification.

Same problem in pmd_advanced_tests()

And there is the exact same issue with PUD tests with pfn_pud() function.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

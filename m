Return-Path: <SRS0=MZVM=KK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E431C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 14:51:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3CF1613BE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 May 2021 14:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3CF1613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fj7cg1H2Bz3brt
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 May 2021 00:50:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=k6huVDef;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bugzilla.kernel.org (client-ip=198.145.29.99;
 helo=mail.kernel.org; envelope-from=bugzilla-daemon@bugzilla.kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=k6huVDef; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fj7c33Hxzz2y6F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 May 2021 00:50:27 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 33468613BC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 May 2021 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621090224;
 bh=DblqBpSZ9DtgL8xuVILZ6vtEycmWWAICZaopcfTsEMw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=k6huVDefspkOhZ0cuPq4FhgPqOBDJHun6kzNex8V5oUyKzK2QaCiP/UkejpbI1x64
 sLD1GPrqAIOvg/0anbY3GSKCUp68c2uxyz2+bAr3SEf21UzhY9iArfKYP+0P5tGXYi
 ovMGwSHQl00T/ILZJD1qNlGXq8x2/xiq1RexhCzYKGdC23GDCcQT5hKKg3Hw0hHVdt
 cgKP6kQmPOcIwM1F26seb93Dv0XsVT7GxqU12vJqbBCl0NOjyRxUWK2h37EMrfLPob
 jcExOT3QtojC/d52s8AusX4JcGvhcWE+l0B30VbPtfzim3ddPcSZkI42pdo+SaA4w+
 ZaIw48iim9W/A==
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 213079] IRQ problems and crashes on a PowerMac G5 with 5.12.3
Date: Sat, 15 May 2021 14:50:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version short_desc
Message-ID: <bug-213079-206035-sXP5mtkrIk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213079-206035@https.bugzilla.kernel.org/>
References: <bug-213079-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D213079

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|5.13-rc1                    |5.12.3
            Summary|IRQ problems and crashes on |IRQ problems and crashes on
                   |a PowerMac G5 with 5.13-rc1 |a PowerMac G5 with 5.12.3

--- Comment #3 from Erhard F. (erhard_f@mailbox.org) ---
Some time after the "irq 63: nobody cared" on 5.12.3:

[...]
--- interrupt: 500
[<000000000e5af612>] .nvme_irq
[<000000000e5af612>] .nvme_irq
Disabling IRQ #63
Call Trace:
Kernel panic - not syncing: corrupted stack end detected inside scheduler
CPU: 0 PID: 105549 Comm: kworker/u4:1 Tainted: G        W=20=20=20=20=20=20=
=20=20
5.12.3-gentoo-PowerMacG5 #2
Workqueue:  0x0 (flush-259:0)
[c000000078dc79f0] [c00000000053950c] .dump_stack+0xe0/0x13c (unreliable)
[c000000078dc7a90] [c000000000066074] .panic+0x168/0x430
[c000000078dc7b40] [c0000000007f19f0] .__schedule+0x80/0x848
[c000000078dc7c20] [c0000000007f2270] .schedule+0xb8/0x110
[c000000078dc7ca0] [c000000000086d18] .worker_thread+0x278/0x290
[c000000078dc7d60] [c00000000008e75c] .kthread+0x134/0x13c
[c000000078dc7e10] [c00000000000b1f4] .ret_from_kernel_thread+0x58/0x64
Rebooting in 120 seconds..

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

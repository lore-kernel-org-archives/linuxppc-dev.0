Return-Path: <SRS0=bUW7=VN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A93C76188
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 09:00:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7C920880
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 09:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7C920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nvWJ74SKzDqPm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 19:00:44 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nvSx2JrfzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 18:58:40 +1000 (AEST)
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 313C4285B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 08:58:38 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
 id 25BD9285A9; Tue, 16 Jul 2019 08:58:38 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 203647] Locking API testsuite fails "mixed read-lock/lock-write
 ABBA" rlock on kernels >=4.14.x
Date: Tue, 16 Jul 2019 08:58:37 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: matorola@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DOCUMENTED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203647-206035-0zdwA3O9aN@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203647-206035@https.bugzilla.kernel.org/>
References: <bug-203647-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D203647

Anatoly Pugachev (matorola@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matorola@gmail.com

--- Comment #7 from Anatoly Pugachev (matorola@gmail.com) ---
it's the same for sparc64:

`
[    0.000020] PROMLIB: Sun IEEE Boot Prom 'OBP 4.38.12 2018/03/28 14:54'
[    0.000032] PROMLIB: Root node compatible: sun4v
[    0.000080] Linux version 5.2.0-10808-g9637d517347e (mator@ttip) (gcc
version 8.3.0 (Debian 8.3.0-7)) #1080 SMP Tue Jul 16 10:46:19 MSK 2019
[    0.000386] printk: bootconsole [earlyprom0] enabled
[    0.000441] ARCH: SUN4V
...
[    0.451068]  memory used by lock dependency info: 3855 kB
[    0.451104]  per task-struct memory footprint: 1920 bytes
[    0.451140] ------------------------
[    0.451167] | Locking API testsuite:
[    0.451194]
----------------------------------------------------------------------------
[    0.451244]                                  | spin |wlock |rlock |mutex=
 |
wsem | rsem |
[    0.451294]=20=20
--------------------------------------------------------------------------
[    0.451350]                      A-A deadlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.454281]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.457443]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.460744]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.464032]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.467545]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.471009]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.474475]                     double unlock:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.477425]                   initialize held:  ok  |  ok  |  ok  |  ok =
 |=20
ok  |  ok  |  ok  |
[    0.480301]=20=20
--------------------------------------------------------------------------
[    0.480352]               recursive read-lock:             |  ok  |=20=
=20=20=20=20=20=20=20=20
   |  ok  |
[    0.481247]            recursive read-lock #2:             |  ok  |=20=
=20=20=20=20=20=20=20=20
   |  ok  |
[    0.482120]             mixed read-write-lock:             |  ok  |=20=
=20=20=20=20=20=20=20=20
   |  ok  |
[    0.482998]             mixed write-read-lock:             |  ok  |=20=
=20=20=20=20=20=20=20=20
   |  ok  |
[    0.483878]   mixed read-lock/lock-write ABBA:             |FAILED|=20=
=20=20=20=20=20=20=20=20
   |  ok  |
[    0.484755]    mixed read-lock/lock-read ABBA:             |  ok  |=20=
=20=20=20=20=20=20=20=20
   |  ok  |
[    0.485676]  mixed write-lock/lock-write ABBA:             |  ok  |=20=
=20=20=20=20=20=20=20=20
   |  ok  |
[    0.486597]=20=20
--------------------------------------------------------------------------
`

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

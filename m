Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D9AC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 12:29:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95FCD2192A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 12:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95FCD2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wqbH2M8HzDqs8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 22:28:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=qm5j=5w=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wqXW2BFdzDqq5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 22:26:35 +1000 (AEST)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 207129] PowerMac G4 DP (5.6.2 debug kernel + inline KASAN)
 freezes shortly after booting with "do_IRQ: stack overflow: 1760"
Date: Mon, 06 Apr 2020 12:26:32 +0000
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
Message-ID: <bug-207129-206035-ig4xycPsD1@https.bugzilla.kernel.org/>
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D207129

--- Comment #2 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 288229
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D288229&action=3Dedit
screenshot01.jpg

Without CONFIG_DEBUG_STACKOVERFLOW things are better. The rsync completes, =
the
G4 was building stuff for 2 hours or so until I got these errors and a hard
freeze:

[...]
Oops: kernel stack overflow, sig: 11 [#1]
BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 PowerMac
Modules linked in: ...
CPU: 1 PID: 17105 Comm: kworker/u4:5 Tainted: G        W=20=20=20=20=20=20=
=20
5.6.2-PowerMacG4+ #5
------------[ cut here  ]------------
kernel BUG at mm/usercopy.c:99!
Oops: Exception in kernel mode, sig: 5 [#2]
BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 PowerMac
Modules linked in: ...
CPU: 1 PID: 17185 Comm: kworker/u4:5 Tainted: G        W=20=20=20=20=20=20=
=20
5.6.2-PowerMacG4+ #5
usercopy: Kernel memory overwrite attempt detected to kernel text (offset 6=
336,
size 4)!
------------[ cut here  ]------------
kernel BUG at mm/usercopy.c:99!
Oops: Exception in kernel mode, sig: 5 [#3]
BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 PowerMac
Modules linked in: ...
CPU: 1 PID: 17185 Comm: kworker/u4:5 Tainted: G        W=20=20=20=20=20=20=
=20
5.6.2-PowerMacG4+ #5
usercopy: Kernel memory overwrite attempt detected to kernel text (offset 5=
336,
size 4)!
------------[ cut here  ]------------
kernel BUG at mm/usercopy.c:99!
Oops: Exception in kernel mode, sig: 5 [#4]
BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 PowerMac
Modules linked in: ...
CPU: 1 PID: 17185 Comm: kworker/u4:5 Tainted: G        W=20=20=20=20=20=20=
=20
5.6.2-PowerMacG4+ #5
usercopy: Kernel memory overwrite attempt detected to kernel text (offset 4=
336,
size 4)!
------------[ cut here  ]------------
kernel BUG at mm/usercopy.c:99!
Oops: Exception in kernel mode, sig: 5 [#5]
BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 PowerMac
Modules linked in: ...
Unrecoverable FP Unavailable Exception 801 at 9b8
CPU: 1 PID: 17185 Comm: kworker/u4:5 Tainted: G        W=20=20=20=20=20=20=
=20
5.6.2-PowerMacG4+ #5
usercopy: Kernel memory overwrite attempt detected to kernel text (offset 3=
336,
size 4)!
------------[ cut here  ]------------

Now running with CONFIG_THREAD_SHIFT=3D14 which runs fine so far... Did not=
 try
without CONFIG_VMAP_STACK yet.

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A5FC432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 04:30:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA51520726
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 04:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA51520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Gbbv2kXjzDqXK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 15:30:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=35t7=zk=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47GbYv0rLfzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 15:28:50 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 205183] PPC64: Signal delivery fails with SIGSEGV if between
 about 1KB and 4KB bytes of stack remain
Date: Mon, 18 Nov 2019 04:28:47 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: daniel@linux.ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-205183-206035-Bms0y4w61H@https.bugzilla.kernel.org/>
In-Reply-To: <bug-205183-206035@https.bugzilla.kernel.org/>
References: <bug-205183-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205183

Daniel Black (daniel@linux.ibm.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |daniel@linux.ibm.com

--- Comment #1 from Daniel Black (daniel@linux.ibm.com) ---
Tom,

Thanks for the bug report. Appreciate it. Feel free to use the
linuxppc-dev@lists.ozlabs.org list.


Reproduced in 5.4.0-rc8

danielgb@talos2:~$ uname -a
Linux talos2 5.4.0-rc8 #5 SMP Mon Nov 18 13:27:11 AEDT 2019 ppc64le ppc64le
ppc64le GNU/Linux
danielgb@talos2:~$ gcc -g -Wall -O stacktest.c
danielgb@talos2:~$ ./a.out 1240000 &
[1] 2944
danielgb@talos2:~$  cat /proc/$(pidof a.out)/maps | grep stack
7fffc62f0000-7fffc6420000 rw-p 00000000 00:00 0=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
[stack]
danielgb@talos2:~$ kill -USR1 %1
danielgb@talos2:~$ signal delivered, stack base 0x7fffc6420000 top
0x7fffc62f1427 (1240025 used)

[1]+  Done                    ./a.out 1240000
danielgb@talos2:~$  ./a.out 1241000 &
[1] 2948
danielgb@talos2:~$ kill -USR1 %1
danielgb@talos2:~$=20
[1]+  Segmentation fault      ./a.out 1241000


[ 6415.077590] a.out[2948]: bad frame in setup_rt_frame: 00007fffe4fb0010 n=
ip
000006a185d909fc lr 000077ecda3c04e8


I'll get someone to look at this soon.

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

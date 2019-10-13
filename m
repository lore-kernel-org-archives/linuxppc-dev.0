Return-Path: <SRS0=uEoI=YG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205FCC4360C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Oct 2019 15:57:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67629206B7
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Oct 2019 15:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67629206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46rmYY14fPzDqnM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Oct 2019 02:57:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=/new=yg=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46rmWV3ZngzDqkd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Oct 2019 02:56:06 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 205183] New: PPC64: Signal delivery fails with SIGSEGV if
 between about 1KB and 4KB bytes of stack remain
Date: Sun, 13 Oct 2019 15:56:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tgl@sss.pgh.pa.us
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-205183-206035@https.bugzilla.kernel.org/>
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

            Bug ID: 205183
           Summary: PPC64: Signal delivery fails with SIGSEGV if between
                    about 1KB and 4KB bytes of stack remain
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 4.19.15 and others
          Hardware: PPC-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PPC-64
          Assignee: platform_ppc-64@kernel-bugs.osdl.org
          Reporter: tgl@sss.pgh.pa.us
        Regression: No

Created attachment 285487
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D285487&action=3Dedit
stacktest.c

If there are between about 1K and 4K bytes remaining in a process' existing
stack segment, an attempt to deliver a signal that the process has a signal
handler for will result in SIGSEGV instead.  This situation should result in
extending the process' stack to allow handling the signal, but it does not.

The attached test program illustrates this.  It requires a parameter specif=
ying
the amount of stack to consume before sleeping.  Waken the process with a
manual kill -USR1.  An example of a successful case is

[tgl@postgresql-fedora ~]$ gcc -g -Wall -O stacktest.c
[tgl@postgresql-fedora ~]$ ./a.out 1240000 &
[1] 7922
[tgl@postgresql-fedora ~]$ cat /proc/7922/maps | grep stack
7fffc9970000-7fffc9aa0000 rw-p 00000000 00:00 0=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
[stack]
[tgl@postgresql-fedora ~]$ kill -USR1 7922
[tgl@postgresql-fedora ~]$ signal delivered, stack base 0x7fffc9aa0000 top
0x7fffc9971420 (1240032 used)

[1]+  Done                    ./a.out 1240000

The above example shows that 0x7fffc9971420 - 0x7fffc9970000 =3D 5152 bytes
are enough to deliver the signal.  But with a slightly larger parameter,

[tgl@postgresql-fedora ~]$ ./a.out 1241000 &
[1] 7941
[tgl@postgresql-fedora ~]$ kill -USR1 7941
[tgl@postgresql-fedora ~]$=20
[1]+  Segmentation fault      (core dumped) ./a.out 1241000

With a still larger parameter, corresponding to just a few hundred bytes le=
ft,
it works again, showing that the kernel does know how to enlarge the stack =
in
such cases --- it's just got a boundary condition wrong somewhere.

On the particular userland toolchain I'm using here, parameters between abo=
ut
1241000 and 1244000 (free space between about 1200 and 4200 bytes) will show
the error, but you might need to tweak it a bit with a different system.

The Postgres project has been chasing errors caused by this bug for months,=
 and
we've seen it happen on a range of PPC64 kernels from 4.4.0 up to 4.19.15, =
but
not on other architectures, nor on non-Linux PPC64.  My colleague Thomas Mu=
nro
found a possible explanation in

https://github.com/torvalds/linux/blob/master/arch/powerpc/mm/fault.c#L251

which claims that

         * The kernel signal delivery code writes up to about 1.5kB
         * below the stack pointer (r1) before decrementing it.

and that seems to be the justification for the "2048" magic number at line =
276.
Perhaps that number applies only to PPC32, and PPC64 requires more space?  =
At
the very least, this function's other magic number of 0x100000 seems highly
suspicious in view of the fact that we don't see the bug until the process =
has
consumed at least 1MB of stack space.  (Hence, please use values > 1MB with=
 the
test program.)

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

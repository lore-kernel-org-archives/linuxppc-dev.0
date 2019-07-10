Return-Path: <SRS0=3PCM=VH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD02CC74A24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 13:35:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAC020861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 13:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAC020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45kKtl74tJzDqFH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jul 2019 23:35:11 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45kKdy0GQbzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 23:24:05 +1000 (AEST)
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 09CB226861
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2019 13:24:02 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
 id EE2072871F; Wed, 10 Jul 2019 13:24:01 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 204125] New: FTBFS on ppc64 big endian and gcc9 because of
 -mcall-aixdesc and missing __linux__
Date: Wed, 10 Jul 2019 13:24:01 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: linux@octaforge.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204125-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D204125

            Bug ID: 204125
           Summary: FTBFS on ppc64 big endian and gcc9 because of
                    -mcall-aixdesc and missing __linux__
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: any
          Hardware: PPC-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: PPC-64
          Assignee: platform_ppc-64@kernel-bugs.osdl.org
          Reporter: linux@octaforge.org
        Regression: No

On ppc64 big endian, the kernel builds with `-mcall-aixdesc` which since gcc
9.x removes `__linux__` from the list of macros being defined. This behavio=
r is
supposed to be more correct (as it's in this case nothing but a hack, the f=
lag
should apparently only be used when building for AIX) but sadly it breaks b=
uild
since several things within the tree rely on `__linux__` being defined and
`#ifdef` some of their code based on said macro.

Just removing `-mcall-aixdesc` (and using just `-mabi=3Delfv1`) is however =
not
enough, as that instead causes countless undefined references to just about
every symbol when linking `vmlinux`. It would seem that `-mcall-aixdesc`
changes the way symbols are declared in a way that is not expected.

Little endian is not affected because that one uses `-mabi=3Delfv2` exclusi=
vely.

For now I worked around it in my distro by explicitly adding `-D__linux__` =
in
the kbuild where `-mcall-aixdesc` is inserted into flags, and it works, but
that's obviously just a workaround.

I'm not sure what the proper fix would be.

Also, is there any reason not to allow an ELFv2 kernel to be built on big
endian? There are some supposed performance benefits, and ELFv2 itself supp=
orts
either endianness. The current kbuild logic pretty much forces ELFv1 for big
endian and ELFv2 for little endian.

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

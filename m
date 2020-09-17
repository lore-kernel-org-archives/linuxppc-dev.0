Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A29C433E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:29:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE3C21974
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 12:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE3C21974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bsbr34rpnzDqHJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 22:29:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=zdtj=c2=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsZTW60lFzDqXV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 21:28:15 +1000 (AEST)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 209297] New: powerpc: MPC10X_BRIDGE violates Kconfig dependency
 of PPC_INDIRECT_PCI on PCI
Date: Thu, 17 Sep 2020 11:28:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fazilyildiran@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cc cf_regression
Message-ID: <bug-209297-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D209297

            Bug ID: 209297
           Summary: powerpc: MPC10X_BRIDGE violates Kconfig dependency of
                    PPC_INDIRECT_PCI on PCI
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 5.9-rc4
          Hardware: PPC-32
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PPC-32
          Assignee: platform_ppc-32@kernel-bugs.osdl.org
          Reporter: fazilyildiran@gmail.com
                CC: mpe@ellerman.id.au, paulus@samba.org
        Regression: No

The commit 25635c71e441 ("ppc: Use the indirect_pci.c from
arch/powerpc/sysdev")
introduced PPC_INDIRECT_PCI as a non-visible config that depends on PCI.=20

Since it is non-visible, the dependency on PCI has no implications other
than leading to Kbuild build warnings if !PCI. For example, disabling PCI
and enabling LINKSTATION leads to the following Kbuild warning since
PPC_INDIRECT_PCI is selected by MPC10X_BRIDGE, which is selected by
LINKSTATION:

WARNING: unmet direct dependencies detected for PPC_INDIRECT_PCI
  Depends on [n]: PCI [=3Dn]
  Selected by [y]:
  - MPC10X_BRIDGE [=3Dy]

There are many other configs that select PPC_INDIRECT_PCI but they seem
to enable PCI one way or another, e.g., enabling FORCE_PCI or selecting
PPC_INDIRECT_PCI if PCI. Among them, only MPC10X_BRIDGE and MV64X60 seem
to not account for the dependency on PCI, and MV64X60 seem to be obsolete:
https://bugzilla.kernel.org/show_bug.cgi?id=3D209277

I am not sure about the internals of the user subsystem. However, two fix
options I see are: 1) --select FORCE_PCI-- by MPC10X_BRIDGE, 2) select
PPC_INDIRECT_PCI --if PCI-- by MPC10X_BRIDGE.

Thanks,
Necip

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

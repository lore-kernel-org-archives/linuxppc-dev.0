Return-Path: <SRS0=7pZz=2H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA002C43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 15:39:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8995C24655
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 15:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8995C24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47cj4j38n4zDqbD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 02:39:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=uhai=2h=bugzilla.kernel.org=bugzilla-daemon@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=bugzilla.kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47cj2C1GWKzDqX3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 02:37:39 +1100 (AEDT)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 205889] New: CONFIG_PPC_85xx with CONFIG_CORENET_GENERIC
 outputs uImage instead of zImage
Date: Tue, 17 Dec 2019 15:37:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-32
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bradley.gamble@ncipher.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-32@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205889-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D205889

            Bug ID: 205889
           Summary: CONFIG_PPC_85xx with CONFIG_CORENET_GENERIC outputs
                    uImage instead of zImage
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 5.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PPC-32
          Assignee: platform_ppc-32@kernel-bugs.osdl.org
          Reporter: bradley.gamble@ncipher.com
        Regression: No

Attempting a PowerPC Linux kernel build with the config options
"CONFIG_PPC_85xx=3Dy" and "CONFIG_CORENET_GENERIC=3Dy" will output a file n=
amed
"zImage", however this file is actually a "uImage" formatted file.

This can be replicated with this minimal defconfig:
    CONFIG_PPC_85xx=3Dy
    CONFIG_CORENET_GENERIC=3Dy

If I perform a build with one of these options I am given a valid zImage fi=
le:
    $ file arch/powerpc/boot/zImage
    arch/powerpc/boot/zImage: ELF 32-bit MSB executable, PowerPC or cisco 4=
500,
version 1 (SYSV), statically linked, not stripped

However performing the same build with both config options enabled gives an
incorrectly formatted image:
    $ file arch/powerpc/boot/zImage
    arch/powerpc/boot/zImage: u-boot legacy uImage, Linux-5.5.0-rc2-gea200d=
ec5,
Linux/PowerPC, OS Kernel Image (gzip), 1366142 bytes, Tue Dec 17 15:30:22 2=
019,
Load Address: 0x00000000, Entry Point: 0x00000000, Header CRC: 0x99D350A0, =
Data
CRC: 0xC9090D33

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

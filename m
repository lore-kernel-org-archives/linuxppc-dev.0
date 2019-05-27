Return-Path: <SRS0=ZMG4=T3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986FBC04AB3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 14:43:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F322070D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 14:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F322070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CKVC2HtrzDqLG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 00:43:47 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CKSn30jSzDqDt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 00:42:33 +1000 (AEST)
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E8F4826246
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2019 14:42:30 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
 id DD45D27E63; Mon, 27 May 2019 14:42:30 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Subject: [Bug 203725] New: Build error: 'init_module' specifies less
 restrictive attribute than its target 'rtas_flash_init': 'cold'
Date: Mon, 27 May 2019 14:42:30 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Product: Platform Specific/Hardware
X-Bugzilla-Component: PPC-64
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jason@bluehome.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: platform_ppc-64@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-203725-206035@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D203725

            Bug ID: 203725
           Summary: Build error: 'init_module' specifies less restrictive
                    attribute than its target 'rtas_flash_init': 'cold'
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 4.19.46
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PPC-64
          Assignee: platform_ppc-64@kernel-bugs.osdl.org
          Reporter: jason@bluehome.net
        Regression: No

Created attachment 282969
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D282969&action=3Dedit
Build log

I recently upgraded to GCC 9.1. This error appears while building 4.19.46. =
I'm
building with ppc64el. GCC 8.3 doesn't doesn't generate an error so that's =
my
workaround for now.

  powerpc64le-linux-gcc -Wp,-MD,arch/powerpc/kernel/.rtas_flash.o.d  -nostd=
inc
-isystem /home/jason/toolchain/bin/../lib/gcc/powerpc64le-linux/9.1.0/inclu=
de
-I./arch/powerpc/include -I./arch/powerpc/include/generated  -I./include
-I./arch/powerpc/include/uapi -I./arch/powerpc/include/generated/uapi
-I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfi=
g.h
-include ./include/linux/compiler_types.h -D__KERNEL__ -Iarch/powerpc
-DHAVE_AS_ATHIGH=3D1 -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs
-fno-strict-aliasing -fno-common -fshort-wchar
-Werror-implicit-function-declaration -Wno-format-security -std=3Dgnu89 -fn=
o-PIE
-DCC_HAVE_ASM_GOTO -mlittle-endian -m64 -msoft-float -pipe -Iarch/powerpc
-mtraceback=3Dno -mabi=3Delfv2 -mcmodel=3Dmedium -mno-pointers-to-nested-fu=
nctions
-mcpu=3Dpower8 -mtune=3Dpower9 -mno-altivec -mno-vsx -funit-at-a-time
-fno-dwarf2-cfi-asm -mno-string -Wa,-maltivec -Wa,-mpower4 -Wa,-many
-mno-strict-align -mlittle-endian -fno-delete-null-pointer-checks
-Wno-frame-address -Wno-format-truncation -Wno-format-overflow
-Wno-int-in-bool-context -O2 --param=3Dallow-store-data-races=3D0
-Wframe-larger-than=3D2048 -fno-stack-protector -Wno-unused-but-set-variable
-Wno-unused-const-variable -fno-var-tracking-assignments -pg -mprofile-kern=
el
-Wdeclaration-after-statement -Wno-pointer-sign -Wno-stringop-truncation
-fno-strict-overflow -fno-merge-all-constants -fmerge-constants
-fno-stack-check -fconserve-stack -Werror=3Dimplicit-int
-Werror=3Dstrict-prototypes -Werror=3Ddate-time -Werror=3Dincompatible-poin=
ter-types
-Werror=3Ddesignated-init -fmacro-prefix-map=3D./=3D -Wno-packed-not-aligne=
d -Werror=20
-DMODULE -mno-save-toc-indirect -mcmodel=3Dlarge=20
-DKBUILD_BASENAME=3D'"rtas_flash"' -DKBUILD_MODNAME=3D'"rtas_flash"' -c -o
arch/powerpc/kernel/rtas_flash.o arch/powerpc/kernel/rtas_flash.c
In file included from arch/powerpc/kernel/rtas_flash.c:16:
./include/linux/module.h:133:6: error: 'init_module' specifies less restric=
tive
attribute than its target 'rtas_flash_init': 'cold'
[-Werror=3Dmissing-attributes]
  133 |  int init_module(void) __attribute__((alias(#initfn)));
      |      ^~~~~~~~~~~
arch/powerpc/kernel/rtas_flash.c:779:1: note: in expansion of macro
'module_init'
  779 | module_init(rtas_flash_init);
      | ^~~~~~~~~~~
arch/powerpc/kernel/rtas_flash.c:703:19: note: 'init_module' target declared
here
  703 | static int __init rtas_flash_init(void)
      |                   ^~~~~~~~~~~~~~~
In file included from arch/powerpc/kernel/rtas_flash.c:16:
./include/linux/module.h:139:7: error: 'cleanup_module' specifies less
restrictive attribute than its target 'rtas_flash_cleanup': 'cold'
[-Werror=3Dmissing-attributes]
  139 |  void cleanup_module(void) __attribute__((alias(#exitfn)));
      |       ^~~~~~~~~~~~~~
arch/powerpc/kernel/rtas_flash.c:780:1: note: in expansion of macro
'module_exit'
  780 | module_exit(rtas_flash_cleanup);
      | ^~~~~~~~~~~
arch/powerpc/kernel/rtas_flash.c:759:20: note: 'cleanup_module' target decl=
ared
here
  759 | static void __exit rtas_flash_cleanup(void)
      |                    ^~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
scripts/Makefile.build:309: recipe for target
'arch/powerpc/kernel/rtas_flash.o' failed
make[1]: *** [arch/powerpc/kernel/rtas_flash.o] Error 1
Makefile:1051: recipe for target 'arch/powerpc/kernel' failed
make: *** [arch/powerpc/kernel] Error 2

--=20
You are receiving this mail because:
You are watching the assignee of the bug.=

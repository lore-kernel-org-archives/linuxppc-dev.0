Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AAC912C00EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:23:07 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 18:18:04 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D2EC32CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:23:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O89PEo6554036
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:09:25 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O8MxiF002638
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:23:00 +1000
Message-ID: <5177965D.9090406@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 16:22:53 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, gang.chen@asianux.com
Subject: "attempt to move .org backwards" still show up
Content-Type: text/plain; charset=GB2312
Cc: sfr@canb.auug.org.au, mikey@neuling.org, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all

I get an error message when I compile the source code in Power7 platform
use the newest upstream kernel.

[root@feng linux]# make -j60
CHK include/generated/uapi/linux/version.h
CHK include/generated/utsrelease.h
CC scripts/mod/devicetable-offsets.s
GEN scripts/mod/devicetable-offsets.h
HOSTCC scripts/mod/file2alias.o
CALL scripts/checksyscalls.sh
HOSTLD scripts/mod/modpost
CHK include/generated/compile.h
CALL arch/powerpc/kernel/systbl_chk.sh
CALL arch/powerpc/kernel/prom_init_check.sh
AS arch/powerpc/kernel/head_64.o
arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:258: Error: attempt to move .org
backwards
make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
make: *** [arch/powerpc/kernel] Error 2
make: *** Waiting for unfinished jobs....

and I see this should be fixed by the commit:
087aa036eb79f24b856893190359ba812b460f45

But it still failed in my P7 machine.

the kernel source code info:
git tree : git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[root@feng linux]# git log
commit 824282ca7d250bd7c301f221c3cd902ce906d731
Merge: f83b293 3b5e50e
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon Apr 22 15:00:59 2013 -0700

Merge branch 'upstream' of
git://git.linux-mips.org/pub/scm/ralf/upstream-linus

Pull MIPS fix from Ralf Baechle:
"Revert the change of the definition of PAGE_MASK which was prettier
but broke a few relativly rare platforms"

* 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus:
Revert "MIPS: page.h: Provide more readable definition for PAGE_MASK."

commit 3b5e50edaf500f392f4a372296afc0b99ffa7e70
Author: Ralf Baechle <ralf@linux-mips.org>
Date: Mon Apr 22 17:57:54 2013 +0200

[root@feng linux]# git branch
* master
[root@feng linux]# git diff
[root@feng linux]#

Thant means I have done nothing with the kernel

Thanks
Mike

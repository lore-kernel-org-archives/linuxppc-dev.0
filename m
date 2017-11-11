Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYr8g1vN0zDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 19:45:54 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id s2so9132609pge.10
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 00:45:54 -0800 (PST)
Date: Sat, 11 Nov 2017 19:45:40 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, Masahiro Yamada
 <yamada.masahiro@socionext.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro'
 from `arch/powerpc/kernel/head_44x.o' being placed in section
 `.data.rel.ro'.
Message-ID: <20171111194540.5f96fe93@roar.ozlabs.ibm.com>
In-Reply-To: <201711102336.rokM2O1G%fengguang.wu@intel.com>
References: <201711102336.rokM2O1G%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Nov 2017 23:41:49 +0800
kbuild test robot <fengguang.wu@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1c9dbd4615fd751e5e0b99807a3c7c8612e28e20
> commit: cb87481ee89dbd6609e227afbf64900fb4e5c930 kbuild: linker script do not match C names unless LD_DEAD_CODE_DATA_ELIMINATION is configured
> date:   3 months ago
> config: powerpc-fsp2_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout cb87481ee89dbd6609e227afbf64900fb4e5c930
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All warnings (new ones prefixed by >>):
> 
> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.
> >> powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.  

Okay this is not caused by the above patch, it was just hiding it.
This should do the trick I think:
--
powerpc/32: Add .data.rel* sections explicitly

Match powerpc/64 and include .data.rel* input sections in the .data output
section explicitly.

This should solve the warning:

powerpc-linux-gnu-ld: warning: orphan section `.data.rel.ro' from `arch/powerpc/kernel/head_44x.o' being placed in section `.data.rel.ro'.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 0494e1566ee2..51e4ec92ade1 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -264,6 +264,7 @@ SECTIONS
 #ifdef CONFIG_PPC32
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+		*(.data.rel*)
 		*(.sdata)
 		*(.sdata2)
 		*(.got.plt) *(.got)
-- 
2.15.0

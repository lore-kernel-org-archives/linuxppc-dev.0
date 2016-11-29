Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSW6z4dK9zDt1Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:39:55 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id c4so7523287pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 20:39:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] Try orphan section warning again
Date: Tue, 29 Nov 2016 15:39:38 +1100
Message-Id: <20161129043942.13848-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The orphan section warning patch had a minor issue with unhandled
.text.save.restore last time I sent it. I went back and tidied up
crtsavres a bit, so after these, I think we can enable orphan section
warnings.

There is a further step we can take which is to enable
--save-restore-funcs for module link, which means 64-bit does not
need crtsavres at all. That option is only in binutils 2.25 though,
so I'll send that later.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc/64: place sfpr section explicitly with the linker script
  powerpc/64: do not link crtsavres routines into vmlinux
  powerpc/64: do not create new section for save/restore functions
  powerpc: link warning for orphan sections

 arch/powerpc/Makefile             |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 24 ++++++++++++++++++++++--
 arch/powerpc/lib/Makefile         |  8 ++++++--
 arch/powerpc/lib/crtsavres.S      |  6 ++----
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 5 files changed, 42 insertions(+), 8 deletions(-)

-- 
2.10.2

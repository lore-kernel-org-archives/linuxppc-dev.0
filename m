Return-Path: <bhsharma@redhat.com>
Received: from mail-qt0-f176.google.com (mail-qt0-f176.google.com
 [209.85.216.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDTT31RYmzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 16:44:07 +1100 (AEDT)
Received: by mail-qt0-f176.google.com with SMTP id v23so11581036qtb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 21:44:07 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
To: linuxppc-dev@lists.ozlabs.org,
	kernel-hardening@lists.openwall.com
Cc: dcashman@google.com, mpe@ellerman.id.au, bhupesh.linux@gmail.com,
 keescook@chromium.org, Bhupesh Sharma <bhsharma@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anatolij Gustschin <agust@denx.de>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Vitaly Bordug <vitb@kernel.crashing.org>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Daniel Cashman <dcashman@android.com>
Subject: [PATCH 2/2] powerpc: Redefine ELF_ET_DYN_BASE
Date: Thu,  2 Feb 2017 11:12:48 +0530
Message-Id: <1486014168-1279-3-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1486014168-1279-1-git-send-email-bhsharma@redhat.com>
References: <1486014168-1279-1-git-send-email-bhsharma@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the powerpc arch uses a ELF_ET_DYN_BASE value of 0x20000000
which ends up pushing an elf to a load address which is 32-bit.

On 64-bit platforms, this might be too less especially when one is
trying to increase the randomness of the load address of the ASLR elfs
on such platforms.

This patch makes the powerpc platforms mimic the x86 ones, by ensuring
that the ELF_ET_DYN_BASE is calculated on basis of the current task's
TASK_SIZE.

Cc: Alexander Graf <agraf@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Alistair Popple <alistair@popple.id.au>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Scott Wood <oss@buserror.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Daniel Cashman <dcashman@android.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/powerpc/include/asm/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index ee46ffef608e..dd035f6dd782 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -28,7 +28,7 @@
    the loader.  We need to make sure that it is out of the way of the program
    that it will "exec", and that there is sufficient room for the brk.  */
 
-#define ELF_ET_DYN_BASE	0x20000000
+#define ELF_ET_DYN_BASE	(TASK_SIZE - PAGE_SIZE)
 
 #define ELF_CORE_EFLAGS (is_elf2_task() ? 2 : 0)
 
-- 
2.7.4

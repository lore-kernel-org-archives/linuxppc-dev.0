Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECA1C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:55:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1764C2081B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 20:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gA9OqMQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1764C2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4399xC5hgpzDqp7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 07:55:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="gA9OqMQe";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.75; helo=conuserg-08.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="gA9OqMQe"; 
 dkim-atps=neutral
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438xTK0JqpzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 22:34:12 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id wB5BSBlX028064;
 Wed, 5 Dec 2018 20:28:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wB5BSBlX028064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544009297;
 bh=xrb0PNo5pw/YPjt31K6EqFjYwJsZcMHyXIulbXaDXq8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gA9OqMQeKbZz4K3aUZbxGPRafiVZ7f+fi9LF6c0zMWmQUWZ0+9LC/t4HkagPLAddC
 Kp6zfCNRAhf6KwSvvJecBgIGya47w6yxGE+yYWyGghD8/v+X+rymb8HBLWmM0eDLD2
 6FnDuVbsB7sqVuNJsL9KZHX6zg3d4gIZgUeqUP97ElFxELr8GEDyfy056JlCyHCbG2
 NRGFxob3tzmOB9Epk71KfdQk0GuXKCUwLWlc6LTWlVXO70TC2xllCpmQ0gcvzbqMie
 87fh9te2CSWgtxpsgCqtinq882SjKF/63O6CZqxQkkj6UrlFUly7PDVy0Of+PeWgP6
 Wr0R51bhN1tXw==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Subject: [PATCH 3/3] arch: remove redundant generic-y defines
Date: Wed,  5 Dec 2018 20:28:06 +0900
Message-Id: <1544009286-15705-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailman-Approved-At: Thu, 06 Dec 2018 07:53:19 +1100
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Palmer Dabbelt <palmer@sifive.com>, Will Deacon <will.deacon@arm.com>,
 Alexei Starovoitov <ast@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 Vincent Chen <deanbo422@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org,
 Daniel Borkmann <daniel@iogearbox.net>, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, linux-alpha@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 Fenghua Yu <fenghua.yu@intel.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Arnd Bergmann <arnd@arndb.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-xtensa@linux-xtensa.org,
 Mark Salter <msalter@redhat.com>,
 Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
 linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org,
 Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>,
 nios2-dev@lists.rocketboards.org, Thomas Gleixner <tglx@linutronix.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-mips@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-parisc@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Ley Foon Tan <lftan@altera.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that Kbuild automatically creates asm-generic wrappers for missing
mandatory headers, it is redundant to list the same headers in
generic-y and mandatory-y.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/alpha/include/uapi/asm/Kbuild      |  5 -----
 arch/arc/include/uapi/asm/Kbuild        | 23 -----------------------
 arch/arm/include/uapi/asm/Kbuild        | 15 ---------------
 arch/arm64/include/uapi/asm/Kbuild      | 17 -----------------
 arch/c6x/include/uapi/asm/Kbuild        | 25 -------------------------
 arch/h8300/include/uapi/asm/Kbuild      | 25 -------------------------
 arch/hexagon/include/uapi/asm/Kbuild    | 22 ----------------------
 arch/ia64/include/uapi/asm/Kbuild       |  5 -----
 arch/m68k/include/uapi/asm/Kbuild       | 18 ------------------
 arch/microblaze/include/uapi/asm/Kbuild | 24 ------------------------
 arch/mips/include/uapi/asm/Kbuild       |  1 -
 arch/nds32/include/uapi/asm/Kbuild      | 24 ------------------------
 arch/nios2/include/uapi/asm/Kbuild      | 24 ------------------------
 arch/openrisc/include/uapi/asm/Kbuild   | 26 --------------------------
 arch/parisc/include/uapi/asm/Kbuild     |  5 -----
 arch/powerpc/include/uapi/asm/Kbuild    |  6 ------
 arch/riscv/include/uapi/asm/Kbuild      | 25 -------------------------
 arch/s390/include/uapi/asm/Kbuild       | 14 --------------
 arch/sh/include/uapi/asm/Kbuild         | 17 -----------------
 arch/sparc/include/uapi/asm/Kbuild      |  1 -
 arch/unicore32/include/uapi/asm/Kbuild  | 27 ---------------------------
 arch/x86/include/uapi/asm/Kbuild        |  1 -
 arch/xtensa/include/uapi/asm/Kbuild     |  8 --------
 23 files changed, 358 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 1a5b753..14a2e9a 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -2,8 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 170b5db..f53f8e4 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,29 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 4d1cc18..279edb1 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -6,19 +6,4 @@ generated-y += unistd-common.h
 generated-y += unistd-oabi.h
 generated-y += unistd-eabi.h
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += termbits.h
-generic-y += termios.h
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 6c5adf4..bca548a 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -2,21 +2,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
-generic-y += siginfo.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 26644e1..f53f8e4 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,31 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 2f65f78..f53f8e4 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,31 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index 41a176d..c0488dc 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,27 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 3982e67..f5c6967 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -2,9 +2,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index c2e26a4..f5c6967 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,23 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 2c6a6bf..f53f8e4 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,30 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index 7a4becd..14a2e9a 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += ipcbuf.h
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
index 40be972..c0488dc 100644
--- a/arch/nds32/include/uapi/asm/Kbuild
+++ b/arch/nds32/include/uapi/asm/Kbuild
@@ -2,28 +2,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += shmbuf.h
-generic-y += bitsperlong.h
-generic-y += fcntl.h
-generic-y += stat.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 13a3d77..f53f8e4 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,30 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 130c16c..f53f8e4 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,32 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index adb5c64..f5c6967 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,10 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
 generic-y += bpf_perf_event.h
 generic-y += kvm_para.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += siginfo.h
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index a658091..14a2e9a 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -2,9 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += siginfo.h
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index 5511b99..14a2e9a 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -1,29 +1,4 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += setup.h
-generic-y += unistd.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
-generic-y += siginfo.h
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index dc38a90..3e1b12d 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -5,17 +5,3 @@ include include/uapi/asm-generic/Kbuild.asm
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += sockios.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += siginfo.h
\ No newline at end of file
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index ba4d39c..f53f8e4 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,23 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
-generic-y += socket.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += ucontext.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index 4680ba2..14a2e9a 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
-generic-y += types.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 8611ef9..f53f8e4 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,33 +1,6 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += auxvec.h
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += kvm_para.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
-generic-y += poll.h
-generic-y += posix_types.h
-generic-y += resource.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
-generic-y += types.h
 generic-y += ucontext.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 3226816..1e901e4 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -5,4 +5,3 @@ generic-y += bpf_perf_event.h
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
-generic-y += poll.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 837d4dd..f5c6967 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,13 +1,5 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += bitsperlong.h
 generic-y += bpf_perf_event.h
-generic-y += errno.h
-generic-y += fcntl.h
-generic-y += ioctl.h
 generic-y += kvm_para.h
-generic-y += resource.h
-generic-y += siginfo.h
-generic-y += statfs.h
-generic-y += termios.h
-- 
2.7.4


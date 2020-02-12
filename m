Return-Path: <SRS0=Z2Z0=4A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8AEC2BA83
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 10:55:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58DC120675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 10:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="cfEHKyCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DC120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Hc4P24HPzDqNw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 21:55:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=monstr.eu
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=monstr@monstr.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=monstr-eu.20150623.gappssmtp.com
 header.i=@monstr-eu.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=cfEHKyCz; dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Hc2G3mGWzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 21:53:37 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id z7so1622912wrl.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 02:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iCxaKYylUaTagw0CiACoN5PmGBZhgyb9phU3hhP0tOU=;
 b=cfEHKyCzPVV+G0Ct3fk+e76eZPGNTeImhNiFGDVimPzL4uYn8zjyFG9WyB0koRR2qN
 EwMnN8vjUGQ2wbhjgaIjph2vjfhe8yjFmu9ClTKqCx2OtRi5VsZHinaDNjSlIBmgdAxy
 wxZcB8m80XRXcoyEYhnoHyLx5c4HUKj1j5ketT2WaaEFRPaldEWGCoEuAfq2/3tjkHap
 8wX1V3Fo/iwSy3etqyDyJk14F8tfP9OcXDnIFVgeOxj2H0AcSvMFus1GiH7Bo5SBr38M
 +OGCJMD8zbYUhdsAjqZ8LRFVbVVV0cBL4zfH47rlbg/l3/sDFnDyyciz4KUYMzOvm7Ic
 iHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=iCxaKYylUaTagw0CiACoN5PmGBZhgyb9phU3hhP0tOU=;
 b=c2imzlBDJNE4KTTIAaNuIFnl6220VCA1BK26CXMkv9gVpoFs8L7If5eW2Cw/uxnt+X
 rB/qYj3OHZEa40+9PYK1X5r/acYqEGx4HZ0JpBpS0Kths+SmbsI3jRVWePoOa54+X/na
 bsTpQa0CBLf6MxCTGxzW/MQqYxcQa+nIRIKaW1DRAjpZ9f6ivLb/pLF2+LfQ20TUKrOW
 Kefvt2DhKpbu4Wfg8FW9Kw2rLx3/rBrQHcbvrriTJbwEgsqK90i3iXmaejTSgw1QT2y9
 pax5ha9BDwCuwt2Ok7H2JAeKaZmcicSzBJVdXPRIYTx84Z1WDYs09SljQM/S9X7OV/fB
 r3WA==
X-Gm-Message-State: APjAAAWPXLN599LvjetEN66Xb37qfwA942iUeDhApsr+JLf8Tlaki5rc
 EBBFulOQu2UMxt/9UNN/XDaTHA==
X-Google-Smtp-Source: APXvYqxgTVJqQTyquzXfMccEeyNdAmwRbsVgVjP0iCL7Yk3Bd8yKTybDkb7CTMq7CHnJcPN3jls9ZA==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr15503626wrc.175.1581504812588; 
 Wed, 12 Feb 2020 02:53:32 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
 by smtp.gmail.com with ESMTPSA id b10sm123284wrw.61.2020.02.12.02.53.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Feb 2020 02:53:30 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, arnd@arndb.de, akpm@linux-foundation.org
Subject: [PATCH v3] asm-generic: Fix unistd_32.h generation format
Date: Wed, 12 Feb 2020 11:53:29 +0100
Message-Id: <4d32ab4e1fb2edb691d2e1687e8fb303c09fd023.1581504803.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 linux-sh@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Stefan Asserhall <stefan.asserhall@xilinx.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-xtensa@linux-xtensa.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>,
 Tony Luck <tony.luck@intel.com>, Paul Burton <paulburton@kernel.org>,
 linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Generated files are also checked by sparse that's why add newline
to remove sparse (C=1) warning.

The issue was found on Microblaze and reported like this:
./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
warning: no newline at end of file

Mips and PowerPC have it already but let's align with style used by m68k.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com> (xtensa)
---

Changes in v3:
- Add notes about mips/ppc and m68 - Max/Geert

Changes in v2:
- Update also others archs not just microblaze - Arnd
- Align subject and description to match multiarch change

 arch/alpha/kernel/syscalls/syscallhdr.sh      | 2 +-
 arch/ia64/kernel/syscalls/syscallhdr.sh       | 2 +-
 arch/microblaze/kernel/syscalls/syscallhdr.sh | 2 +-
 arch/mips/kernel/syscalls/syscallhdr.sh       | 3 +--
 arch/parisc/kernel/syscalls/syscallhdr.sh     | 2 +-
 arch/powerpc/kernel/syscalls/syscallhdr.sh    | 3 +--
 arch/sh/kernel/syscalls/syscallhdr.sh         | 2 +-
 arch/sparc/kernel/syscalls/syscallhdr.sh      | 2 +-
 arch/xtensa/kernel/syscalls/syscallhdr.sh     | 2 +-
 9 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscallhdr.sh b/arch/alpha/kernel/syscalls/syscallhdr.sh
index e5b99bd2e5e7..1780e861492a 100644
--- a/arch/alpha/kernel/syscalls/syscallhdr.sh
+++ b/arch/alpha/kernel/syscalls/syscallhdr.sh
@@ -32,5 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/ia64/kernel/syscalls/syscallhdr.sh b/arch/ia64/kernel/syscalls/syscallhdr.sh
index 0c2d2c748565..f407b6e53283 100644
--- a/arch/ia64/kernel/syscalls/syscallhdr.sh
+++ b/arch/ia64/kernel/syscalls/syscallhdr.sh
@@ -32,5 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/microblaze/kernel/syscalls/syscallhdr.sh b/arch/microblaze/kernel/syscalls/syscallhdr.sh
index 2e9062a926a3..a914854f8d9f 100644
--- a/arch/microblaze/kernel/syscalls/syscallhdr.sh
+++ b/arch/microblaze/kernel/syscalls/syscallhdr.sh
@@ -32,5 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/mips/kernel/syscalls/syscallhdr.sh b/arch/mips/kernel/syscalls/syscallhdr.sh
index d2bcfa8f4d1a..2e241e713a7d 100644
--- a/arch/mips/kernel/syscalls/syscallhdr.sh
+++ b/arch/mips/kernel/syscalls/syscallhdr.sh
@@ -32,6 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
-	printf "\n"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/parisc/kernel/syscalls/syscallhdr.sh b/arch/parisc/kernel/syscalls/syscallhdr.sh
index 50242b747d7c..730db288fe54 100644
--- a/arch/parisc/kernel/syscalls/syscallhdr.sh
+++ b/arch/parisc/kernel/syscalls/syscallhdr.sh
@@ -32,5 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/powerpc/kernel/syscalls/syscallhdr.sh b/arch/powerpc/kernel/syscalls/syscallhdr.sh
index c0a9a32937f1..02d6751f3be3 100644
--- a/arch/powerpc/kernel/syscalls/syscallhdr.sh
+++ b/arch/powerpc/kernel/syscalls/syscallhdr.sh
@@ -32,6 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
-	printf "\n"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/sh/kernel/syscalls/syscallhdr.sh b/arch/sh/kernel/syscalls/syscallhdr.sh
index 1de0334e577f..4c0519861e97 100644
--- a/arch/sh/kernel/syscalls/syscallhdr.sh
+++ b/arch/sh/kernel/syscalls/syscallhdr.sh
@@ -32,5 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/sparc/kernel/syscalls/syscallhdr.sh b/arch/sparc/kernel/syscalls/syscallhdr.sh
index 626b5740a9f1..cf50a75cc0bb 100644
--- a/arch/sparc/kernel/syscalls/syscallhdr.sh
+++ b/arch/sparc/kernel/syscalls/syscallhdr.sh
@@ -32,5 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
diff --git a/arch/xtensa/kernel/syscalls/syscallhdr.sh b/arch/xtensa/kernel/syscalls/syscallhdr.sh
index d37db641ca31..eebfb8a8ace6 100644
--- a/arch/xtensa/kernel/syscalls/syscallhdr.sh
+++ b/arch/xtensa/kernel/syscalls/syscallhdr.sh
@@ -32,5 +32,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "#define __NR_syscalls\t%s\n" "${nxt}"
 	printf "#endif\n"
 	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
+	printf "#endif /* %s */\n" "${fileguard}"
 ) > "$out"
-- 
2.25.0


Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2A2E0B71B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 06:17:06 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9EE1FDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 06:17:04 +1000 (EST)
Date: Wed, 17 Jun 2009 00:16:30 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH RFC 1/2] Makefile: Never use -fno-omit-frame-pointer
Message-ID: <20090616201630.GA4971@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to Segher Boessenkool and GCC manual, -fomit-frame-pointer
is only the default when optimising on archs/ABIs where it doesn't
hinder debugging and -pg. So, we do not get it by default on x86,
not at any optimisation level.

On the other hand, *using* -fno-omit-frame-pointer causes gcc to
produce buggy code on PowerPC targets.

If Segher and GCC manual are right, this patch should be a no-op
for all arches except PowerPC, where the patch fixes gcc issues.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

See this thread for more discussion:
http://osdir.com/ml/linux-kernel/2009-05/msg01754.html

p.s.
Obviously, I didn't test this patch on anything else but PPC32. ;-)

Segher, do you know if all GCC versions that we support for
building Linux are behaving the way that GCC manual describe?

Thanks,

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ea63667..70ad1ff 100644
--- a/Makefile
+++ b/Makefile
@@ -535,7 +535,7 @@ KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
 endif
 
 ifdef CONFIG_FRAME_POINTER
-KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
+KBUILD_CFLAGS	+= -fno-optimize-sibling-calls
 else
 KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
-- 
1.6.3.1

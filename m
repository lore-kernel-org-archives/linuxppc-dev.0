Return-Path: <lacombar@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79D92B6F8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 02:07:33 +1000 (EST)
Received: by qwf7 with SMTP id 7so1464641qwf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 09:07:24 -0700 (PDT)
From: Arnaud Lacombe <lacombar@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] xics/icp_natives: add __init to marker icp_native_init()
Date: Thu, 25 Aug 2011 12:07:13 -0400
Message-Id: <1314288433-26322-1-git-send-email-lacombar@gmail.com>
Cc: timur@freescale.com, Arnaud Lacombe <lacombar@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This should fix the following warning:

 LD      arch/powerpc/sysdev/xics/built-in.o
WARNING: arch/powerpc/sysdev/xics/built-in.o(.text+0x1310): Section mismatch in
reference from the function .icp_native_init() to the function
.init.text:.icp_native_init_one_node()
The function .icp_native_init() references
the function __init .icp_native_init_one_node().
This is often because .icp_native_init lacks a __init
annotation or the annotation of .icp_native_init_one_node is wrong.

icp_native_init() is only referenced in `arch/powerpc/sysdev/xics/xics-common.c'
by xics_init() which is itself marked with __init.

= not built-tested =

Reported-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>
---
 arch/powerpc/sysdev/xics/icp-native.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 50e32af..4c79b6f 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -276,7 +276,7 @@ static const struct icp_ops icp_native_ops = {
 #endif
 };
 
-int icp_native_init(void)
+int __init icp_native_init(void)
 {
 	struct device_node *np;
 	u32 indx = 0;
-- 
1.7.6.153.g78432

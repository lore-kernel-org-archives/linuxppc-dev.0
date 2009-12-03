Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C3421B7BE6
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 10:31:52 +1100 (EST)
Date: Fri, 4 Dec 2009 02:31:51 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 1/4] powerpc: Fix thinko in _stp_arg()
Message-ID: <20091203233151.GA3416@oksana.dev.rtsoft.ru>
References: <20091203233059.GA28186@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20091203233059.GA28186@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Jim Keniston <jkenisto@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_stp_arg() has an almost unnoticeable thinko in the argnum handling,
which causes it to always return u_register("r10"):

'else (argnum == 8)' should actually be 'else if (argnum == 8)'.

Though, since we check for 'if (argnum < 1 || argnum > 8)' at the
beginning of _stp_arg(), let's make it just 'else'.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 tapset/powerpc/registers.stp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tapset/powerpc/registers.stp b/tapset/powerpc/registers.stp
index c8713e5..7f66d36 100644
--- a/tapset/powerpc/registers.stp
+++ b/tapset/powerpc/registers.stp
@@ -146,7 +146,7 @@ function _stp_arg:long (argnum:long, sign_extend:long, truncate:long) {
 		val = u_register("r8")
 	else if (argnum == 7)
 		val = u_register("r9")
-	else (argnum == 8)
+	else
 		val = u_register("r10")
 
 	if (truncate) {
-- 
1.6.3.3

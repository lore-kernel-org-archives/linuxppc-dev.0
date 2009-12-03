Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 135ACB7D9E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 10:31:56 +1100 (EST)
Date: Fri, 4 Dec 2009 02:31:54 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 2/4] powerpc: Fix longlong args handling
Message-ID: <20091203233154.GB3416@oksana.dev.rtsoft.ru>
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

When probing 32-bits apps on ppc64 or running native ppc32, int64
parts are stored in the big endian order, e.g. foo(1LL, 2LL, 3LL)'s
args turn into:

arg1: r3 = 0; r4 = 1
arg2: r5 = 0; r6 = 2
arg3: r7 = 0; r8 = 3

For example, to restore arg1 the current longlong_arg() will perform
(r4 << 32) | r3, which is obviously incorrect. And to restore arg2 it
will do (r5 << 32) | r4, which doesn't look right as well.

This patch fixes the issue.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 tapset/powerpc/registers.stp |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tapset/powerpc/registers.stp b/tapset/powerpc/registers.stp
index 7f66d36..2403272 100644
--- a/tapset/powerpc/registers.stp
+++ b/tapset/powerpc/registers.stp
@@ -179,8 +179,8 @@ function ulong_arg:long (argnum:long) {
 
 function longlong_arg:long (argnum:long) {
 	if (probing_32bit_app()) {
-		lowbits = _stp_arg(argnum, 0, 1)
-		highbits = _stp_arg(argnum+1, 0, 1)
+		lowbits = _stp_arg(argnum * 2, 0, 1)
+		highbits = _stp_arg(argnum * 2 - 1, 0, 1)
 		return ((highbits << 32) | lowbits)
 	} else
 		return _stp_arg(argnum, 0, 0)
-- 
1.6.3.3

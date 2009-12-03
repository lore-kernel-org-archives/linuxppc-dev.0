Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9C09FB7F1E
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 10:32:03 +1100 (EST)
Date: Fri, 4 Dec 2009 02:32:02 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: systemtap@sourceware.org
Subject: [PATCH 3/4] powerpc: Adjust registers.stp for ppc32
Message-ID: <20091203233202.GC3416@oksana.dev.rtsoft.ru>
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

registers.stp is missing a few small bits when running on ppc32:

* Divide register offsets by 2;
* There is 'mq' register instead of 'softe';
* long_arg() should sign-extend the result on ppc32.

Suggested-by: Jim Keniston <jkenisto@us.ibm.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 tapset/powerpc/registers.stp |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/tapset/powerpc/registers.stp b/tapset/powerpc/registers.stp
index 2403272..4e77c7a 100644
--- a/tapset/powerpc/registers.stp
+++ b/tapset/powerpc/registers.stp
@@ -1,5 +1,13 @@
 /* Dwarfless register access for powerpc */
 
+function is_powerpc32() %{ /* pure */
+#ifdef __powerpc64__
+        THIS->__retvalue = 0;
+#else
+        THIS->__retvalue = 1;
+#endif
+%}
+
 global _reg_offsets, _stp_regs_registered
 
 function _stp_register_regs() {
@@ -43,23 +51,24 @@ function _stp_register_regs() {
 	_reg_offsets["link"] = 288
 	_reg_offsets["xer"] = 296
 	_reg_offsets["ccr"] = 304
-	_reg_offsets["softe"] = 312
+	if (is_powerpc32())
+		_reg_offsets["mq"] = 312
+	else
+		_reg_offsets["softe"] = 312
 	_reg_offsets["trap"] = 320
 	_reg_offsets["dar"] = 328
 	_reg_offsets["dsisr"] = 336
 	_reg_offsets["result"] = 344
 
-	/*
-	 * If we ever need to support 32bit powerpc, we can
-	 * get to the register offsets by using just a
-	 * reg32_offset = _reg_offsets["reg"]/2
-	 * or somesuch
-	 */
 	_stp_regs_registered = 1
 }
 
 function probing_32bit_app() %{ /* pure */
+#ifdef __powerpc64__
         THIS->__retvalue = _stp_probing_32bit_app(CONTEXT->regs);
+#else
+        THIS->__retvalue = 1;
+#endif
 %}
 
 function _stp_get_register_by_offset:long (offset:long) %{ /* pure */
@@ -91,7 +100,11 @@ function _stp_register:long (name:string, sign_extend:long) {
 	}
 	if (!_stp_regs_registered)
 		_stp_register_regs()
+
 	offset = _reg_offsets[name]
+	if (is_powerpc32())
+		offset /= 2
+
 	if (offset == 0 && !(name in _reg_offsets)) {
 		error("Unknown register: " . name)
 		return 0
@@ -170,7 +183,7 @@ function uint_arg:long (argnum:long) {
 }
 
 function long_arg:long (argnum:long) {
-	return _stp_arg(argnum, 1, 0)
+	return _stp_arg(argnum, 1, is_powerpc32())
 }
 
 function ulong_arg:long (argnum:long) {
-- 
1.6.3.3

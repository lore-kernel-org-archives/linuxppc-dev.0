Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qh8zK2dHzzDqD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 16:42:53 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 8 Apr 2016 16:42:51 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 435F93578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 16:42:48 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u386gd7237552288
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 16:42:48 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u386gE7s018001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 16:42:15 +1000
Message-ID: <570752AA.9050603@linux.vnet.ibm.com>
Date: Fri, 08 Apr 2016 14:41:46 +0800
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Boqun Feng <boqun.feng@gmail.com>,
 "'Peter Zijlstra (Intel)\"" <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] powerpc: introduce {cmp}xchg for u8 and u16
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>

Implement xchg{u8,u16}{local,relaxed}, and
cmpxchg{u8,u16}{,local,acquire,relaxed}.

Atomic operation on 8-bit and 16-bit data type is supported from power7

Signed-off-by: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cmpxchg.h | 265 +++++++++++++++++++++++++++++++++++++
 1 file changed, 265 insertions(+)

diff --git a/arch/powerpc/include/asm/cmpxchg.h b/arch/powerpc/include/asm/cmpxchg.h
index 44efe73..928ad89 100644
--- a/arch/powerpc/include/asm/cmpxchg.h
+++ b/arch/powerpc/include/asm/cmpxchg.h
@@ -15,6 +15,74 @@
  */
 
 static __always_inline unsigned long
+__xchg_u8_local(volatile void *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	lbarx	%0,0,%2\n"
+	PPC405_ERR77(0,%2)
+"	stbcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*(volatile unsigned char *)p)
+	: "r" (p), "r" (val)
+	: "cc", "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__xchg_u8_relaxed(u8 *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	lbarx	%0,0,%2\n"
+	PPC405_ERR77(0,%2)
+"	stbcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (val)
+	: "cc");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__xchg_u16_local(volatile void *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	lharx	%0,0,%2\n"
+	PPC405_ERR77(0,%2)
+"	sthcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*(volatile unsigned short *)p)
+	: "r" (p), "r" (val)
+	: "cc", "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__xchg_u16_relaxed(u16 *p, unsigned long val)
+{
+	unsigned long prev;
+
+	__asm__ __volatile__(
+"1:	lharx	%0,0,%2\n"
+	PPC405_ERR77(0,%2)
+"	sthcx.	%3,0,%2\n"
+"	bne-	1b"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (val)
+	: "cc");
+
+	return prev;
+}
+
+static __always_inline unsigned long
 __xchg_u32_local(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
@@ -88,6 +156,10 @@ static __always_inline unsigned long
 __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __xchg_u8_local(ptr, x);
+	case 2:
+		return __xchg_u16_local(ptr, x);
 	case 4:
 		return __xchg_u32_local(ptr, x);
 #ifdef CONFIG_PPC64
@@ -103,6 +175,10 @@ static __always_inline unsigned long
 __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __xchg_u8_relaxed(ptr, x);
+	case 2:
+		return __xchg_u16_relaxed(ptr, x);
 	case 4:
 		return __xchg_u32_relaxed(ptr, x);
 #ifdef CONFIG_PPC64
@@ -132,6 +208,179 @@ __xchg_relaxed(void *ptr, unsigned long x, unsigned int size)
  */
 
 static __always_inline unsigned long
+__cmpxchg_u8(volatile unsigned char *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+	PPC_ATOMIC_ENTRY_BARRIER
+"1:	lbarx	%0,0,%2		# __cmpxchg_u8\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	stbcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	PPC_ATOMIC_EXIT_BARRIER
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u8_local(volatile unsigned char *p, unsigned long old,
+			unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+"1:	lbarx	%0,0,%2		# __cmpxchg_u8_local\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	stbcx.	%4,0,%2\n"
+"	bne-	1b\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u8_relaxed(u8 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+"1:	lbarx	%0,0,%2		# __cmpxchg_u8_relaxed\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	stbcx.	%4,0,%2\n"
+"	bne-	1b\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u8_acquire(u8 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+"1:	lbarx	%0,0,%2		# __cmpxchg_u8_acquire\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	stbcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	PPC_ACQUIRE_BARRIER
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u16(volatile unsigned short *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+	PPC_ATOMIC_ENTRY_BARRIER
+"1:	lharx	%0,0,%2		# __cmpxchg_u16\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	sthcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	PPC_ATOMIC_EXIT_BARRIER
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u16_local(volatile unsigned short *p, unsigned long old,
+			unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+"1:	lharx	%0,0,%2		# __cmpxchg_u16_local\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	sthcx.	%4,0,%2\n"
+"	bne-	1b\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u16_relaxed(u16 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+"1:	lharx	%0,0,%2		# __cmpxchg_u16_relaxed\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	sthcx.	%4,0,%2\n"
+"	bne-	1b\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc");
+
+	return prev;
+}
+
+static __always_inline unsigned long
+__cmpxchg_u16_acquire(u16 *p, unsigned long old, unsigned long new)
+{
+	unsigned long prev = 0;
+
+	__asm__ __volatile__ (
+"1:	lharx	%0,0,%2		# __cmpxchg_u16_acquire\n"
+"	cmpw	0,%0,%3\n"
+"	bne-	2f\n"
+	PPC405_ERR77(0,%2)
+"	sthcx.	%4,0,%2\n"
+"	bne-	1b\n"
+	PPC_ACQUIRE_BARRIER
+	"\n"
+"2:"
+	: "=&r" (prev), "+m" (*p)
+	: "r" (p), "r" (old), "r" (new)
+	: "cc", "memory");
+
+	return prev;
+}
+
+
+static __always_inline unsigned long
 __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
 {
 	unsigned int prev;
@@ -316,6 +565,10 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32(ptr, old, new);
 #ifdef CONFIG_PPC64
@@ -332,6 +585,10 @@ __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8_local(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16_local(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32_local(ptr, old, new);
 #ifdef CONFIG_PPC64
@@ -348,6 +605,10 @@ __cmpxchg_relaxed(void *ptr, unsigned long old, unsigned long new,
 		  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8_relaxed(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16_relaxed(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32_relaxed(ptr, old, new);
 #ifdef CONFIG_PPC64
@@ -364,6 +625,10 @@ __cmpxchg_acquire(void *ptr, unsigned long old, unsigned long new,
 		  unsigned int size)
 {
 	switch (size) {
+	case 1:
+		return __cmpxchg_u8_acquire(ptr, old, new);
+	case 2:
+		return __cmpxchg_u16_acquire(ptr, old, new);
 	case 4:
 		return __cmpxchg_u32_acquire(ptr, old, new);
 #ifdef CONFIG_PPC64
-- 
1.9.1

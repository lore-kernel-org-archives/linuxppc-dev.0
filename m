Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18453.22040.750843.373369@cargo.ozlabs.ibm.com>
Date: Mon, 28 Apr 2008 14:44:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [POWERPC] Use __always_inline for xchg* and cmpxchg*
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This changes the definitions of the xchg and cmpxchg families of
functions in include/asm-powerpc/system.h to be marked __always_inline
rather than __inline__.  The reason for doing this is that we rely on
the compiler inlining them in order to eliminate the references to 
__xchg_called_with_bad_pointer and __cmpxchg_called_with_bad_pointer,
which are deliberately left undefined.  Thus this change will enable
us to make the inline keyword be just a hint rather than a directive.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
index fab1674..2b6559a 100644
--- a/include/asm-powerpc/system.h
+++ b/include/asm-powerpc/system.h
@@ -204,7 +204,7 @@ extern int powersave_nap;	/* set if nap mode can be used in idle loop */
  * Changes the memory location '*ptr' to be val and returns
  * the previous value stored there.
  */
-static __inline__ unsigned long
+static __always_inline unsigned long
 __xchg_u32(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
@@ -229,7 +229,7 @@ __xchg_u32(volatile void *p, unsigned long val)
  * Changes the memory location '*ptr' to be val and returns
  * the previous value stored there.
  */
-static __inline__ unsigned long
+static __always_inline unsigned long
 __xchg_u32_local(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
@@ -247,7 +247,7 @@ __xchg_u32_local(volatile void *p, unsigned long val)
 }
 
 #ifdef CONFIG_PPC64
-static __inline__ unsigned long
+static __always_inline unsigned long
 __xchg_u64(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
@@ -266,7 +266,7 @@ __xchg_u64(volatile void *p, unsigned long val)
 	return prev;
 }
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __xchg_u64_local(volatile void *p, unsigned long val)
 {
 	unsigned long prev;
@@ -290,7 +290,7 @@ __xchg_u64_local(volatile void *p, unsigned long val)
  */
 extern void __xchg_called_with_bad_pointer(void);
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __xchg(volatile void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
@@ -305,7 +305,7 @@ __xchg(volatile void *ptr, unsigned long x, unsigned int size)
 	return x;
 }
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
 {
 	switch (size) {
@@ -338,7 +338,7 @@ __xchg_local(volatile void *ptr, unsigned long x, unsigned int size)
  */
 #define __HAVE_ARCH_CMPXCHG	1
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
 {
 	unsigned int prev;
@@ -361,7 +361,7 @@ __cmpxchg_u32(volatile unsigned int *p, unsigned long old, unsigned long new)
 	return prev;
 }
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
 			unsigned long new)
 {
@@ -384,7 +384,7 @@ __cmpxchg_u32_local(volatile unsigned int *p, unsigned long old,
 }
 
 #ifdef CONFIG_PPC64
-static __inline__ unsigned long
+static __always_inline unsigned long
 __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
 {
 	unsigned long prev;
@@ -406,7 +406,7 @@ __cmpxchg_u64(volatile unsigned long *p, unsigned long old, unsigned long new)
 	return prev;
 }
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __cmpxchg_u64_local(volatile unsigned long *p, unsigned long old,
 			unsigned long new)
 {
@@ -432,7 +432,7 @@ __cmpxchg_u64_local(volatile unsigned long *p, unsigned long old,
    if something tries to do an invalid cmpxchg().  */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
 {
@@ -448,7 +448,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new,
 	return old;
 }
 
-static __inline__ unsigned long
+static __always_inline unsigned long
 __cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new,
 	  unsigned int size)
 {

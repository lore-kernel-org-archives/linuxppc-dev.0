Message-ID: <3EF39EFA.8040507@mvista.com>
Date: Fri, 20 Jun 2003 16:55:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Patch for include/asm-ppc/highmem.h
Content-Type: multipart/mixed;
 boundary="------------060406080908020902080902"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060406080908020902080902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes the mask value to what I believe it was intended to
be based on the bk comments for that file.  If this is not the proper
fix, we need to figure it out b/c it doesn't build when CONFIG_HIGHMEM
is on (PAGE_ADDRESS is not defined).

Mark

--------------060406080908020902080902
Content-Type: text/plain;
 name="highmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="highmem.patch"

===== include/asm-ppc/highmem.h 1.18 vs edited =====
--- 1.18/include/asm-ppc/highmem.h	Sat May 10 01:06:50 2003
+++ edited/include/asm-ppc/highmem.h	Fri Jun 20 16:50:26 2003
@@ -110,7 +110,7 @@
 static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 {
 #if HIGHMEM_DEBUG
-	unsigned long vaddr = (unsigned long) kvaddr & PAGE_ADDRESS;
+	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
 	unsigned int idx = type + KM_TYPE_NR*smp_processor_id();

 	if (vaddr < KMAP_FIX_BEGIN) // FIXME

--------------060406080908020902080902--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <199912281902.OAA25964@mal-ach.watson.ibm.com>
To: Joel Klecker <jk@espy.org>
cc: dhd@debian.org, linuxppc-dev@lists.linuxppc.org, libc-alpha@cygnus.com
Subject: Re: DB_THREAD support in Berkeley DB/glibc 
In-Reply-To: Message from Joel Klecker <jk@espy.org>
   of "Tue, 28 Dec 1999 09:53:58 PST." <v04220802b48ea8ff2961@[206.163.71.146]>
Date: Tue, 28 Dec 1999 14:02:03 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


+/*
+ * PowerPC spinlock, adapted from the Alpha and m68k ones by dhd@debian.org
+ *
+ * For gcc/powerpc, 0 is clear, 1 is set (but *tsl will always be 0 since it's a char)
+ */
+#define TSL_SET(tsl) ({						\
+	register tsl_t *__l = (tsl);					\
+	register tsl_t __r1;						\
+	__asm__ volatile("						\n\
+	   10: lwarx  %0,0,%1						\n\
+	       cmpwi  %0,0						\n\
+	       bne+   20f						\n\
+	       stwcx. %2,0,%1						\n\
+	       bne-   10b						\n\
+	   20: "							\
+	  : "=&r" (__r1)						\
+	  : "r" (__l), "r" (-1) : "cr0", "memory");			\
+	!__r1;								\
+})
+
+#define	TSL_UNSET(tsl)	(*(tsl) = 0)
+#define	TSL_INIT(tsl)	TSL_UNSET(tsl)

	The TSL_SET macro is basically correct for PowerPC uniprocessor,
but it is not MP safe.  For cases where this needs to be safe across a
multiprocessor complex, it should be preceded by a "sync" instruction and
ended with an "isync" instruction, or something similar depending on the
semantics one uses for accessing the word.

	It is not clear to me why the TSL_UNSET macro is sufficient.

David
===============================================================================
David Edelsohn                                      T.J. Watson Research Center
dje@watson.ibm.com                                  P.O. Box 218
+1 914 945 4364 (TL 862)                            Yorktown Heights, NY 10598

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

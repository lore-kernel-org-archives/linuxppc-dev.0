Subject: Why is search_exception_table disabled for modules on PPC?
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 13 Apr 2000 11:09:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000413010937.A91D73C998@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello again,

A few days ago on the linuxppc-dev mailing list, I asked:
> Can anyone tell me why arch/ppc/mm/extable.c:search_exception_table only
> searches the kernel exception table on PowerPC in 2.2.14?  Why isn't the
> per-module table search enabled like on every other architecture?

Well looks like everyone's asleep. Anyway, it looks wrong to me. I believe it
means that modules which attempt their own user space accesses without using
the uaccess stuff can cause a kernel panic. I think the following fix
should be applied to the 2.2 and 2.3 branches:

As an aside, is there a better address I should mail kernel patches to in
order to ensure that they make it into the BitKeeper repository?


Index: arch/ppc/mm/extable.c
===================================================================
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 extable.c
--- arch/ppc/mm/extable.c	1999/12/30 05:56:30	1.1.1.1
+++ arch/ppc/mm/extable.c	2000/04/10 09:40:12
@@ -36,7 +36,7 @@
 {
 	unsigned long ret;

-#if 1 /*ndef CONFIG_MODULES*/
+#ifndef CONFIG_MODULES
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table-1, addr);
 	if (ret) return ret;


Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-Id: <200104101719.f3AHJjQ29083@ashley.ivey.uwo.ca>
Date: Tue, 10 Apr 2001 13:19:44 -0400
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Content-Type: text/plain;
	format=flowed;
	charset=us-ascii
Cc: linuxppc-dev@lists.linuxppc.org
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Mime-Version: 1.0 (Apple Message framework v387)
Subject: gcc 2v optimization problem with C++ exceptions?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Franz,

I need some help trying to debug a gcc (2v - your latest) ppc
optimization problem
in C++ code that uses exceptions.

I have one project that when compiled with "-O2" that causes an uncaught
exception abort but when built with "-O2 -fno-schedule-* of both types"
works fine.

Since the involved source code is quite large, I used objdump -D -C on
every shared
object file and saved the disassembled dumps.  I then used diff to
compare the working
and non-working versions.

The *ONLY* difference in the resulting dumps occurred in the
__EXCEPTION_TABLE entries.

Here is an example of one such difference (please ignore the assembly
itself since it is from disassembling the "data" in the exception table).

diff -u unxlngppc.pro.bad/slo/broadcaster.dump
unxlngppc.pro.working/slo/broadcaster.dump
--- unxlngppc.pro.bad/slo/broadcaster.dump      Tue Apr 10 10:23:51 2001
+++ unxlngppc.pro.working/slo/broadcaster.dump  Tue Apr 10 10:31:25 2001
@@ -9268,8 +9268,8 @@
       480:      6f 61 64 63     xoris   r1,r27,25699
       484:      61 73 74 65     ori     r19,r11,29797
       488:      72 2e 63 78     andi.   r14,r17,25464
-     48c:      78 36 4e 55     .long 0x78364e55
-     490:      6e 4d 64 32     xoris   r13,r18,25650
+     48c:      78 66 44 76     .long 0x78664476
+     490:      54 76 61 32     rlwinm  r22,r3,12,4,25
       494:      31 45 6d 70     addic   r10,r5,28016
       498:      74 79 42 72     andis.  r25,r3,17010
       49c:      6f 61 64 63     xoris   r1,r27,25699


There were *no* underlying code differences in any way.  (I actually
thought adding the -fno-schedule stuff would have a big impact on the
code generated but it did not seem to under g++)

Note: the failure mode of this code is to not catch
an exception that is thrown (I believe properly).

I do not understand how __EXCEPTION_TABLES are built (I assume they give
starting and ending ranges of pcs that is used during stack walkback to
check if the offending throw should be caught someplace.  I looked but
some of the entries are aligned to 4 (as I expect a pc value to be) and
some are not.

I also don't understand why -f-no-schedule-insns* should have any impact
on the exception table if the underlying code is not different (i.e. no
reordering was done).

Can you tell me the best way to track this thing down to something
smaller so that I can give a more informative bug report and or create a
sample program that exhibits the same behavior?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

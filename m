Message-ID: <38A6C19F.92468821@wanadoo.fr>
Date: Sun, 13 Feb 2000 15:37:19 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: Paul Mackerras <paulus@linuxcare.com>
Subject: Re: 2.3.43 failed
References: <00021211003504.00821@linux.eric.fr> <00021318311301.12422@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> I just updated linuxcare.com.au::linux-pmac-devel to 2.3.44 final.  I
> fixed a couple of problems where it would hang during boot if you booted
> from OF (or with quik or yaboot) and it couldn't find the screen.  Try it
> now.  If it doesn't work, let me know (and tell me how you are booting it).

On my 6400, it compiles and boots OK, but there are some little itches:

- rsync complains about "send_files failed to open
Documentation/kernel-docs.txt: Permission denied"

- rsync copies a spurious file drivers/net/.#ppp_generic.c which is a
dead symlink

- during booting, there is a message
"/proc/sys/net/ipv4/ip_always_defrag is missing - Cannot control IP
fragmentation"

- while using my ethernet card with the de4x5 driver, I get hundreds of
"kernel: Warning: kfree_skb on hard IRQ c010ded8". Seeing that this
address is inside the de4x5 driver, I tried to compile it as a module,
so that I could also compare it to the tulip driver. Didn't work at
first:

- the tulip module loads without problem, but doesn't seem to like my
ethernet card (DEC 21041 chip). It gives me hundreds of "kernel: eth0:
21041 transmit timed out, status fc6800". With 2.2.14 kernels, the tulip
module works OK.

- the de4x5 module complains about missing symbols; and this is in fact
a bug I had mentioned already some days ago. I repeat the patch below.
It seems to be necessary, and it cures the problem. I am now on the net
with de4x5 as a module, but I still get the warnings, now with an
address in the module:
Feb 13 15:06:14 rennes-231 kernel: Warning: kfree_skb on hard IRQ
c7159770
Feb 13 15:07:24 rennes-231 last message repeated 421 times
Feb 13 15:12:01 rennes-231 last message repeated 97 times
and so on.

How can I get rid of the warnings (short of disabling the line that
produces it in net/core/skbuff.c)?

Here is the patch needed by pci driver modules:

--- arch/ppc/kernel/ppc_ksyms.c.ori     Fri Feb  4 10:18:20 2000
+++ arch/ppc/kernel/ppc_ksyms.c Fri Feb  4 10:28:10 2000
@@ -11,6 +11,7 @@
 #include <linux/spinlock.h>
 #include <linux/console.h>
 #include <linux/irq.h>
+#include <linux/pci.h>

 #include <asm/page.h>
 #include <asm/semaphore.h>
@@ -137,6 +138,9 @@
 EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__strncpy_from_user);
 EXPORT_SYMBOL(__strnlen_user);
+
+EXPORT_SYMBOL(pci_alloc_consistent);
+EXPORT_SYMBOL(pci_free_consistent);

 /*
 EXPORT_SYMBOL(inb);

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

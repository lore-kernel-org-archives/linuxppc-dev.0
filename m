Message-ID: <378DB61F.15D77BD6@agelectronics.co.uk>
Date: Thu, 15 Jul 1999 11:21:19 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: more /proc/ppc_htab
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In the 2.2.10 kernel (with a Debian userspace), cat /proc/ppc_htab
works, and more /proc/ppc_htab produces a segfault. This fixes it.

- Adrian Cox, AG Electronics

--- linuxppc-2.2.10/arch/ppc/kernel/ppc_htab.c  Thu Dec 10 00:24:23 1998
+++ linux/arch/ppc/kernel/ppc_htab.c    Thu Jul 15 11:17:40 1999
@@ -253,6 +253,8 @@
                return 0;
        if (n > strlen(buffer) - *ppos)
                n = strlen(buffer) - *ppos;
+        if (n > count)
+            n = count;
        copy_to_user(buf, buffer + *ppos, n);
        *ppos += n;
        return n;

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

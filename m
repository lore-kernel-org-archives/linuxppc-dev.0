Date: Sun, 22 Oct 2000 12:58:09 +1100
From: Chris Leishman <masklin@debian.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Airport code problems.
Message-ID: <20001022125809.A1978@nina.dev.fol>
References: <20001022011031.A4290@nina.dev.fol> <19340915123324.31079@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19340915123324.31079@192.168.1.10>; from bh40@calva.net on Sat, Oct 21, 2000 at 09:01:40PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

I just fixed the problem I was having with your dev kernel source, and got
that installed.  Then I tried recompiling the airport driver, and had some
problems with multiply defined macro's in k_compat.h.  They were
"init_waitqueue_head(p)" and "__set_current_state(n)".

I'm doubt this is the right way of fixing it, but the patch below worked.


--- k_compat.h.orig     Fri Jun 30 07:59:11 2000
+++ k_compat.h  Sun Oct 22 12:56:20 2000
@@ -52,7 +52,7 @@
 #define DEV_ID                 dev_id
 #define IRQ_MAP(irq, dev)      do { } while (0)

-#if (LINUX_VERSION_CODE < VERSION(2,3,1))
+#if ((LINUX_VERSION_CODE < VERSION(2,3,16)) && (LINUX_VERSION_CODE >=
VERSION(2,3,0)) || (LINUX_VERSION_CODE < VERSION(2,2,18)))
 #if (LINUX_VERSION_CODE < VERSION(2,0,16))
 #define init_waitqueue_head(p) (*(p) = NULL)
 #else
@@ -176,7 +176,7 @@
 #if (LINUX_VERSION_CODE < VERSION(2,1,0))
 #define __set_current_state(n) \
     do { current->state = TASK_INTERRUPTIBLE; } while (0)
-#elif (LINUX_VERSION_CODE < VERSION(2,3,16))
+#elif ((LINUX_VERSION_CODE < VERSION(2,3,16)) && (LINUX_VERSION_CODE >=
VERSION(2,3,0)) || (LINUX_VERSION_CODE < VERSION(2,2,18)))
 #define __set_current_state(n) do { current->state = (n); } while (0)
 #endif



Chris

--
----------------------------------------------------------------------
       Knuth: premature optimization is the root of all evil.
----------------------------------------------------------------------
Reply with subject 'request key' for GPG public key.  KeyID 0xB4E24219

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

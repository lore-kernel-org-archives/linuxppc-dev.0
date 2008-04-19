Return-Path: <roland@redhat.com>
Received: from QMTA07.emeryville.ca.mail.comcast.net
	(qmta07.emeryville.ca.mail.comcast.net [76.96.30.64])
	by ozlabs.org (Postfix) with ESMTP id 84148DE13F
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 08:19:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc copy_siginfo_from_user32
Message-Id: <20080419221924.424EF27037C@magilla.localdomain>
Date: Sat, 19 Apr 2008 15:19:24 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.  I posted this before, but I don't see it in any of your powerpc.git
trees.  Can you push this upstream ASAP?  It would make life easier for me
trying to merge some more generic changes (that would break powerpc builds
without this going in first).

Thanks,
Roland

---
[PATCH] powerpc copy_siginfo_from_user32

Define the copy_siginfo_from_user32 entry point for powerpc, so
that generic CONFIG_COMPAT code can call it.  We already had the
code rolled into compat_sys_rt_sigqueueinfo, this just moves it
out into the canonical function that other arch's define.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/signal_32.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d840bc7..ad69434 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -621,6 +621,18 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *d, siginfo_t *s)
 
 #define copy_siginfo_to_user	copy_siginfo_to_user32
 
+int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from)
+{
+	memset(to, 0, sizeof *to);
+
+	if (copy_from_user(to, from, 3*sizeof(int)) ||
+	    copy_from_user(to->_sifields._pad,
+			   from->_sifields._pad, SI_PAD_SIZE32))
+		return -EFAULT;
+
+	return 0;
+}
+
 /*
  * Note: it is necessary to treat pid and sig as unsigned ints, with the
  * corresponding cast to a signed int to insure that the proper conversion
@@ -634,9 +646,10 @@ long compat_sys_rt_sigqueueinfo(u32 pid, u32 sig, compat_siginfo_t __user *uinfo
 	int ret;
 	mm_segment_t old_fs = get_fs();
 
-	if (copy_from_user (&info, uinfo, 3*sizeof(int)) ||
-	    copy_from_user (info._sifields._pad, uinfo->_sifields._pad, SI_PAD_SIZE32))
-		return -EFAULT;
+	ret = copy_siginfo_from_user32(&info, uinfo);
+	if (unlikely(ret))
+		return ret;
+
 	set_fs (KERNEL_DS);
 	/* The __user pointer cast is valid becasuse of the set_fs() */
 	ret = sys_rt_sigqueueinfo((int)pid, (int)sig, (siginfo_t __user *) &info);

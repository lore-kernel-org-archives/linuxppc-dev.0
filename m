Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9Gz65kwpzDqKY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 13:39:46 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id i75so12974361ioa.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 20:39:46 -0700 (PDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 1/4] rcutorture/doc: Add a new way to create initrd using
 dracut
Date: Thu, 19 May 2016 11:42:21 +0800
Message-Id: <1463629344-20471-2-git-send-email-boqun.feng@gmail.com>
In-Reply-To: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
References: <1463629344-20471-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using dracut is another way to get an initramfs for kvm based rcu
torture tests, which is more flexible than using the host's initramfs
image, because modules and binaries may be added or removed via dracut
command options. So add an example in the document, in case that there
are some situations where host's initramfs couldn't be used.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 tools/testing/selftests/rcutorture/doc/initrd.txt | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/doc/initrd.txt b/tools/testing/selftests/rcutorture/doc/initrd.txt
index 4170e714f044..833f826d6ec2 100644
--- a/tools/testing/selftests/rcutorture/doc/initrd.txt
+++ b/tools/testing/selftests/rcutorture/doc/initrd.txt
@@ -13,6 +13,22 @@ cd initrd
 cpio -id < /tmp/initrd.img.zcat
 ------------------------------------------------------------------------
 
+Another way to create an initramfs image is using "dracut"[1], which is
+available on many distros, however the initramfs dracut generates is a cpio
+archive with another cpio archive in it, so an extra step is needed to create
+the initrd directory hierarchy.
+
+Here are the commands to create a initrd directory for rcutorture using
+dracut:
+
+------------------------------------------------------------------------
+dracut --no-hostonly --no-hostonly-cmdline --module "base bash shutdown" /tmp/initramfs.img
+cd tools/testing/selftests/rcutorture
+mkdir initrd
+cd initrd
+/usr/lib/dracut/skipcpio /tmp/initramfs.img | zcat | cpio -id < /tmp/initramfs.img
+------------------------------------------------------------------------
+
 Interestingly enough, if you are running rcutorture, you don't really
 need userspace in many cases.  Running without userspace has the
 advantage of allowing you to test your kernel independently of the
@@ -89,3 +105,9 @@ while :
 do
 	sleep 10
 done
+------------------------------------------------------------------------
+
+References:
+[1]: https://dracut.wiki.kernel.org/index.php/Main_Page
+[2]: http://blog.elastocloud.org/2015/06/rapid-linux-kernel-devtest-with-qemu.html
+[3]: https://www.centos.org/forums/viewtopic.php?t=51621
-- 
2.8.0

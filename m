Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EB2606B93F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PR4eStJu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJF6L1S92z30Vn;
	Tue, 03 Nov 2026 01:52:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793631130;
	cv=none; b=EYOYJ5Tv7zob0BoD/8IYRmTNFoRBMn0piYq8xOpKgrD1IO4qgZu+VvQ2SigtJuZD2Z0Fb19lySCR8aSHE2iZTZeBRvYqjoYCNFfjxUeIkNZgprThU/KCVWfks9UB91HHM8vehDlezLcZQJUMjZ0U+pm9xJOC4vEJ+TlF1t3du1VRi6RkqYcus2f9FkrF2dAy2OveZhKDZqesNfTrR/EBVg0dgoK/85IY3rml96/1hBxqshM7XstHUB9q0wno86ULFW6tUjoh0N4VY4L6UlEdEHr//f0Tu7q6xnWHRClEnr825Xxben8v7nGKXhRJCbkaLDrZD0/epuI1y+hZHlrO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793631130; c=relaxed/relaxed;
	bh=iJ84nEP4YY4K28kLfEZAA/6j0sLXVTf/aEe1LCZ8e14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+e1OTnkUHrSK/U/wKCMol6ka2JtgH+vfiUXMoW1/dhAurNHAf3KCSYU0yrpwc6PBPXbGwlkpeZMKYlt2p89Bfj+Mt6GV0MRmJY63v8H6P8sxdNmyvcmANC/N4qBUT6PqcIm9nx9k4TmvpFthe/dUbaO5ju2q6pe6Qk7FkiIr9hf78IaDlItQQiZiwcJZns2ftnaOMW0PCaS9bagU+xBfB/2FMavos1fEhr2Epj0uBiMPu7e4zLqndJ5ztAgBVSzDi3332w29799SjidTN+v6wAF1eRcst8+dGs3Ar4Hjc6n9TFjhUAb5lf11ypO6IJ2k6QGV8CkPkGNy2NGqJEr6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PR4eStJu; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PR4eStJu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJF6K2ZF4z2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:52:09 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2DE1E600D4;
	Mon,  2 Nov 2026 14:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FECC1F00A1B;
	Mon,  2 Nov 2026 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631126;
	bh=iJ84nEP4YY4K28kLfEZAA/6j0sLXVTf/aEe1LCZ8e14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PR4eStJuCoR+mECGMaIVXtQASozW+a7AOmyTO4iG4xy4nIzb4PWW2BKxvYmoNRuHs
	 x2Lm2Rfp+v90UcW719VC0BYV4O8DTyukQ9z+uecUIg7pY28G7drnWgQgVWiNUS+/ck
	 xxhSirH9ZyCaYNU7/1qRcYlti7eFvPDGGsReRJYcEPKXsJ5iSGH7SZJURK2R0hC4aT
	 hXX/7O0Tf8cPki+pg2H6SZ7pXnNxkptKTlJYs8cIZrx/PHwXHyzeBPMp/y/AzKyvOE
	 N8mqzLmWmEBFNIMmXqg5H4OevB0bDwM2UM7fMf6GDHFGBq7FkN5sBI9EBYQrhUrLbY
	 N6tJxPjUYmLBA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:48:48 +0100
Subject: [PATCH RFC 08/16] selftests/proc: check that a faulting reader
 doesn't hold up removal
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-work-procfs-core-v1-8-75df35e4f8b8@kernel.org>
References: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
In-Reply-To: <20261102-work-procfs-core-v1-0-75df35e4f8b8@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Chris Mason <mason@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, 
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, platform-driver-x86@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 ibm-acpi-devel@lists.sourceforge.net, jfs-discussion@lists.sourceforge.net, 
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-cifs@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org, 
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org, 
 sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-atm-general@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>, 
 linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-debuggers@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chuck Lever <cel@kernel.org>
X-Mailer: b4 0.17-dev
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Read /proc/net/dev_snmp6/<dev> of a tun device into a buffer whose first
page is backed by userfaultfd and remove the device while the reader
sleeps in its copy to userspace:

- removing the entry doesn't wait for the reader

- the reader still gets what was printed before the removal

- and the next read fails with -EIO

The entry is removed under RTNL, so a regression stalls the test for
five seconds before it fails.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/proc/proc-remove-slow-reader.c       | 133 +++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/proc/proc-remove-slow-reader.c b/tools/testing/selftests/proc/proc-remove-slow-reader.c
new file mode 100644
index 000000000000..a201645beca9
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-remove-slow-reader.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A read that faults while copying to userspace must not hold up removal of
+ * the /proc entry. /proc/net/dev_snmp6/<dev> of a tun device is removed under
+ * RTNL when the device's file is closed.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <linux/userfaultfd.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sched.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define TUN_NAME	"procslow0"
+#define SNMP6_PATH	"/proc/net/dev_snmp6/" TUN_NAME
+#define READ_PAGES	16
+#define TIMEOUT_MS	5000
+
+struct reader {
+	int fd;
+	char *buf;
+	size_t len;
+	ssize_t ret;
+};
+
+struct closer {
+	int tun;
+	int done;
+};
+
+static void *read_thread(void *arg)
+{
+	struct reader *r = arg;
+
+	r->ret = read(r->fd, r->buf, r->len);
+	return NULL;
+}
+
+static void *close_thread(void *arg)
+{
+	struct closer *c = arg;
+	ssize_t ret;
+
+	close(c->tun);
+	ret = write(c->done, "x", 1);
+	return (void *)ret;
+}
+
+TEST(remove_while_reader_faults)
+{
+	struct uffdio_api api = { .api = UFFD_API };
+	struct uffdio_register reg = {};
+	struct uffdio_zeropage zero = {};
+	long psz = sysconf(_SC_PAGESIZE);
+	struct ifreq ifr = {};
+	struct reader r = {};
+	struct closer c = {};
+	struct uffd_msg msg;
+	struct pollfd pfd;
+	pthread_t rt, ct;
+	int uffd, done[2];
+	char *buf;
+
+	if (unshare(CLONE_NEWNET))
+		SKIP(return, "unshare(CLONE_NEWNET): %s", strerror(errno));
+
+	c.tun = open("/dev/net/tun", O_RDWR | O_CLOEXEC);
+	if (c.tun < 0)
+		SKIP(return, "/dev/net/tun: %s", strerror(errno));
+	strncpy(ifr.ifr_name, TUN_NAME, IFNAMSIZ - 1);
+	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
+	ASSERT_EQ(ioctl(c.tun, TUNSETIFF, &ifr), 0);
+
+	r.fd = open(SNMP6_PATH, O_RDONLY | O_CLOEXEC);
+	if (r.fd < 0)
+		SKIP(return, SNMP6_PATH ": %s", strerror(errno));
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0)
+		SKIP(return, "userfaultfd: %s", strerror(errno));
+	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
+
+	/* Only the first page of the buffer goes through userfaultfd. */
+	buf = mmap(NULL, READ_PAGES * psz, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(buf, MAP_FAILED);
+	reg.range.start = (unsigned long)buf;
+	reg.range.len = psz;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
+
+	r.buf = buf;
+	r.len = READ_PAGES * psz;
+	ASSERT_EQ(pthread_create(&rt, NULL, read_thread, &r), 0);
+
+	/* The reader now sleeps in its copy to userspace. */
+	pfd = (struct pollfd){ .fd = uffd, .events = POLLIN };
+	ASSERT_EQ(poll(&pfd, 1, TIMEOUT_MS), 1);
+	ASSERT_EQ(read(uffd, &msg, sizeof(msg)), sizeof(msg));
+	ASSERT_EQ(msg.event, UFFD_EVENT_PAGEFAULT);
+
+	/* Closing the device removes the file that is being read. */
+	ASSERT_EQ(pipe2(done, O_CLOEXEC), 0);
+	c.done = done[1];
+	ASSERT_EQ(pthread_create(&ct, NULL, close_thread, &c), 0);
+	pfd = (struct pollfd){ .fd = done[0], .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, TIMEOUT_MS), 1) {
+		TH_LOG("removing " SNMP6_PATH " waited for the reader");
+	}
+
+	zero.range.start = (unsigned long)buf;
+	zero.range.len = psz;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_ZEROPAGE, &zero), 0);
+	ASSERT_EQ(pthread_join(rt, NULL), 0);
+	ASSERT_EQ(pthread_join(ct, NULL), 0);
+
+	/* What was printed before the removal still arrives, then nothing. */
+	EXPECT_GT(r.ret, 0);
+	EXPECT_EQ(read(r.fd, buf, psz), -1);
+	EXPECT_EQ(errno, EIO);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0



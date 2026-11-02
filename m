Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950766082631
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfP/Kahw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJF0l2Wj0z2xXB;
	Tue, 03 Nov 2026 01:47:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793630839;
	cv=none; b=A8jkjn0CxcZBq39+pa4RCL8NRsSLmR1FWFkByssNunRqRHnigwnLvlhVL0PnS7coFHC2UUZwQG/b/XPPHUEFp3SyilQU/QUoxy7VllwFNJlNSrgzRUbKjKzV3kIOVN7D8lNQgakH014v3DAN/Xq5/6sCFJN1cZnDDJnIlHRJ+nzxB2wWcuvawDaX5/F5Z5cIbQzXuO8DGq67Cn0fLf6DJNe/Yl44M9unMJbf8bjhajLFDz52wlv410GJ7BKNelhjgvsbo0PYeau6VHN5hdZkXc3yCKJpDTkBSei6SmqygNtmRgTZl1PE6kTVXSSGTzVkDMvV6DPW8N9V2UB3QaaCzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793630839; c=relaxed/relaxed;
	bh=HVagn+HE6BgGgxgbr+5XC5Y5Qcbb33m4Jb7EnpZPFUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdLA6JT8YaRtxBo4A4yNEnL9UWykUUEygW9wByjh9x8sXazQxhtyueeggoCUv7NvrGkrZ2UTAW7URGkeQMMUUkKatakd5nJ2zZ/06uAqYMXoL0nJs44IxiU/ZMCdoNVKPkn/xmxIDNYqDmI+L2G/+Pru+fcgppuUNyxpoV7C/rSA2Ll4eixS91RU7FqgSSSn34tdvEsLpf39ZtDPEJWGTCSAsoSw0LutbbjZVJcKp/iHtKr+YjlL17d7ZCtHNfrywzlYl1yqbvmrAAlvNJe7f+rQHknvKEbS7J+IBAosbCcxlXEUMT4ANZQLod4TOnBg2vVMc64QXDM5rqu3KiWvDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfP/Kahw; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZfP/Kahw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJF0f68Sgz2xN4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 01:47:14 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B079404CE;
	Mon,  2 Nov 2026 14:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE81F00A1A;
	Mon,  2 Nov 2026 14:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630833;
	bh=HVagn+HE6BgGgxgbr+5XC5Y5Qcbb33m4Jb7EnpZPFUg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZfP/KahwDm10wm2TSGrtLVkg7xDUNnpz+rBBaInyM45cZNagos2iYqnrDed5HxIBA
	 K+//mFWxDsWpOWe9Buj12+quSzkpcQzj2ngYZ9ZsEW0oSIiCRi7l1s6PLMfANxGQPz
	 ES6j9Tp68ZCoex9QLLCdMUr2RP+/gA7nMafoF8zKWkoSoj6HU61hIGfIek8HtzVsMz
	 WP7zxeoWb2ywthOOE6hEK8rHNlm6c5T599z/Oyvz7z8nNJFpq2Xxjua62S/Ez/3caV
	 aKvdxGOQzTpkPCeB1AmIzk8MgvSvtRVAT8gs8GThhJQslYhMWBFvphDQuEoGKj/fJB
	 b5NG8uh8YTrhw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 15:43:29 +0100
Subject: [PATCH RFC 38/38] selftests/proc: check that a faulting readlink()
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
Message-Id: <20261102-work-procfs-bugfixes-v1-38-59422ed3e465@kernel.org>
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org>
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

Add the symlink case:

- readlink() /proc/asound/<id> of a dummy card into a buffer backed by
  userfaultfd

- change the card's id through sysfs while the reader faults, which
  removes the symlink with snd_card_mutex and info_mutex held

- expect that to finish without waiting for the reader

Skipped without snd-dummy.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/proc/.gitignore            |   2 +
 tools/testing/selftests/proc/Makefile              |   2 +
 tools/testing/selftests/proc/config                |   3 +
 .../selftests/proc/proc-remove-slow-readlink.c     | 191 +++++++++++++++++++++
 4 files changed, 198 insertions(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 7b8133492782..e2566cc0ae07 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -22,6 +22,8 @@
 /proc-uptime-002
 /proc-pidns
 /proc-remove-slow-sysctl
+/proc-remove-slow-reader
+/proc-remove-slow-readlink
 /read
 /self
 /setns-dcache
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index bce6beca7274..6a9bdc999f54 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -33,5 +33,7 @@ TEST_GEN_PROGS += proc-fsconfig-hidepid
 TEST_GEN_PROGS += proc-sysctl-readdir-churn
 TEST_GEN_PROGS += proc-pidns
 TEST_GEN_PROGS += proc-remove-slow-sysctl
+TEST_GEN_PROGS += proc-remove-slow-reader
+TEST_GEN_PROGS += proc-remove-slow-readlink
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/config b/tools/testing/selftests/proc/config
index 3edd3c437fe4..7b0e1d9be1a2 100644
--- a/tools/testing/selftests/proc/config
+++ b/tools/testing/selftests/proc/config
@@ -2,3 +2,6 @@ CONFIG_PROC_FS=y
 CONFIG_IPV6=y
 CONFIG_TUN=y
 CONFIG_USERFAULTFD=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_DUMMY=m
diff --git a/tools/testing/selftests/proc/proc-remove-slow-readlink.c b/tools/testing/selftests/proc/proc-remove-slow-readlink.c
new file mode 100644
index 000000000000..3290225daecd
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-remove-slow-readlink.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A readlink() that faults while copying out the link must not hold up
+ * removal of the /proc symlink. Changing a sound card's id removes
+ * /proc/asound/<id> with snd_card_mutex and info_mutex held.
+ */
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/userfaultfd.h>
+#include <poll.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define CARD_ID		"Dummy"
+#define NEW_ID		"procslow"
+#define LINK_PATH	"/proc/asound/" CARD_ID
+#define TIMEOUT_MS	5000
+
+struct reader {
+	char *buf;
+	size_t len;
+	ssize_t ret;
+};
+
+struct renamer {
+	const char *id_path;
+	const char *id;
+	int done;
+	int ret;
+};
+
+static void *readlink_thread(void *arg)
+{
+	struct reader *r = arg;
+
+	r->ret = readlink(LINK_PATH, r->buf, r->len);
+	return NULL;
+}
+
+/* a new id removes the card's old /proc/asound/<id> link */
+static int set_id(const char *id_path, const char *id)
+{
+	int fd, ret;
+
+	fd = open(id_path, O_WRONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+	ret = write(fd, id, strlen(id)) < 0 ? -errno : 0;
+	close(fd);
+	return ret;
+}
+
+static void *rename_thread(void *arg)
+{
+	struct renamer *r = arg;
+	ssize_t ret;
+
+	r->ret = set_id(r->id_path, r->id);
+	ret = write(r->done, "x", 1);
+	return (void *)ret;
+}
+
+/* the sysfs id file of the card with @id */
+static int find_card(const char *id, char *id_path, size_t size)
+{
+	struct dirent *d;
+	int ret = -1;
+	DIR *dir;
+
+	dir = opendir("/sys/class/sound");
+	if (!dir)
+		return -1;
+	while (ret && (d = readdir(dir))) {
+		char cur[32];
+		FILE *f;
+
+		if (strncmp(d->d_name, "card", 4))
+			continue;
+		snprintf(id_path, size, "/sys/class/sound/%s/id", d->d_name);
+		f = fopen(id_path, "r");
+		if (!f)
+			continue;
+		if (fgets(cur, sizeof(cur), f)) {
+			cur[strcspn(cur, "\n")] = '\0';
+			if (!strcmp(cur, id))
+				ret = 0;
+		}
+		fclose(f);
+	}
+	closedir(dir);
+	return ret;
+}
+
+FIXTURE(dummy) {
+	char id_path[PATH_MAX];
+	bool renamed;
+};
+
+FIXTURE_SETUP(dummy)
+{
+	self->renamed = false;
+	if (access(LINK_PATH, F_OK) && system("modprobe -q snd-dummy"))
+		SKIP(return, "no snd-dummy");
+	if (access(LINK_PATH, F_OK))
+		SKIP(return, LINK_PATH ": %s", strerror(errno));
+	if (find_card(CARD_ID, self->id_path, sizeof(self->id_path)))
+		SKIP(return, "no sysfs id file for " CARD_ID);
+	if (access(self->id_path, W_OK))
+		SKIP(return, "%s: %s", self->id_path, strerror(errno));
+}
+
+FIXTURE_TEARDOWN(dummy)
+{
+	if (self->renamed && set_id(self->id_path, CARD_ID))
+		TH_LOG("couldn't name the card " CARD_ID " again");
+}
+
+TEST_F(dummy, remove_while_readlink_faults)
+{
+	struct uffdio_api api = { .api = UFFD_API };
+	struct uffdio_register reg = {};
+	struct uffdio_zeropage zero = {};
+	long psz = sysconf(_SC_PAGESIZE);
+	struct renamer rn = {};
+	struct reader r = {};
+	struct uffd_msg msg;
+	struct pollfd pfd;
+	pthread_t rt, nt;
+	int uffd, done[2];
+	char *buf;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0)
+		SKIP(return, "userfaultfd: %s", strerror(errno));
+	ASSERT_EQ(ioctl(uffd, UFFDIO_API, &api), 0);
+
+	buf = mmap(NULL, psz, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(buf, MAP_FAILED);
+	reg.range.start = (unsigned long)buf;
+	reg.range.len = psz;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_REGISTER, &reg), 0);
+
+	r.buf = buf;
+	r.len = psz;
+	ASSERT_EQ(pthread_create(&rt, NULL, readlink_thread, &r), 0);
+
+	/* The reader now sleeps in the copy of the link to userspace. */
+	pfd = (struct pollfd){ .fd = uffd, .events = POLLIN };
+	ASSERT_EQ(poll(&pfd, 1, TIMEOUT_MS), 1);
+	ASSERT_EQ(read(uffd, &msg, sizeof(msg)), sizeof(msg));
+	ASSERT_EQ(msg.event, UFFD_EVENT_PAGEFAULT);
+
+	/* Renaming the card removes the link that is being read. */
+	ASSERT_EQ(pipe2(done, O_CLOEXEC), 0);
+	rn.id_path = self->id_path;
+	rn.id = NEW_ID;
+	rn.done = done[1];
+	self->renamed = true;
+	ASSERT_EQ(pthread_create(&nt, NULL, rename_thread, &rn), 0);
+	pfd = (struct pollfd){ .fd = done[0], .events = POLLIN };
+	EXPECT_EQ(poll(&pfd, 1, TIMEOUT_MS), 1) {
+		TH_LOG("removing " LINK_PATH " waited for the reader");
+	}
+
+	zero.range.start = (unsigned long)buf;
+	zero.range.len = psz;
+	ASSERT_EQ(ioctl(uffd, UFFDIO_ZEROPAGE, &zero), 0);
+	ASSERT_EQ(pthread_join(rt, NULL), 0);
+	ASSERT_EQ(pthread_join(nt, NULL), 0);
+	EXPECT_EQ(rn.ret, 0);
+
+	/* The link was read before it went away. */
+	EXPECT_GT(r.ret, 0);
+	EXPECT_EQ(readlink(LINK_PATH, buf, psz), -1);
+	EXPECT_EQ(errno, ENOENT);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0



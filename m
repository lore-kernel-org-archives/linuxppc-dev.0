Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26DE6079052
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnj/UWP5
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJFcc2vl1z3cC6;
	Tue, 03 Nov 2026 02:14:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793632496;
	cv=none; b=ZCKt5UScLZaODl1pt+HUjmv6CQliJrNklQW0sPan/cpG3VU3thJQXUxXAYtfdyNoUq43PRbo8++MejqXuPZPdA2Xun8DfgfzGjdjCq6/EhBnR4MHyIjjXrEYFJJULOPX3+/ngceTa7oRr0IEcaoyBg5+4j96SRYbLvsP4ZRQWuAbTJLqyA2gk3J88UsZHQgPP1zxjHzLzG+05X3A8/QqsYY886brkjPWV4esFO57bZROyCesA3z+y0qdwt74Ck2j5nHV0199hlb0vYfXy+3m02TV2RtIyTyGWpKcZCwRg18zp93kX+5RQ7FDUilMSte4SopaYBuMOEcfP/VDqAq9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793632496; c=relaxed/relaxed;
	bh=OaqvmKOUiv1o6zEPyWdCe+OAPk6zuu4tkLm1f1iXQ1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbfS/kKHgEatuCWnUQp8GVreMgZlgEUwzll04CW5F0UKHGB1Vu0rwAYpaognOZWJTWvJA1pVOQZuPLcT5/UhvQUOusJkU9DDFmBGsJWdh7HfmMSP4tTq6iCtJaFv+KtOawM/CnWh68xjWuBxW5xn4CHbF1rzN7OJyIrx8v3GP80jq7OJm/qBnULTK05DSUB/vA4IwiVxp8w2Ie1Uwmk9QKw/PMgIiTyNsE1h1I0iOXHE0qMUzM/OpskYcjrXYGEKIbBr+KgyJMNsM32csXB1y5+Hr4/1qbHrbuscR8Equ5iWoAtBEuUKcP3eY+OCuLWRFsSkEVz34FExWnITolR82w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnj/UWP5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnj/UWP5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJFcb4DTlz3c95
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:14:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B024160615;
	Mon,  2 Nov 2026 15:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735E51F00A17;
	Mon,  2 Nov 2026 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793632493;
	bh=OaqvmKOUiv1o6zEPyWdCe+OAPk6zuu4tkLm1f1iXQ1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nnj/UWP5cYvLm3pG7sX885HlKG5y6RNj9kje2FJmMGIOHcssRpwIRraH7M9tG/AF4
	 Oax/OlHkn40y1sSQ3FV4+tJScw2y8DnO4ndr6hYZdbuPwEfFbiPmJkgLII9zcD8KMu
	 64bp+M7ftJzOpASSJUF9yjLNUphqYP39nfgEaXm3dI6F5SNWC7BVuMxW7X/XRwSzae
	 IMUDmGqLdgmTqnjniGJSmOw4/DG5TV8KvaotUEtH46boJ8PHr2fN5f3Siq5KM56Uug
	 di+bLr92g0HKUkk+IimQp+fgzb/ic0/fUxB75SDyzG6wep3dE8DwDV09xClDNrUgzq
	 RzJjFB+MfRY5Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 02 Nov 2026 16:07:21 +0100
Subject: [PATCH RFC 14/23] scsi: esas2r: let procfs copy the ioctl argument
 of the ATTONode file
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
Message-Id: <20261102-work-procfs-drivers-v1-14-a994bd4d3b1a@kernel.org>
References: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
In-Reply-To: <20261102-work-procfs-drivers-v1-0-a994bd4d3b1a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7201; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IHmX4nbITi3aS9Kd2qNCv/pj62H7BFgidfocARtwZco=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS9WG5guefJHmeZWyLeN896h99+dPHOM97Fn2fqBhw0M
 8uMCd5i21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCROClGhis3zmZtFgyeMd9k
 jmRWky4ns25kboSQpn7qiw7t/6H1/gx/JfpnaarK/A36KDWXK9hx9ueU601bLM48uWPz81WN8Uk
 FFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the work of esas2r_ioctl_handler() into esas2r_ioctl_buf() which
works on a kernel copy of struct atto_express_ioctl. The SCSI ioctl and
the character device keep copying in and out in
esas2r_ioctl_handler().

The procfs file implements ->proc_ioctl_buf() with esas2r_ioctl_buf()
and lists every command from EXPRESS_IOCTL_MIN to EXPRESS_IOCTL_MAX, so
procfs copies the struct in before it pins the entry and back out after
unpinning it. Commands outside of that range fail with -ENOTTY instead
of -ENOTSUPP now, a NULL argument with -EFAULT.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/scsi/esas2r/esas2r.h       |  2 ++
 drivers/scsi/esas2r/esas2r_ioctl.c | 58 ++++++++++++++++++++++----------------
 drivers/scsi/esas2r/esas2r_main.c  | 44 +++++++++++++++++++++++------
 3 files changed, 72 insertions(+), 32 deletions(-)

diff --git a/drivers/scsi/esas2r/esas2r.h b/drivers/scsi/esas2r/esas2r.h
index 10101f50b282..4d75b8adbb3b 100644
--- a/drivers/scsi/esas2r/esas2r.h
+++ b/drivers/scsi/esas2r/esas2r.h
@@ -964,6 +964,8 @@ struct esas2r_adapter {
 const char *esas2r_info(struct Scsi_Host *);
 int esas2r_write_params(struct esas2r_adapter *a, struct esas2r_request *rq,
 			struct esas2r_sas_nvram *data);
+int esas2r_ioctl_buf(void *hostdata, unsigned int cmd,
+		     struct atto_express_ioctl *ioctl);
 int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg);
 int esas2r_ioctl(struct scsi_device *dev, unsigned int cmd, void __user *arg);
 u8 handle_hba_ioctl(struct esas2r_adapter *a,
diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index f99318f61c93..eb39ba8263b3 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -1279,37 +1279,25 @@ int esas2r_write_params(struct esas2r_adapter *a, struct esas2r_request *rq,
 }
 
 
-/* This function only cares about ATTO-specific ioctls (atto_express_ioctl) */
-int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
+/*
+ * This function only cares about ATTO-specific ioctls (atto_express_ioctl).
+ * @ioctl is a kernel copy of what the caller passed. It goes back to the
+ * caller unless this fails.
+ */
+int esas2r_ioctl_buf(void *hostdata, unsigned int cmd,
+		     struct atto_express_ioctl *ioctl)
 {
-	struct atto_express_ioctl *ioctl = NULL;
 	struct esas2r_adapter *a;
 	struct esas2r_request *rq;
 	u16 code;
 	int err;
 
-	esas2r_log(ESAS2R_LOG_DEBG, "ioctl (%p, %x, %p)", hostdata, cmd, arg);
-
-	if ((arg == NULL)
-	    || (cmd < EXPRESS_IOCTL_MIN)
-	    || (cmd > EXPRESS_IOCTL_MAX))
-		return -ENOTSUPP;
-
-	ioctl = memdup_user(arg, sizeof(struct atto_express_ioctl));
-	if (IS_ERR(ioctl)) {
-		esas2r_log(ESAS2R_LOG_WARN,
-			   "ioctl_handler access_ok failed for cmd %u, address %p",
-			   cmd, arg);
-		return PTR_ERR(ioctl);
-	}
-
 	/* verify the signature */
 
 	if (memcmp(ioctl->header.signature,
 		   EXPRESS_IOCTL_SIGNATURE,
 		   EXPRESS_IOCTL_SIGNATURE_SIZE) != 0) {
 		esas2r_log(ESAS2R_LOG_WARN, "invalid signature");
-		kfree(ioctl);
 
 		return -ENOTSUPP;
 	}
@@ -1350,7 +1338,6 @@ int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
 			esas2r_adapters[ioctl->header.channel] == NULL) {
 			ioctl->header.return_code = IOCTL_BAD_CHANNEL;
 			esas2r_log(ESAS2R_LOG_WARN, "bad channel value");
-			kfree(ioctl);
 
 			return -ENOTSUPP;
 		}
@@ -1403,7 +1390,6 @@ int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
 
 		rq = esas2r_alloc_request(a);
 		if (rq == NULL) {
-			kfree(ioctl);
 			esas2r_log(ESAS2R_LOG_WARN,
 			   "could not allocate an internal request");
 			return -ENOMEM;
@@ -1515,19 +1501,43 @@ ioctl_done:
 
 	}
 
+	return 0;
+}
+
+int esas2r_ioctl_handler(void *hostdata, unsigned int cmd, void __user *arg)
+{
+	struct atto_express_ioctl *ioctl __free(kfree) = NULL;
+	int err;
+
+	esas2r_log(ESAS2R_LOG_DEBG, "ioctl (%p, %x, %p)", hostdata, cmd, arg);
+
+	if ((arg == NULL)
+	    || (cmd < EXPRESS_IOCTL_MIN)
+	    || (cmd > EXPRESS_IOCTL_MAX))
+		return -ENOTSUPP;
+
+	ioctl = memdup_user(arg, sizeof(struct atto_express_ioctl));
+	if (IS_ERR(ioctl)) {
+		esas2r_log(ESAS2R_LOG_WARN,
+			   "ioctl_handler access_ok failed for cmd %u, address %p",
+			   cmd, arg);
+		return PTR_ERR(ioctl);
+	}
+
+	err = esas2r_ioctl_buf(hostdata, cmd, ioctl);
+	if (err)
+		return err;
+
 	/* Always copy the buffer back, if only to pick up the status */
 	err = copy_to_user(arg, ioctl, sizeof(struct atto_express_ioctl));
 	if (err != 0) {
 		esas2r_log(ESAS2R_LOG_WARN,
 			   "ioctl_handler copy_to_user didn't copy everything (err %d, cmd %u)",
 			   err, cmd);
-		kfree(ioctl);
 
 		return -EFAULT;
 	}
 
-	kfree(ioctl);
-
 	return 0;
 }
 
diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index 75a70ae9441b..720be2a0907d 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -613,14 +613,6 @@ static const struct file_operations esas2r_proc_fops = {
 	.unlocked_ioctl = esas2r_proc_ioctl,
 };
 
-static const struct proc_ops esas2r_proc_ops = {
-	.proc_lseek		= default_llseek,
-	.proc_ioctl		= esas2r_proc_ioctl,
-#ifdef CONFIG_COMPAT
-	.proc_compat_ioctl	= compat_ptr_ioctl,
-#endif
-};
-
 static struct Scsi_Host *esas2r_proc_host;
 static int esas2r_proc_major;
 
@@ -630,6 +622,42 @@ long esas2r_proc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
 				    cmd, (void __user *)arg);
 }
 
+static long esas2r_proc_ioctl_buf(struct file *fp, unsigned int cmd, void *arg)
+{
+	return esas2r_ioctl_buf(esas2r_proc_host->hostdata, cmd, arg);
+}
+
+#define ESAS2R_PROC_IOCTL(_cmd)						\
+	PROC_IOCTL_ARG(_cmd, sizeof(struct atto_express_ioctl),		\
+		       sizeof(struct atto_express_ioctl))
+
+/* esas2r_ioctl_buf() takes every command from EXPRESS_IOCTL_MIN to _MAX. */
+static const struct proc_ioctl_arg esas2r_proc_ioctl_args[] = {
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_RW_FIRMWARE),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_READ_PARAMS),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_WRITE_PARAMS),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_FC_API),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_GET_CHANNELS),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_CHAN_INFO),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_DEFAULT_PARAMS),
+	ESAS2R_PROC_IOCTL(EXPRESS_ADDR_MEMORY),
+	ESAS2R_PROC_IOCTL(EXPRESS_RW_MEMORY),
+	ESAS2R_PROC_IOCTL(EXPRESS_TSDK_DUMP),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_SMP),
+	ESAS2R_PROC_IOCTL(EXPRESS_CSMI),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_HBA),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_VDA),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_GET_ID),
+	ESAS2R_PROC_IOCTL(EXPRESS_IOCTL_GET_MOD_INFO),
+};
+
+static const struct proc_ops esas2r_proc_ops = {
+	.proc_lseek		= default_llseek,
+	.proc_ioctl_buf		= esas2r_proc_ioctl_buf,
+	.proc_ioctl_args	= esas2r_proc_ioctl_args,
+	.proc_nr_ioctl_args	= ARRAY_SIZE(esas2r_proc_ioctl_args),
+};
+
 static void __exit esas2r_exit(void)
 {
 	esas2r_log(ESAS2R_LOG_INFO, "%s called", __func__);

-- 
2.53.0



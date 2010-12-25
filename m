Return-Path: <akinobu.mita@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FECEB70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Dec 2010 17:03:42 +1100 (EST)
Received: by mail-iw0-f179.google.com with SMTP id 42so8264311iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Dec 2010 22:03:42 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: use simple_read_from_buffer
Date: Sat, 25 Dec 2010 15:03:59 +0900
Message-Id: <1293257039-2580-4-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <n>
References: <n>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Akinobu Mita <akinobu.mita@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify read file operation for /proc/powerpc/rtas/* interface
by using simple_read_from_buffer.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/rtas_flash.c |   53 ++++---------------------------------
 1 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 2b442e6..bf5f5ce 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -256,31 +256,16 @@ static ssize_t rtas_flash_read(struct file *file, char __user *buf,
 	struct proc_dir_entry *dp = PDE(file->f_path.dentry->d_inode);
 	struct rtas_update_flash_t *uf;
 	char msg[RTAS_MSG_MAXLEN];
-	int msglen;
 
-	uf = (struct rtas_update_flash_t *) dp->data;
+	uf = dp->data;
 
 	if (!strcmp(dp->name, FIRMWARE_FLASH_NAME)) {
 		get_flash_status_msg(uf->status, msg);
 	} else {	   /* FIRMWARE_UPDATE_NAME */
 		sprintf(msg, "%d\n", uf->status);
 	}
-	msglen = strlen(msg);
-	if (msglen > count)
-		msglen = count;
-
-	if (ppos && *ppos != 0)
-		return 0;	/* be cheap */
-
-	if (!access_ok(VERIFY_WRITE, buf, msglen))
-		return -EINVAL;
 
-	if (copy_to_user(buf, msg, msglen))
-		return -EFAULT;
-
-	if (ppos)
-		*ppos = msglen;
-	return msglen;
+	return simple_read_from_buffer(buf, count, ppos, msg, strlen(msg));
 }
 
 /* constructor for flash_block_cache */
@@ -394,26 +379,13 @@ static ssize_t manage_flash_read(struct file *file, char __user *buf,
 	char msg[RTAS_MSG_MAXLEN];
 	int msglen;
 
-	args_buf = (struct rtas_manage_flash_t *) dp->data;
+	args_buf = dp->data;
 	if (args_buf == NULL)
 		return 0;
 
 	msglen = sprintf(msg, "%d\n", args_buf->status);
-	if (msglen > count)
-		msglen = count;
 
-	if (ppos && *ppos != 0)
-		return 0;	/* be cheap */
-
-	if (!access_ok(VERIFY_WRITE, buf, msglen))
-		return -EINVAL;
-
-	if (copy_to_user(buf, msg, msglen))
-		return -EFAULT;
-
-	if (ppos)
-		*ppos = msglen;
-	return msglen;
+	return simple_read_from_buffer(buf, count, ppos, msg, msglen);
 }
 
 static ssize_t manage_flash_write(struct file *file, const char __user *buf,
@@ -495,24 +467,11 @@ static ssize_t validate_flash_read(struct file *file, char __user *buf,
 	char msg[RTAS_MSG_MAXLEN];
 	int msglen;
 
-	args_buf = (struct rtas_validate_flash_t *) dp->data;
+	args_buf = dp->data;
 
-	if (ppos && *ppos != 0)
-		return 0;	/* be cheap */
-	
 	msglen = get_validate_flash_msg(args_buf, msg);
-	if (msglen > count)
-		msglen = count;
-
-	if (!access_ok(VERIFY_WRITE, buf, msglen))
-		return -EINVAL;
-
-	if (copy_to_user(buf, msg, msglen))
-		return -EFAULT;
 
-	if (ppos)
-		*ppos = msglen;
-	return msglen;
+	return simple_read_from_buffer(buf, count, ppos, msg, msglen);
 }
 
 static ssize_t validate_flash_write(struct file *file, const char __user *buf,
-- 
1.7.3.4

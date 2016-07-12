Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpPjL1p1FzDqwV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:37:42 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id h14so805843pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 18:37:42 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 3/3] kexec: extend kexec_file_load system call
Date: Tue, 12 Jul 2016 10:42:01 +0900
Message-Id: <20160712014201.11456-4-takahiro.akashi@linaro.org>
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device tree blob must be passed to a second kernel on DTB-capable
archs, like powerpc and arm64, but the current kernel interface
lacks this support.

This patch extends kexec_file_load system call by adding an extra
argument to this syscall so that an arbitrary number of file descriptors
can be handed out from user space to the kernel.

	long sys_kexec_file_load(int kernel_fd, int initrd_fd,
				 unsigned long cmdline_len,
				 const char __user *cmdline_ptr,
				 unsigned long flags,
				 const struct kexec_fdset __user *ufdset);

If KEXEC_FILE_EXTRA_FDS is set to the "flags" argument, the "ufdset"
argument points to the following struct buffer:

	struct kexec_fdset {
		int nr_fds;
		struct kexec_file_fd fds[0];
	}

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/fs.h         |  1 +
 include/linux/kexec.h      |  2 +-
 include/linux/syscalls.h   |  4 +++-
 include/uapi/linux/kexec.h | 17 ++++++++++++++
 kernel/kexec_file.c        | 57 ++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 72 insertions(+), 9 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28814..6dd6fdf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2634,6 +2634,7 @@ extern int do_pipe_flags(int *, int);
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
+	id(KEXEC_DTB, kexec-dtb)		\
 	id(POLICY, security-policy)		\
 	id(MAX_ID, )
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 554c848..5f11bd5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -277,7 +277,7 @@ extern int kexec_load_disabled;
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_EXTRA_FDS)
 
 #define VMCOREINFO_BYTES           (4096)
 #define VMCOREINFO_NOTE_NAME       "VMCOREINFO"
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d022390..fc072bd 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -66,6 +66,7 @@ struct perf_event_attr;
 struct file_handle;
 struct sigaltstack;
 union bpf_attr;
+struct kexec_fdset;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -321,7 +322,8 @@ asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
 asmlinkage long sys_kexec_file_load(int kernel_fd, int initrd_fd,
 				    unsigned long cmdline_len,
 				    const char __user *cmdline_ptr,
-				    unsigned long flags);
+				    unsigned long flags,
+				    const struct kexec_fdset __user *ufdset);
 
 asmlinkage long sys_exit(int error_code);
 asmlinkage long sys_exit_group(int error_code);
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index aae5ebf..adf53b6 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -23,6 +23,23 @@
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
+#define KEXEC_FILE_EXTRA_FDS	0x00000008
+
+enum kexec_file_type {
+	KEXEC_FILE_TYPE_KERNEL,
+	KEXEC_FILE_TYPE_INITRAMFS,
+	KEXEC_FILE_TYPE_DTB,
+};
+
+struct kexec_file_fd {
+	enum kexec_file_type type;
+	int fd;
+};
+
+struct kexec_fdset {
+	int nr_fds;
+	struct kexec_file_fd fds[0];
+};
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 7278329..451b4b0 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -137,11 +137,14 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 static int
 kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
-			     unsigned long cmdline_len, unsigned flags)
+			     unsigned long cmdline_len, unsigned long flags,
+			     const struct kexec_fdset __user *ufdset)
 {
-	int ret = 0;
+	int ret = 0, nr_fds, i;
 	void *ldata;
 	loff_t size;
+	struct kexec_fdset *fdset = NULL;
+	size_t fdset_size;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
 				       &size, INT_MAX, READING_KEXEC_IMAGE);
@@ -174,6 +177,42 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		image->initrd_buf_len = size;
 	}
 
+	if (flags & KEXEC_FILE_EXTRA_FDS) {
+		ret = copy_from_user(&nr_fds, ufdset, sizeof(int));
+		if (ret) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		fdset_size = sizeof(struct kexec_fdset)
+				+ nr_fds * sizeof(struct kexec_file_fd);
+		fdset = kmalloc(fdset_size, GFP_KERNEL);
+		if (!fdset) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = copy_from_user(fdset, ufdset, fdset_size);
+		if (ret) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		for (i = 0; i < fdset->nr_fds; i++) {
+			if (fdset->fds[i].type == KEXEC_FILE_TYPE_DTB) {
+				ret = kernel_read_file_from_fd(fdset->fds[i].fd,
+						&image->dtb_buf, &size, INT_MAX,
+						READING_KEXEC_DTB);
+				if (ret)
+					goto out;
+				image->dtb_buf_len = size;
+			} else {
+				pr_debug("unknown file type %d failed.\n",
+						fdset->fds[i].type);
+			}
+		}
+	}
+
 	if (cmdline_len) {
 		image->cmdline_buf = kzalloc(cmdline_len, GFP_KERNEL);
 		if (!image->cmdline_buf) {
@@ -208,6 +247,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	image->image_loader_data = ldata;
 out:
 	/* In case of error, free up all allocated memory in this function */
+	kfree(fdset);
+
 	if (ret)
 		kimage_file_post_load_cleanup(image);
 	return ret;
@@ -216,7 +257,8 @@ out:
 static int
 kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 		       int initrd_fd, const char __user *cmdline_ptr,
-		       unsigned long cmdline_len, unsigned long flags)
+		       unsigned long cmdline_len, unsigned long flags,
+		       const struct kexec_fdset __user *ufdset)
 {
 	int ret;
 	struct kimage *image;
@@ -235,7 +277,8 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	}
 
 	ret = kimage_file_prepare_segments(image, kernel_fd, initrd_fd,
-					   cmdline_ptr, cmdline_len, flags);
+					   cmdline_ptr, cmdline_len, flags,
+					   ufdset);
 	if (ret)
 		goto out_free_image;
 
@@ -270,9 +313,9 @@ out_free_image:
 	return ret;
 }
 
-SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
+SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
-		unsigned long, flags)
+		unsigned long, flags, const struct kexec_fdset __user *, ufdset)
 {
 	int ret = 0, i;
 	struct kimage **dest_image, *image;
@@ -309,7 +352,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		kimage_free(xchg(&kexec_crash_image, NULL));
 
 	ret = kimage_file_alloc_init(&image, kernel_fd, initrd_fd, cmdline_ptr,
-				     cmdline_len, flags);
+				     cmdline_len, flags, ufdset);
 	if (ret)
 		goto out;
 
-- 
2.9.0

Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzbNX1bQCzDrFf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:24:59 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6R0OIej057204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 20:24:57 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24e1bssje1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 20:24:57 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 21:24:55 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9B30F3520068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 20:24:33 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6R0Oqv715204660
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 21:24:52 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6R0OpTN012119
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 21:24:52 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Michael Ellerman <michael@ellerman.id.au>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 3/3] kexec: extend kexec_file_load system call
Date: Tue, 26 Jul 2016 21:24:29 -0300
In-Reply-To: <20160712014201.11456-4-takahiro.akashi@linaro.org>
References: <20160712014201.11456-4-takahiro.akashi@linaro.org>
Message-Id: <1469579069-28472-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---

Notes:
    This is a new version of the last patch in this series which adds
    a function where each architecture can verify if the DTB is safe
    to load:
    
    int __weak arch_kexec_verify_buffer(enum kexec_file_type type,
                                        const void *buf,
                                        unsigned long size)
    {
            return -EINVAL;
    }
    
    I will then provide an implementation in my powerpc patch series
    which checks that the DTB only contains nodes and properties from a
    whitelist. arch_kexec_kernel_image_load will copy these properties
    to the device tree blob the kernel was booted with (and perform
    other changes such as setting /chosen/bootargs, of course).
    
    I made the following additional changes:
    - renamed KEXEC_FILE_TYPE_DTB to KEXEC_FILE_TYPE_PARTIAL_DTB,
    - limited max number of fds to KEXEC_SEGMENT_MAX,
    - changed to use fixed size buffer for fdset instead of allocating it,
    - changed to return -EINVAL if an unknown file type is found in fdset.

 include/linux/fs.h         |  1 +
 include/linux/kexec.h      |  7 ++--
 include/linux/syscalls.h   |  4 ++-
 include/uapi/linux/kexec.h | 22 ++++++++++++
 kernel/kexec_file.c        | 83 ++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd288148a6b1..5e0ee342b457 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2634,6 +2634,7 @@ extern int do_pipe_flags(int *, int);
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
+	id(KEXEC_PARTIAL_DTB, kexec-partial-dtb)		\
 	id(POLICY, security-policy)		\
 	id(MAX_ID, )
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 554c8480dba3..b7eec336e935 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -146,7 +146,10 @@ struct kexec_file_ops {
 	kexec_verify_sig_t *verify_sig;
 #endif
 };
-#endif
+
+int __weak arch_kexec_verify_buffer(enum kexec_file_type type, const void *buf,
+				    unsigned long size);
+#endif /* CONFIG_KEXEC_FILE */
 
 struct kimage {
 	kimage_entry_t head;
@@ -277,7 +280,7 @@ extern int kexec_load_disabled;
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_EXTRA_FDS)
 
 #define VMCOREINFO_BYTES           (4096)
 #define VMCOREINFO_NOTE_NAME       "VMCOREINFO"
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index d02239022bd0..fc072bdb74e3 100644
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
index 99048e501b88..32e0cefe2000 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -23,6 +23,28 @@
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
+#define KEXEC_FILE_EXTRA_FDS	0x00000008
+
+enum kexec_file_type {
+	KEXEC_FILE_TYPE_KERNEL,
+	KEXEC_FILE_TYPE_INITRAMFS,
+
+	/*
+	 * Device Tree Blob containing just the nodes and properties that
+	 * the kexec_file_load caller wants to add or modify.
+	 */
+	KEXEC_FILE_TYPE_PARTIAL_DTB,
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
index 113af2f219b9..d6803dd884e2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,9 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
+#define MAX_FDSET_SIZE	(sizeof(struct kexec_fdset) + \
+				KEXEC_SEGMENT_MAX * sizeof(struct kexec_file_fd))
+
 /*
  * Declare these symbols weak so that if architecture provides a purgatory,
  * these will be overridden.
@@ -116,6 +119,22 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+/**
+ * arch_kexec_verify_buffer() - check that the given kexec file is valid
+ *
+ * Device trees in particular can contain properties that may make the kernel
+ * execute code that it wasn't supposed to (e.g., use the wrong entry point
+ * when calling firmware functions). Because of this, the kernel needs to
+ * verify that it is safe to use the device tree blob passed from userspace.
+ *
+ * Return: 0 on success, negative errno on error.
+ */
+int __weak arch_kexec_verify_buffer(enum kexec_file_type type, const void *buf,
+				    unsigned long size)
+{
+	return -EINVAL;
+}
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -123,7 +142,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 static int
 kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
-			     unsigned long cmdline_len, unsigned flags)
+			     unsigned long cmdline_len, unsigned long flags,
+			     const struct kexec_fdset __user *ufdset)
 {
 	int ret = 0;
 	void *ldata;
@@ -160,6 +180,55 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 		image->initrd_buf_len = size;
 	}
 
+	if (flags & KEXEC_FILE_EXTRA_FDS) {
+		int nr_fds, i;
+		size_t fdset_size;
+		char fdset_buf[MAX_FDSET_SIZE];
+		struct kexec_fdset *fdset = (struct kexec_fdset *) fdset_buf;
+
+		ret = copy_from_user(&nr_fds, ufdset, sizeof(int));
+		if (ret) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (nr_fds > KEXEC_SEGMENT_MAX) {
+			ret = -E2BIG;
+			goto out;
+		}
+
+		fdset_size = sizeof(struct kexec_fdset)
+				+ nr_fds * sizeof(struct kexec_file_fd);
+
+		ret = copy_from_user(fdset, ufdset, fdset_size);
+		if (ret) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		for (i = 0; i < fdset->nr_fds; i++) {
+			if (fdset->fds[i].type == KEXEC_FILE_TYPE_PARTIAL_DTB) {
+				ret = kernel_read_file_from_fd(fdset->fds[i].fd,
+						&image->dtb_buf, &size, INT_MAX,
+						READING_KEXEC_PARTIAL_DTB);
+				if (ret)
+					goto out;
+				image->dtb_buf_len = size;
+
+				ret = arch_kexec_verify_buffer(KEXEC_FILE_TYPE_PARTIAL_DTB,
+							       image->dtb_buf,
+							       image->dtb_buf_len);
+				if (ret)
+					goto out;
+			} else {
+				pr_debug("unknown file type %d failed.\n",
+						fdset->fds[i].type);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
 	if (cmdline_len) {
 		image->cmdline_buf = kzalloc(cmdline_len, GFP_KERNEL);
 		if (!image->cmdline_buf) {
@@ -202,7 +271,8 @@ out:
 static int
 kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 		       int initrd_fd, const char __user *cmdline_ptr,
-		       unsigned long cmdline_len, unsigned long flags)
+		       unsigned long cmdline_len, unsigned long flags,
+		       const struct kexec_fdset __user *ufdset)
 {
 	int ret;
 	struct kimage *image;
@@ -221,7 +291,8 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	}
 
 	ret = kimage_file_prepare_segments(image, kernel_fd, initrd_fd,
-					   cmdline_ptr, cmdline_len, flags);
+					   cmdline_ptr, cmdline_len, flags,
+					   ufdset);
 	if (ret)
 		goto out_free_image;
 
@@ -256,9 +327,9 @@ out_free_image:
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
@@ -295,7 +366,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 		kimage_free(xchg(&kexec_crash_image, NULL));
 
 	ret = kimage_file_alloc_init(&image, kernel_fd, initrd_fd, cmdline_ptr,
-				     cmdline_len, flags);
+				     cmdline_len, flags, ufdset);
 	if (ret)
 		goto out;
 
-- 
1.9.1

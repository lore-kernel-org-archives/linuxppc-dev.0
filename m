Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9d6D5qJrzDr1k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 18:17:24 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id hh10so1128202pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 01:17:24 -0700 (PDT)
Date: Fri, 12 Aug 2016 18:17:39 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@redhat.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 David Laight <David.Laight@ACULAB.COM>,
 Eric Biederman <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] kexec: extend kexec_file_load system call
Message-ID: <20160812081739.GB22218@350D>
Reply-To: bsingharora@gmail.com
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-3-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470956638-3589-3-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2016 at 08:03:58PM -0300, Thiago Jung Bauermann wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> Device tree blob must be passed to a second kernel on DTB-capable
> archs, like powerpc and arm64, but the current kernel interface
> lacks this support.
> 
> This patch extends kexec_file_load system call by adding an extra
> argument to this syscall so that an arbitrary number of file descriptors
> can be handed out from user space to the kernel.
> 
> 	long sys_kexec_file_load(int kernel_fd, int initrd_fd,
> 				 unsigned long cmdline_len,
> 				 const char __user *cmdline_ptr,
> 				 unsigned long flags,
> 				 const struct kexec_fdset __user *ufdset);
> 
> If KEXEC_FILE_EXTRA_FDS is set to the "flags" argument, the "ufdset"
> argument points to the following struct buffer:
> 
> 	struct kexec_fdset {
> 		int nr_fds;
> 		struct kexec_file_fd fds[0];
> 	}
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  include/linux/fs.h         |  1 +
>  include/linux/kexec.h      |  7 ++--
>  include/linux/syscalls.h   |  4 ++-
>  include/uapi/linux/kexec.h | 22 ++++++++++++
>  kernel/kexec_file.c        | 83 ++++++++++++++++++++++++++++++++++++++++++----
>  5 files changed, 108 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3523bf62f328..847d9c31f428 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2656,6 +2656,7 @@ extern int do_pipe_flags(int *, int);
>  	id(MODULE, kernel-module)		\
>  	id(KEXEC_IMAGE, kexec-image)		\
>  	id(KEXEC_INITRAMFS, kexec-initramfs)	\
> +	id(KEXEC_PARTIAL_DTB, kexec-partial-dtb)		\

The backspace is over-indented?

>  	id(POLICY, security-policy)		\
>  	id(MAX_ID, )
>  
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 4f85d284ed0b..29202935055d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -148,7 +148,10 @@ struct kexec_file_ops {
>  	kexec_verify_sig_t *verify_sig;
>  #endif
>  };
> -#endif
> +
> +int __weak arch_kexec_verify_buffer(enum kexec_file_type type, const void *buf,
> +				    unsigned long size);
> +#endif /* CONFIG_KEXEC_FILE */
>  
>  struct kimage {
>  	kimage_entry_t head;
> @@ -280,7 +283,7 @@ extern int kexec_load_disabled;
>  
>  /* List of defined/legal kexec file flags */
>  #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
> -				 KEXEC_FILE_NO_INITRAMFS)
> +				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_EXTRA_FDS)
>  
>  #define VMCOREINFO_BYTES           (4096)
>  #define VMCOREINFO_NOTE_NAME       "VMCOREINFO"
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index d02239022bd0..fc072bdb74e3 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -66,6 +66,7 @@ struct perf_event_attr;
>  struct file_handle;
>  struct sigaltstack;
>  union bpf_attr;
> +struct kexec_fdset;
>  
>  #include <linux/types.h>
>  #include <linux/aio_abi.h>
> @@ -321,7 +322,8 @@ asmlinkage long sys_kexec_load(unsigned long entry, unsigned long nr_segments,
>  asmlinkage long sys_kexec_file_load(int kernel_fd, int initrd_fd,
>  				    unsigned long cmdline_len,
>  				    const char __user *cmdline_ptr,
> -				    unsigned long flags);
> +				    unsigned long flags,
> +				    const struct kexec_fdset __user *ufdset);
>  
>  asmlinkage long sys_exit(int error_code);
>  asmlinkage long sys_exit_group(int error_code);
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index aae5ebf2022b..6279be79efba 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -23,6 +23,28 @@
>  #define KEXEC_FILE_UNLOAD	0x00000001
>  #define KEXEC_FILE_ON_CRASH	0x00000002
>  #define KEXEC_FILE_NO_INITRAMFS	0x00000004
> +#define KEXEC_FILE_EXTRA_FDS	0x00000008
> +
> +enum kexec_file_type {
> +	KEXEC_FILE_TYPE_KERNEL,
> +	KEXEC_FILE_TYPE_INITRAMFS,
> +
> +	/*
> +	 * Device Tree Blob containing just the nodes and properties that
> +	 * the kexec_file_load caller wants to add or modify.
> +	 */
> +	KEXEC_FILE_TYPE_PARTIAL_DTB,
> +};
> +
> +struct kexec_file_fd {
> +	enum kexec_file_type type;
> +	int fd;
> +};
> +
> +struct kexec_fdset {
> +	int nr_fds;
> +	struct kexec_file_fd fds[0];
> +};
>  
>  /* These values match the ELF architecture values.
>   * Unless there is a good reason that should continue to be the case.
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 113af2f219b9..d6803dd884e2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,6 +25,9 @@
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
>  
> +#define MAX_FDSET_SIZE	(sizeof(struct kexec_fdset) + \
> +				KEXEC_SEGMENT_MAX * sizeof(struct kexec_file_fd))
> +
>  /*
>   * Declare these symbols weak so that if architecture provides a purgatory,
>   * these will be overridden.
> @@ -116,6 +119,22 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	image->image_loader_data = NULL;
>  }
>  
> +/**
> + * arch_kexec_verify_buffer() - check that the given kexec file is valid
> + *
> + * Device trees in particular can contain properties that may make the kernel
> + * execute code that it wasn't supposed to (e.g., use the wrong entry point
> + * when calling firmware functions). Because of this, the kernel needs to
> + * verify that it is safe to use the device tree blob passed from userspace.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +int __weak arch_kexec_verify_buffer(enum kexec_file_type type, const void *buf,
> +				    unsigned long size)
> +{
> +	return -EINVAL;
> +}
> +
>  /*
>   * In file mode list of segments is prepared by kernel. Copy relevant
>   * data from user space, do error checking, prepare segment list
> @@ -123,7 +142,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  static int
>  kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			     const char __user *cmdline_ptr,
> -			     unsigned long cmdline_len, unsigned flags)
> +			     unsigned long cmdline_len, unsigned long flags,
> +			     const struct kexec_fdset __user *ufdset)
>  {
>  	int ret = 0;
>  	void *ldata;
> @@ -160,6 +180,55 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		image->initrd_buf_len = size;
>  	}
>  
> +	if (flags & KEXEC_FILE_EXTRA_FDS) {
> +		int nr_fds, i;
> +		size_t fdset_size;
> +		char fdset_buf[MAX_FDSET_SIZE];

Do we really want this on the stack?  I presume the size is not large

> +		struct kexec_fdset *fdset = (struct kexec_fdset *) fdset_buf;
> +
> +		ret = copy_from_user(&nr_fds, ufdset, sizeof(int));
> +		if (ret) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		if (nr_fds > KEXEC_SEGMENT_MAX) {

We need an nr_fds < 0 check as well

> +			ret = -E2BIG;
> +			goto out;
> +		}
> +
> +		fdset_size = sizeof(struct kexec_fdset)
> +				+ nr_fds * sizeof(struct kexec_file_fd);
> +
> +		ret = copy_from_user(fdset, ufdset, fdset_size);

Can the user change nr_fds between the two copy_from_users, ideally not,
but we should validate it.

> +		if (ret) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < fdset->nr_fds; i++) {
> +			if (fdset->fds[i].type == KEXEC_FILE_TYPE_PARTIAL_DTB) {
> +				ret = kernel_read_file_from_fd(fdset->fds[i].fd,
> +						&image->dtb_buf, &size, INT_MAX,
> +						READING_KEXEC_PARTIAL_DTB);
> +				if (ret)
> +					goto out;
> +				image->dtb_buf_len = size;
> +
> +				ret = arch_kexec_verify_buffer(KEXEC_FILE_TYPE_PARTIAL_DTB,
> +							       image->dtb_buf,
> +							       image->dtb_buf_len);
> +				if (ret)
> +					goto out;
> +			} else {
> +				pr_debug("unknown file type %d failed.\n",
> +						fdset->fds[i].type);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +		}
> +	}
> +
>  	if (cmdline_len) {
>  		image->cmdline_buf = kzalloc(cmdline_len, GFP_KERNEL);
>  		if (!image->cmdline_buf) {
> @@ -202,7 +271,8 @@ out:
>  static int
>  kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
>  		       int initrd_fd, const char __user *cmdline_ptr,
> -		       unsigned long cmdline_len, unsigned long flags)
> +		       unsigned long cmdline_len, unsigned long flags,
> +		       const struct kexec_fdset __user *ufdset)
>  {
>  	int ret;
>  	struct kimage *image;
> @@ -221,7 +291,8 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
>  	}
>  
>  	ret = kimage_file_prepare_segments(image, kernel_fd, initrd_fd,
> -					   cmdline_ptr, cmdline_len, flags);
> +					   cmdline_ptr, cmdline_len, flags,
> +					   ufdset);
>  	if (ret)
>  		goto out_free_image;
>  
> @@ -256,9 +327,9 @@ out_free_image:
>  	return ret;
>  }
>  
> -SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> +SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
> -		unsigned long, flags)
> +		unsigned long, flags, const struct kexec_fdset __user *, ufdset)
>  {
>  	int ret = 0, i;
>  	struct kimage **dest_image, *image;
> @@ -295,7 +366,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  		kimage_free(xchg(&kexec_crash_image, NULL));
>  
>  	ret = kimage_file_alloc_init(&image, kernel_fd, initrd_fd, cmdline_ptr,
> -				     cmdline_len, flags);
> +				     cmdline_len, flags, ufdset);
>  	if (ret)
>  		goto out;
>


Balbir Singh.  

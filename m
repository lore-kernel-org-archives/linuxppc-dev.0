Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlS3D0G4fzDqxp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 16:12:54 +1000 (AEST)
Date: Thu, 7 Jul 2016 14:12:45 +0800
From: Dave Young <dyoung@redhat.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
 vgoyal@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] arm64: kexec_file_load support
Message-ID: <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
References: <20160701051111.GL20774@linaro.org> <3300473.zhbeG65qgA@hactar>
 <20160704065814.GO20774@linaro.org>
 <20160705012556.GC8190@dhcp-128-65.nay.redhat.com>
 <20160705080355.GQ20774@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160705080355.GQ20774@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/16 at 05:03pm, AKASHI Takahiro wrote:
> Hi Dave,
> 
> On Tue, Jul 05, 2016 at 09:25:56AM +0800, Dave Young wrote:
> > On 07/04/16 at 03:58pm, AKASHI Takahiro wrote:
> > > Hi,
> > > 
> > > On Fri, Jul 01, 2016 at 12:46:31PM -0300, Thiago Jung Bauermann wrote:
> > > > Am Freitag, 01 Juli 2016, 14:11:12 schrieb AKASHI Takahiro:
> > > > > I'm not sure whether there is any demand for kexec_file_load
> > > > > support on arm64, but anyhow I'm working on this and now
> > > > > my early prototype code does work fine.
> > > > 
> > > > It is necessary if you want to support loading only signed kernels, and also 
> > > > if you want IMA to measure the kernel in its event log.
> > > > 
> > > > > There is, however, one essential issue:
> > > > > While arm64 kernel requires a device tree blob to be set up
> > > > > correctly at boot time, the current system call API doesn't
> > > > > have this parameter.
> > > > >     int kexec_file_load(int kernel_fd, int initrd_fd,
> > > > >                         unsigned long cmdline_len, const char
> > > > > *cmdline_ptr, unsigned long flags);
> > > > > 
> > > > > Should we invent a new system call, like kexec_file_load2,
> > > > > and, if so, what kind of interface would be desired?
> > > > 
> > > > I'm facing the same issue on powerpc. What I'm doing is taking the device 
> > > > tree that was used to boot the current kernel and modifying it as necessary 
> > > > to pass it to the next kernel.
> > > 
> > > That is exactly what I do.
> > > 
> > > > I agree that it would be better if we could have a system call where a 
> > > > custom device tree could be passed. One suggestion is:
> > > 
> > > For powerpc, you might be able to use dtbImage instead of Image
> > > without changing the kernel interfaces.
> > > > 
> > > > kexec_file_load2(int fds[], int fd_types[], int nr_fds,
> > > > 		 unsigned long cmdline_len, const char *cmdline_ptr,
> > > > 		unsigned long flags);
> > > 
> > > You don't want to simply add one more argument, i.e. dtb_fd, don't you.
> > > 
> > > I prefer a slightly-simpler interface:
> > >         struct kexec_file_fd {
> > >                 enum kexec_file_type;
> > >                 int fd;
> > >         }
> > > 
> > >         int kexec_file_load2(struct kexec_file_fd[], int nr_fds, int flags);
> > > 
> > > Or if you want to keep the compatibility with the existing system call,
> > > 
> > >         int kexec_file_load(int kernel_fd, int initrd_fd,
> > >                         unsigned long cmdline_len, const char *cmdline_ptr,
> > >                         unsigned long flags,
> > >                         int struct kexec_file_fd[], int nr_fds);
> > > 
> > > Here SYSCALL_DEFINE7() have to be defined, and I'm not sure that we will not
> > > have a problem in adding a system call with more than 6 arguments.
> > > 
> > > > Where fds is an array with nr_fds file descriptors and fd_types is an array 
> > > > specifying what each fd in fds is. So for example, if fds[i] is the kernel, 
> > > > then fd_types[i] would have the value KEXEC_FILE_KERNEL_FD. If fds[i] is the 
> > > > device tree blob, fd_types[i], would have the value KEXEC_FILE_DTB and so 
> > > > on. That way, the syscall can be extended for an arbitrary number and types 
> > > > of segments that have to be loaded, just like kexec_load.
> > > > 
> > > > Another option is to have a struct:
> > > > 
> > > > kexec_file_load2(struct kexec_file_params *params, unsigned long params_sz);
> > > 
> > > Wow, we can add any number of new parameters with this interface.
> > > 
> > > Thanks,
> > > -Takahiro AKASHI
> > > 
> > > > Where:
> > > > 
> > > > struct kexec_file_params {
> > > > 	int version;	/* allows struct to be extended in the future */
> > > > 	int fds[];
> > > > 	int fd_types[];
> > > > 	int nr_fds;
> > > > 	unsigned long cmdline_len;
> > > > 	const char *cmdline_ptr;
> > > > 	unsigned long flags;
> > > > };
> > > > 
> > > > This is even more flexible.
> > 
> > I would like to vote for this one, and use kexec_file_fd fds[] in the struct 
> 
> If we take this approach, we'd better take "flags" out of struct,
> and my preference would be:
> 
>         enum kexec_file_type {
>                 KEXEC_FILE_TYPE_KERNEL;
>                 KEXEC_FILE_TYPE_INITRD;
>                 KEXEC_FILE_TYPE_DTB;
>         }
> 
>         struct kexec_file_fd {
>                 enum kexec_file_type;
>                 int fd;
>         }
> 
>         sturct kexec_file_params {
>                 int version;
>                 unsigned char *cmdline;
>                 unsigned long cmdline_len;
>                 int nr_fds;
>                 struct kexec_file_fd fds[0];
>         }
> 
>         int kexec_file_load2(int kernel_fd, unsigned long flags,
>                                 sturct kexec_file_params extra);
> 
> So we don't have to retrieve extra if KEXEC_FILE_UNLOAD
> (or kernel_fd < 0?),
> and only once retrieve extra if extra != NULL && nr_fds == 0.

If so maybe change a bit from your precious mentioned 7 args proposal like
below?

struct kexec_file_fd {
	enum kexec_file_type;
	int fd;
}

struct kexec_fdset {
	int nr_fd;
	struct kexec_file_fd fd[0];
}

int kexec_file_load(int kernel_fd, int initrd_fd,
		    unsigned long cmdline_len, const char *cmdline_ptr,
		    unsigned long flags, struct kexec_fdset *extra_fds);

Thanks
Dave

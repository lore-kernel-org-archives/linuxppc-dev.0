Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkGZ30r8HzDqsQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 18:02:03 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id i123so67945188pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 01:02:03 -0700 (PDT)
Date: Tue, 5 Jul 2016 17:07:23 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, dyoung@redhat.com,
 bhe@redhat.com, vgoyal@redhat.com, will.deacon@arm.com,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] arm64: kexec_file_load support
Message-ID: <20160705080722.GR20774@linaro.org>
References: <20160701051111.GL20774@linaro.org> <3300473.zhbeG65qgA@hactar>
 <20160704065814.GO20774@linaro.org> <5766907.oiVi8ABPsz@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
In-Reply-To: <5766907.oiVi8ABPsz@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 04, 2016 at 07:50:19PM -0300, Thiago Jung Bauermann wrote:
> Hello,
> 
> Am Montag, 04 Juli 2016, 15:58:15 schrieb AKASHI Takahiro:
> > On Fri, Jul 01, 2016 at 12:46:31PM -0300, Thiago Jung Bauermann wrote:
> > > I agree that it would be better if we could have a system call where a
> > 
> > > custom device tree could be passed. One suggestion is:
> > For powerpc, you might be able to use dtbImage instead of Image
> > without changing the kernel interfaces.
> 
> That works for custom kernels, but for signed kernels from a distro, I 
> believe that's not an option.
> 
> > > kexec_file_load2(int fds[], int fd_types[], int nr_fds,
> > > 
> > > 		 unsigned long cmdline_len, const char *cmdline_ptr,
> > > 		
> > > 		unsigned long flags);
> > 
> > You don't want to simply add one more argument, i.e. dtb_fd, don't you.
> 
> I'm just trying to avoid having to add another argument later if we find out 
> someone is loading another segment that we didn't know about. :-)
> 
> The older kexec_load system call allows passing an arbitrary number of 
> segments (sort of, currently capped at 16) to the kernel, so my suggestions 
> preserve that feature.
> 
> If people think that adding another argument for dtb_fd is enough, I won't 
> mind.

That is the question :)
As far as I look though existing arch code, there will be no extra
parameters (segments) required other than dtb.

Thanks,
-Takahiro AKASHI

> > I prefer a slightly-simpler interface:
> >         struct kexec_file_fd {
> >                 enum kexec_file_type;
> >                 int fd;
> >         }
> > 
> >         int kexec_file_load2(struct kexec_file_fd[], int nr_fds, int
> > flags);
> 
> I like this one.
> 
> > Or if you want to keep the compatibility with the existing system call,
> > 
> >         int kexec_file_load(int kernel_fd, int initrd_fd,
> >                         unsigned long cmdline_len, const char
> > *cmdline_ptr, unsigned long flags,
> >                         int struct kexec_file_fd[], int nr_fds);
> > 
> > Here SYSCALL_DEFINE7() have to be defined, and I'm not sure that we will
> > not have a problem in adding a system call with more than 6 arguments.
> 
> That's very clever. We can do what you suggest above or even just add dtb_fd 
> with SYSCALL_DEFINE6. Either option would be good.
> 
> > > Where fds is an array with nr_fds file descriptors and fd_types is an
> > > array specifying what each fd in fds is. So for example, if fds[i] is
> > > the kernel, then fd_types[i] would have the value KEXEC_FILE_KERNEL_FD.
> > > If fds[i] is the device tree blob, fd_types[i], would have the value
> > > KEXEC_FILE_DTB and so on. That way, the syscall can be extended for an
> > > arbitrary number and types of segments that have to be loaded, just
> > > like kexec_load.
> > > 
> > > Another option is to have a struct:
> > > 
> > > kexec_file_load2(struct kexec_file_params *params, unsigned long
> > > params_sz);
> > Wow, we can add any number of new parameters with this interface.
> 
> Yeah, maybe it's a bit too much.
> 
> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 

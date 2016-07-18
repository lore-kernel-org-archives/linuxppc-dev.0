Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rt6gH5nyVzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 12:33:47 +1000 (AEST)
Date: Mon, 18 Jul 2016 10:33:39 +0800
From: Dave Young <dyoung@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com,
 bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 3/3] kexec: extend kexec_file_load system call
Message-ID: <20160718023339.GC6310@dhcp-128-65.nay.redhat.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715130955.GC23514@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/16 at 09:09am, Vivek Goyal wrote:
> On Tue, Jul 12, 2016 at 10:42:01AM +0900, AKASHI Takahiro wrote:
> 
> [..]
> > -SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > +SYSCALL_DEFINE6(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >  		unsigned long, cmdline_len, const char __user *, cmdline_ptr,
> > -		unsigned long, flags)
> > +		unsigned long, flags, const struct kexec_fdset __user *, ufdset)
> 
> Can one add more parameters to existing syscall. Can it break existing
> programs with new kernel? I was of the impression that one can't do that.
> But may be I am missing something.

It will not break existing programs because we can use the new param only
when the new flag is set.

But we have a case below, but I think it is fine?
Originally kexec_file_load with the new flags will fail, but now it will
succeed and will access the new argument.

Thanks
Dave

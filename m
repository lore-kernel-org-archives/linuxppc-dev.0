Return-Path: <dyoung@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnqqK6vTVzDqpY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 13:10:53 +1000 (AEST)
Date: Mon, 11 Jul 2016 11:10:44 +0800
From: Dave Young <dyoung@redhat.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org,
 ebiederm@xmission.com, bhe@redhat.com, vgoyal@redhat.com,
 will.deacon@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] arm64: kexec_file_load support
Message-ID: <20160711031044.GA2850@dhcp-128-65.nay.redhat.com>
References: <20160701051111.GL20774@linaro.org>
 <20160705080355.GQ20774@linaro.org>
 <20160707061245.GA18459@dhcp-128-65.nay.redhat.com>
 <11139482.zLvCKVycQr@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11139482.zLvCKVycQr@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/16 at 11:48am, Thiago Jung Bauermann wrote:
> Am Donnerstag, 07 Juli 2016, 14:12:45 schrieb Dave Young:
> > If so maybe change a bit from your precious mentioned 7 args proposal like
> > below?
> > 
> > struct kexec_file_fd {
> > 	enum kexec_file_type;
> > 	int fd;
> > }
> > 
> > struct kexec_fdset {
> > 	int nr_fd;
> > 	struct kexec_file_fd fd[0];
> > }
> > 
> > int kexec_file_load(int kernel_fd, int initrd_fd,
> > 		    unsigned long cmdline_len, const char *cmdline_ptr,
> > 		    unsigned long flags, struct kexec_fdset *extra_fds);
> 
> 
> Is there a way for the kernel to distinguish whether the process passed 5 or 
> 6 arguments? How can it know whether extra_fds is a valid argument or just 
> garbage? I think we have to define a new flag KEXEC_FILE_EXTRA_FDS so that 
> the process can signal that it is using the new interface.

Agreed, a new flag is needed.

Thanks
Dave

Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rh1462hhQzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 01:46:44 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61Fi0wt136494
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 11:46:41 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23wajf7ce7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 11:46:41 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 12:46:38 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 53E6D3520070
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 11:46:17 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u61FkYxm13762948
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 12:46:34 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u61FkYNX032141
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 12:46:34 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com,
 dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
 will.deacon@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] arm64: kexec_file_load support
Date: Fri, 01 Jul 2016 12:46:31 -0300
In-Reply-To: <20160701051111.GL20774@linaro.org>
References: <20160701051111.GL20774@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <3300473.zhbeG65qgA@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Freitag, 01 Juli 2016, 14:11:12 schrieb AKASHI Takahiro:
> I'm not sure whether there is any demand for kexec_file_load
> support on arm64, but anyhow I'm working on this and now
> my early prototype code does work fine.

It is necessary if you want to support loading only signed kernels, and also 
if you want IMA to measure the kernel in its event log.

> There is, however, one essential issue:
> While arm64 kernel requires a device tree blob to be set up
> correctly at boot time, the current system call API doesn't
> have this parameter.
>     int kexec_file_load(int kernel_fd, int initrd_fd,
>                         unsigned long cmdline_len, const char
> *cmdline_ptr, unsigned long flags);
> 
> Should we invent a new system call, like kexec_file_load2,
> and, if so, what kind of interface would be desired?

I'm facing the same issue on powerpc. What I'm doing is taking the device 
tree that was used to boot the current kernel and modifying it as necessary 
to pass it to the next kernel.

I agree that it would be better if we could have a system call where a 
custom device tree could be passed. One suggestion is:


kexec_file_load2(int fds[], int fd_types[], int nr_fds,
		 unsigned long cmdline_len, const char *cmdline_ptr,
		unsigned long flags);

Where fds is an array with nr_fds file descriptors and fd_types is an array 
specifying what each fd in fds is. So for example, if fds[i] is the kernel, 
then fd_types[i] would have the value KEXEC_FILE_KERNEL_FD. If fds[i] is the 
device tree blob, fd_types[i], would have the value KEXEC_FILE_DTB and so 
on. That way, the syscall can be extended for an arbitrary number and types 
of segments that have to be loaded, just like kexec_load.

Another option is to have a struct:

kexec_file_load2(struct kexec_file_params *params, unsigned long params_sz);

Where:

struct kexec_file_params {
	int version;	/* allows struct to be extended in the future */
	int fds[];
	int fd_types[];
	int nr_fds;
	unsigned long cmdline_len;
	const char *cmdline_ptr;
	unsigned long flags;
};

This is even more flexible.

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center

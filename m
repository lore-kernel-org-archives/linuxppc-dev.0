Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzjM851B3zDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 11:55:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
In-Reply-To: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
Date: Fri, 07 Apr 2017 11:54:57 +1000
Message-ID: <878tnd7zim.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:

> In case of fadump, capture (fadump) kernel boots like a normal kernel.
> While this has its advantages, the capture kernel would initialize all
> the components like normal kernel, which may not necessarily be needed
> for a typical dump capture kernel. So, fadump capture kernel ends up
> needing more memory than a typical (read kdump) capture kernel to boot.
>
> This can be overcome by introducing parameters like fadump_nr_cpus=1,
> similar to nr_cpus=1 parameter, applicable only when fadump is active.
> But this approach needs introduction of special parameters applicable
> only when fadump is active (capture kernel), for every parameter that
> reduces memory/resource consumption.
>
> A better approach would be to pass extra parameters to fadump capture
> kernel. As firmware leaves the memory contents intact from the time of
> crash till the new kernel is booted up, parameters to append to capture
> kernel can be saved in real memory region and retrieved later when the
> capture kernel is in its early boot process for appending to command
> line parameters.
>
> This patch introduces a new node /sys/kernel/fadump_cmdline_append to
> specify the parameters to pass to fadump capture kernel, saves them in
> real memory region and appends these parameters to capture kernel early
> in its boot process.

As we discussed on IRC I don't really like this.

It's clever, (ab)using the fact that the first kernel's memory is left
intact. But it's also a bit gross :)

It also has a few real problems, like hard coding 128MB as the handover
location. You may not have memory there, or it may be reserved.


My preference would be that the fadump kernel "just works". If it's
using too much memory then the fadump kernel should do whatever it needs
to use less memory, eg. shrinking nr_cpu_ids etc.

Do we actually know *why* the fadump kernel is running out of memory?
Obviously large numbers of CPUs is one of the main drivers (lots of
stacks required). But other than that what is causing the memory
pressure? I would like some data on that before we proceed.


If we *must* have a way to pass command line arguments to the fadump
kernel then I think we should just use a command line argument that
specifies them.

eg: fadump_append=nr_cpus=1,use_less_memory,some_other_obscure_parameter=100


cheers

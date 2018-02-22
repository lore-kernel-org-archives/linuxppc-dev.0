Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTgd3l8XzF0fZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:34:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI/AER: Add a null check before eeh_ops->notify_resume
 callback.
In-Reply-To: <20180222115803.21738-1-vaibhav@linux.vnet.ibm.com>
References: <20180222115803.21738-1-vaibhav@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 09:34:52 +1100
Message-ID: <87sh9spsab.fsf@concordia.ellerman.id.au>
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

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:
> This patch puts a NULL check before branching to the address pointed
> to by eeh_ops->notify_resume in eeh_report_resume(). The callback
> is used to notify the arch EEH code that a pci device is back
> online.
>
> For PPC64 presently, only an implementation for pseries platform is
> available and not for powernv. Hence without this patch EEH recovery
> on all non-virtualized hosts is causing a kernel panic when
> CONFIG_PCI_IOV is set. The panic is usually is of the form:
>
> EEH: Notify device driver to resume
> Unable to handle kernel paging request for instruction fetch
> Faulting instruction address: 0x00000000
> Oops: Kernel access of bad area, sig: 11 [#1]
> <snip>
> LR eeh_report_resume+0x218/0x220
> Call Trace:
>  eeh_report_resume+0x1f0/0x220 (unreliable)
>  eeh_pe_dev_traverse+0x98/0x170
>  eeh_handle_normal_event+0x3f4/0x650
>  eeh_handle_event+0x188/0x380
>  eeh_event_handler+0x208/0x210
>  kthread+0x168/0x1b0
>  ret_from_kernel_thread+0x5c/0xb4
>
> Cc: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Fixes: 856e1eb9bdd4("PCI/AER: Add uevents in AER and EEH error/resume")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

10 out of 10 for the change log!

But yeah this is already fixed in my fixes branch, thanks anyway.

cheers

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhRDf3YyPzDqZ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 21:26:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Cc: Brian King <brking@linux.vnet.ibm.com>,
 "dougmill\@us.ibm.com" <dougmill@us.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
In-Reply-To: <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 21:22:12 +1000
Message-ID: <87h8wq1uvv.fsf@concordia.ellerman.id.au>
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

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> On 08/28/2017 02:56 AM, Michael Ellerman wrote:
>> Some Power9 boxes will have this adapter installed, so add it to the
>> defconfig so we can boot on those machines without an initrd.
>
> Michael, not sure if this affects Petitboot (I know it has its own
> default config files), but in the past we had some issues with this
> driver and it's nice to have the possibility to blacklist it.

Why we were black listing it?

> What is the rationale for this change? I mean, how being able to boot
> without initrd is interesting here? Sorry if it's silly question!

It is a silly question! :)

When you boot as many kernels as me it's preferable to be able to build
a kernel completely remote from the box, throw the kernel on a tftp
server and have the machine boot from that kernel all the way to
userspace.

That requires not using an initrd, and therefore having all the drivers
built-in that are needed to get to the boot disk.

(Yeah it is "possible" to build an initrd remotely but it's a pain).

And the one P9 box I have here uses that driver for its root disk, so I
do really want it to be =y.

cheers

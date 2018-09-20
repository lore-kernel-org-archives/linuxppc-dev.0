Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Sh0d4XzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:08 +1000 (AEST)
In-Reply-To: <153693396241.22873.15797641996113409474.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Dave Young <dyoung@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>
Subject: Re: powerpc/fadump: re-register firmware-assisted dump if already
 registered
Message-Id: <42G3Sf1sg4z9sCS@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-09-14 at 14:06:02 UTC, Hari Bathini wrote:
> Firmware-Assisted Dump (FADump) needs to be registered again after any
> memory hot add/remove operation to update the crash memory ranges. But
> currently, the kernel returns '-EEXIST' if we try to register without
> uregistering it first. This could expose the system to racing issues
> while unregistering and registering FADump from userspace during udev
> events. Spare the userspace of this and let it be taken care of in the
> kernel space for a simpler interface.
> 
> Since this change, running 'echo 1 > /sys/kernel/fadump_registered'
> would result in re-regisering (unregistering and registering) FADump,
> if it was already registered.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Acked-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0823c68b054bca9dc321adea829af5

cheers

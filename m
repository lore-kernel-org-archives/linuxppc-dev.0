Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 762701A0118
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 16:09:24 +1100 (AEDT)
Message-ID: <1417496963.31336.6.camel@concordia>
Subject: Re: Right location in sysfs for dlpar file
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 16:09:23 +1100
In-Reply-To: <547C8C0F.5070701@linux.vnet.ibm.com>
References: <1417057941.5089.81.camel@kernel.crashing.org>
 <547C8C0F.5070701@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Greg KH <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-01 at 09:41 -0600, Nathan Fontenot wrote:
> On 11/26/2014 09:12 PM, Benjamin Herrenschmidt wrote:
> > Hi Greg,
> > 
> > So Nathan is working on a patch series to cleanup and improve our
> > "DLPAR" infrastructure which is basically our hotplug mechanism when
> > running under the PowerVM (aka pHyp) and KVM hypervisors.
> 
> The cleanup to the dlpar infrastructure will move the entire operation
> of hotplugging a device to the kernel instead of doing it partially in
> userspace and partially in the kernel as is currently done.
> 
...
> 
> For PowerVM systems we need this sysfs file to deliver what is
> essentially a binary blob (specifically a rtas error log) to the
> kernel.

Those two statements don't really agree with each other. ie. "move the entire
operation .. to the kernel", but then we need a sysfs file so userspace can
deliver us a blob?

I think what you mean is that all the actual logic will move into the kernel,
and the only thing userspace will do (on PowerVM) is write the blog to kick off
the process.

On PowerKVM the entire process will be handled in the kernel (after some
additional patches to hook up the rtas event to the hotplug).


As ugly as it is, we already have /proc/rtas, which includes a bunch of files,
including error_log, which is where you can *read* the RTAS error logs from.

So maybe we just extend that, either a new file, or just by making error_log
writable?

It'd be nice to drop all that rtas gunk and move to something cleaner in /sys,
but I don't think we can realistically do that any time soon anyway?

cheers

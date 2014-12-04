Return-Path: <gregkh@linuxfoundation.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D0921A0A44
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 15:32:29 +1100 (AEDT)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2F6B11400D5
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 15:32:27 +1100 (AEDT)
Date: Wed, 3 Dec 2014 20:31:02 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: Right location in sysfs for dlpar file
Message-ID: <20141204043102.GA21724@kroah.com>
References: <1417057941.5089.81.camel@kernel.crashing.org>
 <547C8C0F.5070701@linux.vnet.ibm.com>
 <20141202042626.GC9271@kroah.com>
 <547FCFEF.8090001@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547FCFEF.8090001@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 03, 2014 at 09:07:27PM -0600, Nathan Fontenot wrote:
> On 12/01/2014 10:26 PM, Greg KH wrote:
> > On Mon, Dec 01, 2014 at 09:41:03AM -0600, Nathan Fontenot wrote:
> >> On 11/26/2014 09:12 PM, Benjamin Herrenschmidt wrote:
> >>> Hi Greg,
> >>>
> >>> So Nathan is working on a patch series to cleanup and improve our
> >>> "DLPAR" infrastructure which is basically our hotplug mechanism when
> >>> running under the PowerVM (aka pHyp) and KVM hypervisors.
> >>
> >> The cleanup to the dlpar infrastructure will move the entire operation
> >> of hotplugging a device to the kernel instead of doing it partially in
> >> userspace and partially in the kernel as is currently done.
> >>
> >>>
> >>> I'll let Nathan give you a bit more details/background and answer
> >>> subsequent question you might have as this is really his area of
> >>> expertise.
> >>>
> >>> To cut a long story short, we need a sysfs file that allows our
> >>> userspace tools to notify the kernel of hotplug events coming from
> >>> the management console (which talks to userspace daemons using a
> >>> proprietary protocol) to "initiate" the hotplug operations, which in
> >>> turn get dispatched internally in the kernel to the right subsystem
> >>> (memory, cpu, pci, ...) based on the resource type.
> >>>
> >>> On IRC, Greg suggested /sys/firmware and /sys/hypervisor which both
> >>> look like a reasonable option to me, probably better than dlpar...
> >>
> >> For PowerVM systems we need this sysfs file to deliver what is
> >> essentially a binary blob (specifically a rtas error log) to the
> >> kernel. The current patch set is creating /sys/kernel/dlpar. As Ben
> >> mentioned we would like your input on what would be the proper place
> >> to create this file.
> > 
> > And what is the kernel supposed to do with such a binary blob?  Parse
> > it?  Or pass it to something else?
> 
> The kernel will parse it and perform the requested hotplug operation.

Oh I was hoping you would not say that :(

Seriously?  Parsing binary blobs from userspace?  Don't do that, you
know better.

greg k-h

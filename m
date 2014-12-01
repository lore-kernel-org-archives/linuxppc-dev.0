Return-Path: <nfont@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 247C21A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 02:41:18 +1100 (AEDT)
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1275C14017F
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 02:41:16 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 1 Dec 2014 10:41:14 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9131438C805E
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2014 10:41:07 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB1Ff61e23462094
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Dec 2014 15:41:06 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB1Ff5aj018834
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Dec 2014 10:41:06 -0500
Message-ID: <547C8C0F.5070701@linux.vnet.ibm.com>
Date: Mon, 01 Dec 2014 09:41:03 -0600
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Right location in sysfs for dlpar file
References: <1417057941.5089.81.camel@kernel.crashing.org>
In-Reply-To: <1417057941.5089.81.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/26/2014 09:12 PM, Benjamin Herrenschmidt wrote:
> Hi Greg,
> 
> So Nathan is working on a patch series to cleanup and improve our
> "DLPAR" infrastructure which is basically our hotplug mechanism when
> running under the PowerVM (aka pHyp) and KVM hypervisors.

The cleanup to the dlpar infrastructure will move the entire operation
of hotplugging a device to the kernel instead of doing it partially in
userspace and partially in the kernel as is currently done.

> 
> I'll let Nathan give you a bit more details/background and answer
> subsequent question you might have as this is really his area of
> expertise.
> 
> To cut a long story short, we need a sysfs file that allows our
> userspace tools to notify the kernel of hotplug events coming from
> the management console (which talks to userspace daemons using a
> proprietary protocol) to "initiate" the hotplug operations, which in
> turn get dispatched internally in the kernel to the right subsystem
> (memory, cpu, pci, ...) based on the resource type.
> 
> On IRC, Greg suggested /sys/firmware and /sys/hypervisor which both
> look like a reasonable option to me, probably better than dlpar...

For PowerVM systems we need this sysfs file to deliver what is
essentially a binary blob (specifically a rtas error log) to the
kernel. The current patch set is creating /sys/kernel/dlpar. As Ben
mentioned we would like your input on what would be the proper place
to create this file.

-Nathan

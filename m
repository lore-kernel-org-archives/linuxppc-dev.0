Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15F4C1A0556
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 07:08:28 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A4201400A0
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2014 07:08:25 +1100 (AEDT)
Message-ID: <1418069293.4827.41.camel@kernel.crashing.org>
Subject: Re: Right location in sysfs for dlpar file
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <gregkh@linuxfoundation.org>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2014 07:08:13 +1100
In-Reply-To: <5485C1F9.9000401@linux.vnet.ibm.com>
References: <1417057941.5089.81.camel@kernel.crashing.org>
 <547C8C0F.5070701@linux.vnet.ibm.com> <20141202042626.GC9271@kroah.com>
 <547FCFEF.8090001@linux.vnet.ibm.com> <20141204043102.GA21724@kroah.com>
 <5485C1F9.9000401@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-12-08 at 09:21 -0600, Nathan Fontenot wrote:
> > Oh I was hoping you would not say that :(
> 
> Heh! hint taken. I won't cc you.
> 
> > 
> > Seriously?  Parsing binary blobs from userspace?  Don't do that, you
> > know better.
> 
> Yes, not ideal. One thing to note here is that the code to parse these
> binary blobs already exists in the kernel for powerpc. The binary blob
> we need to pass in is the same format as rtas error logs that we can be
> handed by firmware on powerpc systems.

We should clarify that it's a small blob, it's an error log entry as defined
by our firmware interfaces. We already obtain these from the FW and parse them
(it's really just mapping the right structure based on the type in the header)
under various circumstances.

What happens is on KVM, we used that existing path to signal the kernel of an
hotplug event. On PowerVM (aka pHyp), we want to use the same kernel code path
by passing an equivalent event to the kernel.

Nathan, if Greg still strongly objects, we could have the sysfs interface be
something like a simple action + resource ID string, we don't *need* it to
be encapsulated in an error log, we would just pipe into the same infrastructure
in the kernel but at a slightly lower level...

Ben.

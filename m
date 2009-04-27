Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id EF86CDDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 05:48:11 +1000 (EST)
Message-ID: <49F60BF8.8040404@ovro.caltech.edu>
Date: Mon, 27 Apr 2009 12:48:08 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>	<49F608B7.9080409@ovro.caltech.edu>
	<49F60A3A.4060402@freescale.com>
In-Reply-To: <49F60A3A.4060402@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



>> Would you like some sort of summary of this info for a commit
>> message?
> 
> That's probably overkill.  I just want a sentence or two that tells
> someone looking at the code casually that the behavior of reading PCI
> memory might be different than what they expect.

Ok, will-do.

>> Would you like us to check any other transaction/register combos?
> 
> Yes, could you try this on non-PCI memory?

We've been using it to DMA between the x86 host main memory and
the MPC8349EA boards (PCI targets). The reason we changed to
Read Multiple was that it had a dramatic improvement in
efficiency through bridges. However, the x86 host memory
is prefetchable, so is consistent with the use of Read Multiple.

Can you give me an example of non-PCI memory that would be
non-prefetchable that you'd like us to try? We can see if our
host CPUs have an area like that ... we just need to know
what device to look for first :)

Cheers,
Dave

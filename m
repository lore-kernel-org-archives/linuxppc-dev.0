Return-Path: <brking@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 393C7DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 09:14:20 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l11MEE4i013285
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 17:14:14 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l11MEEs3294404
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 17:14:14 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l11MED1F002345
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 17:14:13 -0500
Message-ID: <45C26633.2010804@linux.vnet.ibm.com>
Date: Thu, 01 Feb 2007 16:14:11 -0600
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/3] pci: New PCI-E reset API
References: <11703510202911-patch-mail.ibm.com>
	<20070201191235.GQ7585@parisc-linux.org>
In-Reply-To: <20070201191235.GQ7585@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-pci@atrey.karlin.mff.cuni.cz
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matthew Wilcox wrote:
> On Thu, Feb 01, 2007 at 11:30:21AM -0600, Brian King wrote:
>> Adds a new API which can be used to issue various types
>> of PCI-E reset, including PCI-E warm reset and PCI-E hot reset.
>> This is needed for an ipr PCI-E adapter which does not properly
>> implement BIST. Running BIST on this adapter results in PCI-E
>> errors. The only reliable reset mechanism that exists on this
>> hardware is PCI Fundamental reset (warm reset). Since driving
>> this type of reset is architecture unique, this provides the
>> necessary hooks for architectures to add this support.
> 
> A few points ...
> 
>  - When doing a warm reset, you reset the entire device not just the
>    function (== pci_dev) that gets passed in.  How happy are drivers for
>    the other functions going to be about this?

I guess I don't see how a warm reset could be issued to a single function
of a PCI device. I would argue that for a multi-function device, you would
have to use function level reset. 


>  - You've missed the requirement:
> 
> "To allow components to perform internal initialization, system software
> must wait for at least 100 ms from the end of a Conventional Reset of one
> or more devices before it is permitted to issue Configuration Requests
> to those devices."
> 
>    To fix this, we need to call pci_block_user_cfg_access() before
>    calling the pcibios function, then msleep(100) after calling it, then
>    call pci_unblock_user_cfg_access().

What I've done is to provide a very low-level API that can be used to
accomplish this. In my implementation, the ipr driver is the one doing
all the required delays and calling pci_block_user_cfg_access, since it
already was doing that in order to run BIST on the adapter.

>  - There's no attempt to support either cold or function-level reset in
>    this patch.

Correct. I had no requirement to implement this. It can always be added
if there is a need. A function level reset can be performed by simply
writing a bit in config space, so *technically* we wouldn't need an
API to do that for us, but it could certainly be added here.

> I suspect the Right Way of handling hot/warm/cold reset is going to be
> some kind of integration with error handling.  This driver understands
> about slots being different from functions, and has the ability to
> notify drivers of other functions that a reset is happening.

Perhaps. It would require a way for the adapter device driver to
indicate what type of reset(s) will work for a particular pci device.
It would also require a method for a device driver to invoke a reset,
which does not currently exist today. I think it would be the first
case of the device driver invoking pci error recovery, so I'm not sure
how difficult that would be to do with the current code.

I actually thought this API might be used by PCI error recovery
code, since it may need to perform these sorts of functions.

CC'ing Linas Vepstas since he wrote the powerpc pci recovery code.

Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

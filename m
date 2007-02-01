Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5A70ADDDEF
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 06:36:06 +1100 (EST)
Date: Thu, 1 Feb 2007 12:12:35 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] pci: New PCI-E reset API
Message-ID: <20070201191235.GQ7585@parisc-linux.org>
References: <11703510202911-patch-mail.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11703510202911-patch-mail.ibm.com>
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 01, 2007 at 11:30:21AM -0600, Brian King wrote:
> Adds a new API which can be used to issue various types
> of PCI-E reset, including PCI-E warm reset and PCI-E hot reset.
> This is needed for an ipr PCI-E adapter which does not properly
> implement BIST. Running BIST on this adapter results in PCI-E
> errors. The only reliable reset mechanism that exists on this
> hardware is PCI Fundamental reset (warm reset). Since driving
> this type of reset is architecture unique, this provides the
> necessary hooks for architectures to add this support.

A few points ...

 - When doing a warm reset, you reset the entire device not just the
   function (== pci_dev) that gets passed in.  How happy are drivers for
   the other functions going to be about this?

 - You've missed the requirement:

"To allow components to perform internal initialization, system software
must wait for at least 100 ms from the end of a Conventional Reset of one
or more devices before it is permitted to issue Configuration Requests
to those devices."

   To fix this, we need to call pci_block_user_cfg_access() before
   calling the pcibios function, then msleep(100) after calling it, then
   call pci_unblock_user_cfg_access().

 - There's no attempt to support either cold or function-level reset in
   this patch.

I suspect the Right Way of handling hot/warm/cold reset is going to be
some kind of integration with error handling.  This driver understands
about slots being different from functions, and has the ability to
notify drivers of other functions that a reset is happening.

To a certain extent, what's going on with IPR here *is* an error
condition, it's just that we can recover from it with a warm reset
rather than a hot reset.

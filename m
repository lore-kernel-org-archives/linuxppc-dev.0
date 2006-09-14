Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A5A6867B56
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 10:47:39 +1000 (EST)
Message-ID: <4508A606.90505@ovro.caltech.edu>
Date: Wed, 13 Sep 2006 17:44:54 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Stephen Yee <stonepine@126.com>
Subject: Re: 11-16-05 2.6.14 on AMCC Yosemite boar d(PCI-IDE card boot error)
References: <45077EA4.000010.14180@bj126app9.126.com>
	<450865ED.4080000@bmrtech.com>
In-Reply-To: <450865ED.4080000@bmrtech.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Stephen Yee wrote:
> Hi All,
> 
> I have tested and debuged the ELDK's kernel 2.6.14 with PDC20269 PCI-IDE
> card, the system paniced when it run the 'ide_pci_setup_ports' funcation
> [drivers/ide/setup_pci.c], the attached files included the entry log
> messages, and ksysoops messages when the kernel paniced, and my kernel
> configuration file and BDI2000 configuration file.
> 
> would you please give some advice about this issue?

When I was testing this board, I received a machine check
in earlier kernels due to;

  The kernel header for the Yosemite board has an error that
  incorrectly sets the base address for PCI I/O space. The define
  for the 36-bit PCI I/O base address in the file
  arch/ppc/platforms/4xx/yosemite.h needs to be set to

#define YOSEMITE_PCI_IO_BASE 0x00000000e8000000ULL

Check your kernel source, perhaps that is the issue.

Stephan at Denx found and fixed this a while back (over 6 months
ago). So when in doubt, use the latest-and-greatest kernel, eg.,
use git and access the Denx repo.

Dave

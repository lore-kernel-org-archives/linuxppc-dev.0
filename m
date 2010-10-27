Return-Path: <olaf@aepfle.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6847B70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 21:25:54 +1100 (EST)
Date: Wed, 27 Oct 2010 12:13:51 +0200
From: Olaf Hering <olaf@aepfle.de>
To: pacman@kosh.dhis.org
Subject: Re: Pegasos OHCI bug (was Re: PROBLEM: memory corrupting bug,
	bisected to 6dda9d55)
Message-ID: <20101027101351.GA28218@aepfle.de>
References: <1287608215.2198.23.camel@pasglop>
	<20101027085738.1837.qmail@kosh.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20101027085738.1837.qmail@kosh.dhis.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 27, pacman@kosh.dhis.org wrote:

> |1. How do I locate all usb nodes in the device tree?
> |
> |2. How do I know if a particular usb node is OHCI?

In the installed system, run 'lspci | grep -i usb', this gives the pci
bus numbers.  Then run 'find /sys -name devspec', and look or the bus
numbers from the lspci output.  Each devspec file contains the firmware
path.  The ohci node may have subdirectories. Run 'words' in each of
them at the firmware prompt. Perhaps there is one to shutdown the
controller?

I just noticed older firmware did not have a node for ohci, newer ones
my have a /pci@80000000/usb@5 node.

Good luck.

Olaf

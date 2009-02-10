Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 6E382DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 03:22:52 +1100 (EST)
Date: Tue, 10 Feb 2009 08:22:49 -0800
From: Ira Snyder <iws@ovro.caltech.edu>
To: Scott Coulter <scott.coulter@cyclone.com>
Subject: Re: correct way for handling PCIe in endpoint mode
Message-ID: <20090210162249.GB9592@ovro.caltech.edu>
References: <43EB80E07C42E1408726E4905FB96B04C074D9@CYBORG3.cyclone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43EB80E07C42E1408726E4905FB96B04C074D9@CYBORG3.cyclone.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 10, 2009 at 07:39:47AM -0500, Scott Coulter wrote:
> 
> Hi all,
> 
> Maybe a silly questions, but what is the suggested way for handling a
> processor which has a PCIe interface, but the interface is not
> configured to be the root complex (endpoint only)?
> 
> Should the PCIe interface appear in the dts?  If so, with what
> parameters?
> 
> Should the kernel config contain CONFIG_PCI, etc. ?
> 

I'm in a similar situation, except I'm using PCI instead of PCIe. I've
tried both removing the PCI interface from the dts, and disabling
CONFIG_PCI. Both work fine.

You probably don't want to leave the PCI interface in the dts and also
leave CONFIG_PCI enabled. I ran into some really strange issues this
way... (Linux ran through the quirks and tried to re-initialize a
network card, even though the driver was disabled, etc.)

I think the suggested way is to remove the PCI interface from the dts,
that way you can potentially share a kernel between similar boards with
and without PCI root interfaces, just by changing the dts.

Ira

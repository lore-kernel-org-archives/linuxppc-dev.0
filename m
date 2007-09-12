Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8A2ADDE3A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 00:48:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l8CDehi1003413
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 09:40:43 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8CEkEqu273398
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 08:48:23 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8CEjbxC018689
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 08:45:37 -0600
Date: Wed, 12 Sep 2007 09:45:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <ml@stefan-roese.de>
Subject: Re: [POWERPC] PCI Bug fix for MRM failure in PPC 440EPx
Message-ID: <20070912094536.013bf903@weaponx.rchland.ibm.com>
In-Reply-To: <200708301033.28423.ml@stefan-roese.de>
References: <200708301033.28423.ml@stefan-roese.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Aug 2007 10:33:28 +0200
Stefan Roese <ml@stefan-roese.de> wrote:

> Problem Description and Fix : Memory Read Multiples(MRM) do not work
> correctly on PPC 440EPX based systems. A PCI driver determines whether
> MRMs are supported by reading the PCI cache line size register. If this
> value is zero then MRMs are not supported. However some PCI drivers
> write to the PCI cache line size register on initialization. This
> results in MRMs being sent to system memory on 440EPX based systems.
> Since MRMs do not work correctly in 440EPX based systems this may cause
> system hang. This patch solves this problem by modifying the PPC
> platform specific PCI configuration register write function, by forcing
> any value written to PCI_CACHE_LINE_SIZE register to be 0. This fix was
> tested on different PCI cards : i.e. Silicon Image ATA card and Intel
> E1000 GIGE card. On Silicon Image ATA card without this fix in place
> creating a filesystem on IDE drive "mke2fs /dev/hda" was hanging the
> system. MRMs issued by the PCI card were seen on the PCI analyzer since
> the Silicon Image driver was setting the PCI_CACHE_LINE_SIZE register to
> 255. With this patch the PCI_CACHE_LINE_SIZE register was 0 and only
> Memory Reads were seen on PCI analyzer.
> 
> Signed-off-by: Pravin M. Bathija <pbathija@amcc.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> 
> ---
> I know this patch is a little "dirty", but perhaps somebody has a better
> idea to fix this problem. Thanks.

For the peanut gallery, Stefan and I discussed this a bit on IRC today
and a different approach for arch/powerpc is going to be looked at
instead.  Namely, introducing a new flag for indirect_type in the
pci_controller structure to key off of instead of having ifdefs.

josh

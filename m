Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76A8167A66
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 02:23:57 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k4JGNZGQ028529
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 12:23:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4JGNZYH014658
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 10:23:35 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k4JGNZK4004516
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 10:23:35 -0600
Date: Fri, 19 May 2006 11:23:10 -0500
To: Srinivas Murthy <codevana@gmail.com>
Subject: Re: PPC host with a PCI root-complex
Message-ID: <20060519162310.GI12135@austin.ibm.com>
References: <7cb1293c0605181456p3c1726e2n56942dfbd4217f70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7cb1293c0605181456p3c1726e2n56942dfbd4217f70@mail.gmail.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 18, 2006 at 02:56:31PM -0700, Srinivas Murthy wrote:
> Hi,
> 
> We have a ppc host with a PCI root-complex across which there are multiple
> PCI end points.
> 
> An application running on the ppc host reading one of the device memory
> regions (not DMA access but direct CPU read) causes a parity error on the
> PCI interface controller.
> 
> We think that the error should be propagated up as a machine-check which is
> considered a non-recoverable system-wide error. However with multiple PCI
> devices present we think that this is too generic and could be reduced to be
> a critical-error which could be recovered from.

The "PCI Error Recovery" API was created to deal with this kind of a
situation. See Documentation/pci-error-recovery.txt

In breif: if something like a PCI parity error is detected by the
hardware, then some arch-specific code runs; for example,
 arch/powerpc/platforms/pseries/eeh.c.

This code notifies the PCI device driver (via generic callbacks in
include/linux/pci.h) about the error. The device driver may ask the
arch to have the pci device/bus/link/etc/ get reset, or not.  If/when
the PCI bus/link is back to normal, the PCI device driver is notified
via callback, and resumes normal operation.

If you have questions/suggestions, let me know, I've been maintaining 
this code, and am interested in seeing how well it can be adapted
to a broader range of hardware.

--linas

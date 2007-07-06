Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2B0CDDF4C
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 02:49:52 +1000 (EST)
Date: Fri, 6 Jul 2007 11:49:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Executing from readablee, no-exec pages
Message-ID: <20070706164942.GA10806@ld0162-tx32.am.freescale.net>
References: <468D68D4.4050704@freescale.com>
	<4A6D2FF2-ADD3-4D8A-ADBB-F04CAA778539@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A6D2FF2-ADD3-4D8A-ADBB-F04CAA778539@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 06, 2007 at 03:24:20PM +0200, Segher Boessenkool wrote:
> >Personally, I'd rather stick the VM_READ in there, partially for
> >selfish reasons (our root filesystems are based on older glibcs),
> >and because it seems a little too soon to deprecate glibc 2.3,
> 
> Oh I don't know, can't we just deprecate glibc completely?  ;-)

I wish. :-)

> >but also because in the absence of hardware support, the VM_EXEC
> >check will be nondeterministic, kicking in only when the first
> >fault for a page is to execute.
> 
> I don't think that is a big concern.

Well, it means that leaving VM_READ out of the check (except where the
hardware PTE has an exec bit) isn't really buying us anything
security-wise (especially since the primary reason for no-exec protection
is to avoid code injections via stack overflow, and those pages will
usually already be present), so it doesn't hurt much to let things keep
working.

At the least, I'd like it to keep working for a few more kernel releases
(with a warning printed when a VM_EXEC-only test would have failed), so
people have time to upgrade glibc.

-Scott

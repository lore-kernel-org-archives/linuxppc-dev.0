Return-Path: <gknispel@proformatique.com>
Received: from mx1.corp.proformatique.com (gon.proformatique.com
	[91.194.178.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.corp.proformatique.com",
	Issuer "Proformatique CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7FF9EB7BDB
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Oct 2009 04:21:31 +1000 (EST)
Date: Fri, 2 Oct 2009 20:08:48 +0200
From: Guillaume Knispel <gknispel@proformatique.com>
To: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Subject: Re: Is volatile always verboten for FSL QE structures?
Message-ID: <20091002200848.06be4c5a@xilun.lan.proformatique.com>
In-Reply-To: <4AC63112.7080404@ruggedcom.com>
References: <4AC60AD8.8030509@ruggedcom.com> <4AC61247.1030507@freescale.com>
	<C3FE6281-04FA-48B3-96EA-D6E68AF65D6B@kernel.crashing.org>
	<4AC63112.7080404@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Guillaume Knispel <gknispel@proformatique.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Barkowski wrote:

> Kumar Gala wrote:
> > 
> > On Oct 2, 2009, at 9:46 AM, Timur Tabi wrote:
> > 
> >> Michael Barkowski wrote:
> >>> Just wondering - is there a case where using volatile for UCC
> >>> parameter RAM for example will not work, or is the use of I/O
> >>> accessors everywhere an attempt to be portable to other architectures?
> >>
> >> 'volatile' just doesn't really do what you think it should do.  The
> >> PowerPC architecture is too complicated w.r.t. ordering of reads and
> >> writes.  In other words, you can't trust it.
> >>
> >> No one should be using 'volatile' to access I/O registers.
> > 
> > See Documentation/volatile-considered-harmful.txt
> > 
> 
> I'm happy to adopt your interpretation of it, and I appreciate the explanation.
> 
> from Documentation/volatile-considered-harmful.txt:
> >   - The above-mentioned accessor functions might use volatile on
> >     architectures where direct I/O memory access does work.  Essentially,
> >     each accessor call becomes a little critical section on its own and
> >     ensures that the access happens as expected by the programmer.
> 
> Part of it was that I wondered if this was one of those architectures.  I guess not.

I guess this could only work on architectures having a totally ordered
memory model.  Definitely not the case for Power.

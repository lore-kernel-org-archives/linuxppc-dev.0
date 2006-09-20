Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4CDF67B6E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 11:17:54 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8K1HudU009833
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 21:17:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8K1HpYd266084
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 21:17:51 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8K1Ho1j014797
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 21:17:51 -0400
Date: Tue, 19 Sep 2006 20:17:50 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Remove powerpc specific parts of 3c509 driver
Message-ID: <20060920011750.GS29167@austin.ibm.com>
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
	<45103C62.4080003@genesi-usa.com>
	<1158708269.6002.186.camel@localhost.localdomain>
	<488875E7-CCBC-47E1-A273-A2D037A997B2@kernel.crashing.org>
	<1158711935.6002.226.camel@localhost.localdomain>
	<9F6F4A8E-C780-4358-97AA-570B33C0598F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9F6F4A8E-C780-4358-97AA-570B33C0598F@kernel.crashing.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	ppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

I am alarmed and embarassed that sloppy comments on my part has turned
onto a long conversation.

On Wed, Sep 20, 2006 at 02:58:39AM +0200, Segher Boessenkool wrote:
> >> Sure, PCI busses are little-endian.  But is readX()/writeX() for PCI
> >> only?  I sure hope not.
> >
> > It's defined for PCI and possibly ISA memory. You can use it for other
> > things if you whish to, but "other things" are arch specific in any
> > case.
> 
> Huh?  You're saying that only PCI and ISA are standardised busses?

Well, I'm having trouble thinking of other busses that have as strong 
a sense of the "address-data" style I/O as PCI. Busses like scsi and 
ide are primarily "command-data" or "data-data" in style.  Only the
address-data style busses need readl/writel-style routines.

I can't prove, but suspect that the "adress-data" style of access is 
why PCI is wired up "close to" the CPU.  What other bsses are there 
that are direct-attached to the CPU? I can't think of much ...

The sbus on sparc ... hypertransport from AMD ... but hypertransport is 
more or less invisible to the kernel.  ... some recent attempts to 
supplant the system bus with infiniband, but I get the impression that 
this will be strangely engineered, and semi-invisible to the kernel as
well. The actual infiniband protocols are ipv6-like+rdma and so fall
into a "data-data" programming style.

> > Different bus -> different accessor.
> 
> Then please rename readX()/writeX() to pci_readX()/pci_writeX().

Well, I don't get the impression that there will be othre busses for
which this is an issue the way it is on pci.

--linas

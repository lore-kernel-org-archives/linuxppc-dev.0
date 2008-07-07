Return-Path: <sonny@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DD05DE39F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 07:17:45 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67LHfDX012147
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 17:17:41 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67LHfN7214250
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 17:17:41 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67LHfTw001234
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 17:17:41 -0400
Date: Mon, 7 Jul 2008 16:17:40 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Power5,Power6 BSR driver
Message-ID: <20080707211740.GA15821@us.ibm.com>
References: <20080616185344.GB16192@gamma> <20080617223952.GA9594@localdomain>
	<20080617224443.GD7552@localhost.localdomain>
	<20080618065123.GB13318@localhost.localdomain>
	<1215406775.8970.57.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215406775.8970.57.camel@pasglop>
Cc: sonnyrao@linux.vnet.ibm.com, paulus@samba.org, Nathan Lynch <ntl@pobox.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 02:59:35PM +1000, Benjamin Herrenschmidt wrote:
> 
> > +		cur->bsr_addr   = reg[i * 2];
> > +		cur->bsr_len    = reg[i * 2 + 1];
> 
> That's fishy... hand-reading of "reg" property without taking
> into account the parent's #size-cells/#address-cells... can't you
> use of_address_to_resource or something similar and carry a struct
> resource around instead ?

So, with this suggestion I looked at the resource API... not very well
documented, and I get the feeling like it's more for carving up a PCI
memory address range.  In the case of the BSR, everything is already
partitioned (by hardware) so I don't see the point of using this API
here.  Or am I missing something about it?

> In fact, same goes with the way you do num_bsr_devs = reg_len / 16.
> 
> You should rather use -another- property of well known lenght, or
> get the #address/#size-cells of the parent and use those appropriately.

Well, I check to make sure the lengths are consistent with each other
right above there so we shouldn't walk off the end of anything, but I
will take a look at using #size-cells / #address-cells instead.

Thanks for the comments

Sonny

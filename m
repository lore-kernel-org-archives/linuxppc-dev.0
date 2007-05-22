Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA3C1DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:01:05 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4MFwvGF010574
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 11:58:57 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MH10kT533412
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:01:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MH10Cs031221
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 13:01:00 -0400
Date: Tue, 22 May 2007 12:00:58 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] pseries: asm/pci-bridge.h CONFIG_ minor cleanup
Message-ID: <20070522170058.GJ5921@austin.ibm.com>
References: <20070521231816.GH5921@austin.ibm.com>
	<1179794459.7189.2.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179794459.7189.2.camel@concordia.ozlabs.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 22, 2007 at 10:40:59AM +1000, Michael Ellerman wrote:
> On Mon, 2007-05-21 at 18:18 -0500, Linas Vepstas wrote:
> > Use the correct CONFIG_ option to mark off the EEH bits.
> 
> You're making the struct 4 bytes larger by creating a hole here :(

Hmm. Perhaps I could shuffle one of the ints down ...  

I figured there might be some vague cache-line benefits to
getting the eeh stuff out of the way. 

> >  	u32	config_space[16];	/* saved PCI config space */
> > +#endif
> 
> It looks correct, but I think it's worth mentioning in the changelog
> that config_space was previously unconditionally defined, but is now
> within CONFIG_EEH.

I could just tell that someone would remark on this; why I didn't
mention it, I don't know.

--linas 

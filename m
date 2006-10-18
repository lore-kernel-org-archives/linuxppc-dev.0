Return-Path: <santil@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DB39567C3F
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 02:14:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9IGEKci014106
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 12:14:20 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9IGEKWX133558
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 12:14:20 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9IGEJgG030414
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 12:14:19 -0400
Message-ID: <453652D2.8070609@us.ibm.com>
Date: Wed, 18 Oct 2006 11:14:10 -0500
From: Santiago Leon <santil@us.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ibmveth and LIOBN field
References: <1161150069.23947.18.camel@localhost.localdomain>
In-Reply-To: <1161150069.23947.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Hi Santiago !
> 
> I'm a bit annoyed by a bit of code in the ibmveth driver:
> 
> It accesses the iommu table pointer, to get the index and put it into
> it's own private adapter->liobn member. However, that is never used
> anywhere except in ibmveth_seq_show() for the /proc stuff to display
> th'is LIOBN value.
> 
> Is this actually useful ? I'd like to just remove that code. 

I'll gladly sign off a patch that removes that code.  I think we used 
liobn in the driver a long time ago to do the tce mappings before we 
merged all the common virtual io code into arch/powerpc/vio.c.

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

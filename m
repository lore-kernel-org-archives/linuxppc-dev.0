Return-Path: <hnguyen@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 86ADEDDF7F
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 02:40:10 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0CFdxgv208314
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 15:40:00 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id l0CFdwuW3141708
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:39:58 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0CFdv8C023089
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:39:58 +0100
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH/RFC 2.6.21 3/5] ehca: completion queue: remove use of
	do_mmap()
Date: Fri, 12 Jan 2007 16:36:15 +0100
References: <200701112008.37236.hnguyen@linux.vnet.ibm.com>
	<20070111192056.GB24623@infradead.org>
In-Reply-To: <20070111192056.GB24623@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701121636.15989.hnguyen@linux.vnet.ibm.com>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, openfabrics-ewg@openib.org,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
> > +		if (my_cq->ownpid != cur_pid) {
> > +			ehca_err(device, "Invalid caller pid=%x ownpid=%x "
> > +				 "cq_num=%x",
> > +				 cur_pid, my_cq->ownpid, my_cq->cq_number);
> > +			return -EINVAL;
> > +		}
> 
> (for other reviewers: this is not new code, just moved around)
> 
> Owner tracking by pid is really dangerous.  File descriptors can be
> passed around by unix sockets, a single process can have files open
> more than once, etc..
> 
> It seems ehca wants to prevent threads other than the creating one
> from performing most operations.  Can you explain the reason for this?
you point to the right spot... This has a historic reason as we
have needed to support fork(), system("date") etc for kernel 2.6.9, 
hence those vma flags manipulation and this pid checking as proactive
protection/restriction. For newer kernel, I guess >=2.6.12, this checking
were not necessary, but we would feel better after we had tested user 
space stuff more thoroughly without this piece of code. Since this is 
not new code, can we pls handle this later?
Regards
Nam

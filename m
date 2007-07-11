Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1730FDDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 22:35:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BCZMAe006914
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 08:35:22 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BCZLCQ203136
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 06:35:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BCZKGJ003490
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 06:35:21 -0600
Subject: Re: [PATCH] Consolidate mm_context_t definition in mmu.h
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070711103308.GA15536@lst.de>
References: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
	<20070711103308.GA15536@lst.de>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 07:35:19 -0500
Message-Id: <1184157319.32199.38.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-11 at 12:33 +0200, Christoph Hellwig wrote:
> 
> mm_context_id_t isn't actually used anywhere but in te mm_context_t
> definition.  So if you kill it you have two common fields and a bunch
> of additional ones for PPC64 leading to a defintion like:
> 
> typedef struct {
> 	unsigned long id;
> 
> #ifdef CONFIG_PPC64
> 	u16 user_psize;		/* page size index */
> 
> #ifdef CONFIG_PPC_MM_SLICES
> 	u64 low_slices_psize;	/* SLB page size encodings */
> 	u64 high_slices_psize;  /* 4 bits per slice for now */
> #else
> 	u16 sllp;		/* SLB page size encoding */
> #endif
> #endif
> 
> 	unsigned long vdso_base;
> } mm_context_t;

Yes.  I did mostly the same thing in version 2 of the patch, just using
mm_context_id_t instead.  Paul said the ifdefs made his eyes hurt.

josh

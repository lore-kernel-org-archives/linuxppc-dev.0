Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 304B32C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 08:39:49 +1000 (EST)
Message-ID: <1370471978.3766.245.camel@pasglop>
Subject: Re: [PATCH -V10 10/15] powerpc: Prevent gcc to re-read the pagetables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 06 Jun 2013 08:39:38 +1000
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7271@saturn3.aculab.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1370446119-8837-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7271@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 16:41 +0100, David Laight wrote:
> >  	ptep = pte_offset_kernel(&pmd, addr);
> >  	do {
> > -		pte_t pte = *ptep;
> > +		pte_t pte = ACCESS_ONCE(*ptep);
> 
> Why not just define ptep as a 'pointer to volatile'?

ACCESS_ONCE is the proper way to do it in Linux. pointer to volatile
can have ... interesting semantics.

Cheers,
Ben.

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF2D6B6F69
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Dec 2011 10:18:33 +1100 (EST)
Message-ID: <1323040701.11728.27.camel@pasglop>
Subject: Re: [PATCH 1/1] Punch a hole in /dev/mem for librtas
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 05 Dec 2011 10:18:21 +1100
In-Reply-To: <144CAEA6-C129-4935-B6D1-A7D6F24530A5@kernel.crashing.org>
References: <20111202222623.GA31354@us.ibm.com>
 <144CAEA6-C129-4935-B6D1-A7D6F24530A5@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sbest@us.ibm.com,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, paulus@samba.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-12-03 at 04:22 +0100, Segher Boessenkool wrote:
> > +static inline int page_is_rtas_user_buf(unsigned long pfn)
> > +{
> > +	unsigned long paddr = (pfn << PAGE_SHIFT);
> > +	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf +  
> > RTAS_RMOBUF_MAX))
> 
> It probably cannot overflow with actual values of rtas_rmo_buf
> and RTAS_RMOBUF_MAX, but otherwise it is an incorrect test;
> please write
> 
> 	if (paddr >= rtas_rmo_buf && paddr - rtas_rmo_buf < RTAS_RMOBUF_MAX)
> 
> (and, _MAX?  Shouldn't it be the actual size here?  Or is _MAX
> just a confusing name :-) )

The original code is a lot more readable and perfectly correct for all
possible values of rtas_rmo_buf :-)

Cheers,
Ben.

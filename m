Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2250867BFF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 07:36:51 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7NLahEw025030
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 17:36:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7NLahmZ347060
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 15:36:43 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7NLahW5005287
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 15:36:43 -0600
Date: Wed, 23 Aug 2006 16:36:42 -0500
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060823213642.GG4401@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com>
	<200608190109.15129.arnd@arndb.de>
	<1156055509.5803.77.camel@localhost.localdomain>
	<200608201203.15645.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608201203.15645.arnd@arndb.de>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Aug 20, 2006 at 12:03:14PM +0200, Arnd Bergmann wrote:
> On Sunday 20 August 2006 08:31, Benjamin Herrenschmidt wrote:
> > > card->low_watermark->next->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
> > > mb();
> > > card->low_watermark->dmac_cmd_status &= ~SPIDER_NET_DESCR_TXDESFLG;
> > > card->low_watermark = card->low_watermark->next;
> > > 
> > > when we queue another frame for TX.
> > 
> > I would have expected those to be racy vs. the hardware... what if the
> > hardware is updating dmac_cmd_status just as your are trying to and the
> > bit out of it ?
> 
> Right, that doesn't work. It is the only bit we use in that byte though,
> so maybe it can be done with a single byte write.

Thanks, you're right, I missed that.  I'll change this to byte access 
shortly.  Any recommendations for style/api for byte access? 

I could create a searate patch to change struct descr {} to split 
the u32 into several u8's; there's a dozen spots that get touched.

Alternatel, I could do a cheesy cast to char[4] and access that way.
Opinions?

--linas

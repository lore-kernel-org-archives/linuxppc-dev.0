Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1147FDDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 11:18:24 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l7U1IDM3003345
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 11:18:13 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7U1I97P1585212
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 11:18:09 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7U2I92G019235
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 12:18:09 +1000
Date: Thu, 30 Aug 2007 11:18:04 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: Document and implement an improved flash device binding
Message-ID: <20070830011804.GE22844@localhost.localdomain>
References: <20070829061300.GF3206@localhost.localdomain>
	<20070829084341.GS13994@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829084341.GS13994@moe.telargo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 29, 2007 at 10:43:41AM +0200, Domen Puncer wrote:
> On 29/08/07 16:13 +1000, David Gibson wrote:
> 
> <snip>
> >  static int __devinit of_physmap_probe(struct of_device *dev, const struct of_device_id *match)
> >  {
> >  	struct device_node *dp = dev->node;
> >  	struct resource res;
> >  	struct physmap_flash_info *info;
> > -	const char **probe_type;
> > -	const char *of_probe;
> > +	const char *probe_type = (const char *)match->data;
> >  	const u32 *width;
> >  	int err;
> >  
> > +	dev_warn(&dev->dev, "Device tree uses obsolete \"direct-mapped\" "
> > +		 "flash binding\n");
> 
> This is printed for new binding too :-)

Duh, put that warning in completely the wrong place.  I was awake,
obviously :-/

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

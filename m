Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 83509DDE1B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 08:46:12 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9NLk9g6011473
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 17:46:09 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9NLk95b117374
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 17:46:09 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9NLk9k2002924
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 17:46:09 -0400
Date: Thu, 23 Oct 2008 17:46:06 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: odd change to drivers/net/ibm_newemac/core.c
Message-ID: <20081023174606.555a65de@zod.rchland.ibm.com>
In-Reply-To: <20081023214148.GA32322@lst.de>
References: <20081023214148.GA32322@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 23 Oct 2008 23:41:48 +0200
Christoph Hellwig <hch@lst.de> wrote:

> +#ifdef CONFIG_IBM_NEW_EMAC_NO_FLOW_CONTROL
>                         dev->features |= EMAC_FTR_NO_FLOW_CONTROL_40x;
> +#else
> +                       printk(KERN_ERR "%s: Flow control not disabled!\n",
> +					np->full_name);
> +                       return -ENXIO;
> +#endif
> 
> What's this trying to do?  CONFIG_IBM_NEW_EMAC_NO_FLOW_CONTROL doesn't
> exist anywhere, and it seems like an extremly strange idea for a config

Damnit.  Typo.  Should be CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL.  It's right
elsewhere, I just fat-fingered the option with this particular change
because I was rushing for a build fix.  I'll fix it with the brown
paper bag of shame over my head shortly.

> option.  And "Flow control not disabled" is not an extremly useful error
> message for users either..

Normal users aren't supposed to set it.  The option is selected by the
4xx platform config options on boards that need the feature.  This is
how other things are done in the EMAC driver.

josh

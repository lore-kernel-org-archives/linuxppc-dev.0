Return-Path: <FENKES@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89748DDE40
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 18:58:44 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id l8Q8wepj607076
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 08:58:40 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8Q8wecA1785886
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 10:58:40 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8Q8wdE7013153
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 10:58:39 +0200
In-Reply-To: <200709251639.06414.arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] ibmebus: Add device creation and bus probing based on
	of_device
From: Joachim Fenkes <FENKES@de.ibm.com>
Message-ID: <OF5734B9D1.E734A7F1-ONC1257362.002FF979-C1257362.0031501B@de.ibm.com>
Date: Wed, 26 Sep 2007 10:58:37 +0200
Content-Type: text/plain; charset="US-ASCII"
Cc: Thomas Q Klein <tklein@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +/* These devices will automatically be added to the bus during init 
*/
> > +static struct of_device_id builtin_matches[] = {
> > +   { .name = "lhca" },
> > +   { .compatible = "IBM,lhca" },
> > +   { .name = "lhea" },
> > +   { .compatible = "IBM,lhea" },
> > +   {},
> > +};
> > +
> 
> Hmm, do you have devices that only have the matching name property
> but not the compatible property? If not, I'd suggest only looking
> for compatible, so you have less chance of false positives.

If a device that's not an lhca is called "lhca", that's its own fault, i 
guess ;) But i concur that looking for the compatible property will 
probably suffice.
 
> > +static int ibmebus_create_device(struct device_node *dn)
> > [...]
> 
> nice!

Thanks.
 
> > -      rc = IS_ERR(dev) ? PTR_ERR(dev) : count;
> > +      rc = rc ? rc : count;
> 
> the last line looks a bit silly. Maybe instead do
> 
>       rc = ibmebus_create_device(dn);
>         of_node_put(dn);
>    }
> 
>    kfree(path);
>    if (rc)
>       return rc;
>    return count;
> }

More code lines? ;) But yes, that looks more like "standard kernel 
pattern" - I'll change that.

Joachim

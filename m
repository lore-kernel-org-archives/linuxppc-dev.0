Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 320EB2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 16:49:39 +1100 (EST)
Message-ID: <1381988968.17841.87.camel@pasglop>
Subject: Re: [PATCH] powerpc/vio: Fix modalias_show return values
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Hutchings <ben@decadent.org.uk>
Date: Thu, 17 Oct 2013 00:49:28 -0500
In-Reply-To: <1381982024.3267.14.camel@deadeye.wl.decadent.org.uk>
References: <1381982024.3267.14.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Prarit Bhargava <prarit@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-17 at 04:53 +0100, Ben Hutchings wrote:
> Commit e82b89a6f19bae73fb064d1b3dd91fcefbb478f4 introduces a trivial
> local denial of service.

Oops. Prarit, please send a fix asap ! I'm travelling right now.

Thanks !
Ben.

> > --- a/arch/powerpc/kernel/vio.c
> > +++ b/arch/powerpc/kernel/vio.c
> > @@ -1351,11 +1351,15 @@ static ssize_t modalias_show(struct devi
> >  	const char *cp;
> >  
> >  	dn = dev->of_node;
> > -	if (!dn)
> > -		return -ENODEV;
> > +	if (!dn) {
> > +		strcat(buf, "\n");
> 
> Every read from the same sysfs file handle uses the same buffer, which
> gets zero-initialised just once.  So if I open the file, read it and
> seek back to 0 repeatedly, I can make modalias_show() write arbitrary
> numbers of newlines into *and beyond* that page-sized buffer.
> 
> Obviously strcat() should be strcpy().
> 
> Ben.
> 
> > +		return strlen(buf);
> > +	}
> >  	cp = of_get_property(dn, "compatible", NULL);
> > -	if (!cp)
> > -		return -ENODEV;
> > +	if (!cp) {
> > +		strcat(buf, "\n");
> > +		return strlen(buf);
> > +	}
> >  
> >  	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
> >  }
> 

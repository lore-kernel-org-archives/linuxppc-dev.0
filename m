Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 5D2F2DE002
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 13:00:46 +1100 (EST)
Date: Wed, 10 Dec 2008 20:00:40 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/3] convert cpu_to_l2cache() to of_find_next_cache_node()
Message-ID: <20081211020039.GM6958@localdomain>
References: <1228956366-17593-1-git-send-email-ntl@pobox.com>
	<1228956366-17593-2-git-send-email-ntl@pobox.com>
	<20081211124211.c3bb5442.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081211124211.c3bb5442.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Wed, 10 Dec 2008 18:46:05 -0600 Nathan Lynch <ntl@pobox.com> wrote:
> >
> > @@ -418,13 +416,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
> >  	if (np == NULL)
> >  		return NULL;
> >  
> > -	php = of_get_property(np, "l2-cache", NULL);
> > -	if (php == NULL)
> > -		return NULL;
> > -	ph = *php;
> > -	of_node_put(np);
> > -
> > -	return of_find_node_by_phandle(ph);
> > +	return of_find_next_cache_node(np);
> >  }
> 
> This leaks a reference on np ...

Thanks, will fix.

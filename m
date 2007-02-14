Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 11:20:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 16/16] Support for Ebony in arch/powerpc
Message-ID: <20070214002009.GD11491@localhost.localdomain>
References: <20070213061026.7979DDDDF0@ozlabs.org> <adabqjym0vy.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adabqjym0vy.fsf@cisco.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 09:18:57AM -0800, Roland Dreier wrote:
>  >  config 440GP
>  >  	bool
>  >  	depends on EBONY
>  > -	default y
>  > +	select IBM_NEW_EMAC_ZMII
>  > + 	default y
> 
> Maybe we could take this opportunity to clean up the CPU selection in
> Kconfig and use select instead... right now we have a mess like
> 
> config 440GP
>         bool
>         depends on EBONY
>         default y
> 
> config 440
>         bool
>         depends on 440GP || 440SP || 440SPE || 440EP
>         default y
> 
> etc... -- it would be nice for this to look like
> 
> config EBONY
> 	bool
> 	select 440GP
> 
> config 440GP
> 	bool
> 	select IBM_NEW_EMAC_ZMII
> 	select 440
> 
> config 440
> 	bool
> 
> I'm happy to do this cleanup after things settle down though

Yes, I've been thinking about something like that.  Sounds good to
me.  At the same time we need to change the board options from a
choice to individual bools, since it should now be possible to make a
kernel bootable on multiple boards.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

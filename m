Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 21:32:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: OF /chosen/initrd,* variables - patch, official?
Message-ID: <20070821113232.GB1111@localhost.localdomain>
References: <46CAC89F.2040100@genesi-usa.com> <46CACAAE.5000304@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46CACAAE.5000304@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 12:21:18PM +0100, Matt Sealey wrote:
> Damn, I should use patchwork more efficiently;
> 
> http://patchwork.ozlabs.org/linuxppc/patch?q=initrd&filter=none&id=12168
> 
> Does anyone have any suggestion on the best way to integrate this so that
> it "just works" on OF platforms? It seems only to be usable way too late
> in boot to work, this code would have to be called in boot/main.c which seems
> relatively.. impossible to achieve.. or called in some specialised platform
> init code..

It would have to be called from platform_init().  If called in main()
it would clobber any other platform-specific initialization of the
initrd parameters in loader_info.

> I hacked up a patch initially before I saw Milton's work and did it all
> in main.c (and did the same to mkvmlinuz..) and it seemed to work okay
> there.
> 
> I'm really curious as to the status and usefulness of this here.. :(
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

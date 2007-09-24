Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Sep 2007 14:03:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 13/15] bootwrapper: attach an empty vmlinux
Message-ID: <20070924040345.GL8058@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-13.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-8-13.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 06:06:38PM -0500, Milton Miller wrote:
> Allow the boot wrapper code to be linked without an attached vmlinux.
> 
> Rather than invent a new syntax to invoke the wrapper, attach the
> stripped version of empty.o, which produces the same result.

Aiee.  Please don't do that.  Add a new wrapper option so the vmlinux
is optional instead.  

Particularly since...
> Index: kernel/arch/powerpc/boot/wrapper
> ===================================================================
> --- kernel.orig/arch/powerpc/boot/wrapper	2007-09-17 22:11:51.000000000 -0500
> +++ kernel/arch/powerpc/boot/wrapper	2007-09-17 22:12:05.000000000 -0500
> @@ -161,6 +161,13 @@ ps3)
>      ;;
>  esac
>  
> +if [ "$kernel" = $object/empty.o ] ; then
> +    ext=bin
> +    objflags="-O binary"
> +    gzip=
> +fi

Making the vmlinux empty.o *isn't* just a matter of doing that but
also has other side effects as above.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

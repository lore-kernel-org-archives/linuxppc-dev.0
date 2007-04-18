Return-Path: <b07421@freescale.com>
Date: Wed, 18 Apr 2007 11:14:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 10/10] zImage wrapper for Ebony
Message-ID: <20070418161441.GA8129@ld0162-tx32.am.freescale.net>
References: <20070418063517.GB29312@localhost.localdomain>
	<20070418063626.E6AADDDE3B@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070418063626.E6AADDDE3B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 18, 2007 at 04:36:26PM +1000, David Gibson wrote:
> Index: working-2.6/arch/powerpc/boot/wrapper
> ===================================================================
> --- working-2.6.orig/arch/powerpc/boot/wrapper	2007-04-18 14:40:39.000000000 +1000
> +++ working-2.6/arch/powerpc/boot/wrapper	2007-04-18 14:42:58.000000000 +1000
> @@ -141,6 +141,12 @@ miboot|uboot)
>      ksection=image
>      isection=initrd
>      ;;
> +*-tree)
> +    platformo=$object/"${platform%%-tree}".o
> +    ;;
> +*-uboot)
> +    platformo=$object/"${platform%%-uboot}".o
> +    ;;
>  esac

Perhaps we should have separate platform file and image type arguments,
so the wrapper doesn't have to do this sort of manipulation?

> +*-uboot)
> +    mv "$ofile" "$ofile.elf"
> +    version=`${CROSS}strings "$kernel" | grep '^Linux version [-0-9.]' | \
> +	cut -d' ' -f3`
> +    if [ -n "$version" ]; then
> +	version="-n Linux-$version"
> +    fi
> +    entry=`objdump -f "$ofile.elf" | grep '^start address ' | \
> +	cut -d' ' -f3`

Should be ${CROSS}objdump.  Plus, it'd be nice to factor out the version
and entry determination so that it isn't repeated for each image type
(the cuImage patch does this for version).

-Scott

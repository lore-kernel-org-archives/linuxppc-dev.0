Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C5C6BDE08B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 16:49:40 +1100 (EST)
Subject: Re: [PATCH] powerpc/bootwrapper: add fixed-head.o to simpleimage
	wrappers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090309152047.25290.29963.stgit@localhost.localdomain>
References: <20090309152047.25290.29963.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 16:49:28 +1100
Message-Id: <1236750568.7086.43.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, eddie@embeddedarm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-03-09 at 09:23 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> fixed-head.o must be linked into the bootwrapper for raw-binary images to
> work.  This patch adds it into the bootwrapper.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Reported-by: Eddie Dawydiuk <eddie@embeddedarm.com>
> ---

Ack :-)

> I pulled this chunk out of Eddie's bigger patch and also modified the other
> case where it applies.  This is a definite bug on the simpleimage generation.
> Once I get an ack, I'll add it to my -next tree and ask Ben to pull.
> 
> Cheers,
> g.
> 
>  arch/powerpc/boot/wrapper |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index 965c237..c5bd9cf 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -211,11 +211,11 @@ simpleboot-virtex405-*)
>      binary=y
>      ;;
>  simpleboot-virtex440-*)
> -    platformo="$object/simpleboot.o $object/virtex.o"
> +    platformo="$object/fixed-head.o $object/simpleboot.o $object/virtex.o"
>      binary=y
>      ;;
>  simpleboot-*)
> -    platformo="$object/simpleboot.o"
> +    platformo="$object/fixed-head.o $object/simpleboot.o"
>      binary=y
>      ;;
>  asp834x-redboot)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8671B1A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 13:12:45 +1100 (AEDT)
Message-ID: <1423620754.5891.32.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/boot/wrapper: use the pseries wrapper for
 zImage.epapr
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 13:12:34 +1100
In-Reply-To: <1423570510.218746.573015373614.2.gpush@pablo>
References: <1423570510.218746.573015373614.2.gpush@pablo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 20:15 +0800, Jeremy Kerr wrote:
> We'll likely be entering the zImage.epapr as BE, so include the pseries
> implementation of _zimage_start, which adds the endian fixup magic.

Wont that break embedded epapr stuff ?

> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> 
> ---
>  arch/powerpc/boot/wrapper |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index ae0f88e..3f50c27 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -277,7 +277,7 @@ treeboot-iss4xx-mpic)
>      platformo="$object/treeboot-iss4xx.o"
>      ;;
>  epapr)
> -    platformo="$object/epapr.o $object/epapr-wrapper.o"
> +    platformo="$object/pseries-head.o $object/epapr.o $object/epapr-wrapper.o"
>      link_address='0x20000000'
>      pie=-pie
>      ;;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 62732B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jun 2012 07:19:37 +1000 (EST)
Message-ID: <1338671969.7150.0.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix size of st_nlink on 64bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Sun, 03 Jun 2012 07:19:29 +1000
In-Reply-To: <20120602213452.66ba4cbb@kryten>
References: <20120602213452.66ba4cbb@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: michael@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 viro@zeniv.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-06-02 at 21:34 +1000, Anton Blanchard wrote:
> commit e57f93cc53b7 (powerpc: get rid of nlink_t uses, switch to
> explicitly-sized type) changed the size of st_nlink on ppc64 from
> a long to a short, resulting in boot failures.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Al, did you CC me on that ? I don't remember seeing it but it could be
my fault...

Cheers,
Ben.

> ---
> 
> Index: linux-build/arch/powerpc/include/asm/stat.h
> ===================================================================
> --- linux-build.orig/arch/powerpc/include/asm/stat.h	2012-06-02 21:25:50.322275743 +1000
> +++ linux-build/arch/powerpc/include/asm/stat.h	2012-06-02 21:26:35.183130538 +1000
> @@ -30,7 +30,7 @@ struct stat {
>  	unsigned long	st_dev;
>  	ino_t		st_ino;
>  #ifdef __powerpc64__
> -	unsigned short	st_nlink;
> +	unsigned long	st_nlink;
>  	mode_t		st_mode;
>  #else
>  	mode_t		st_mode;

Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1ACA1A033E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 08:40:26 +1100 (AEDT)
Message-ID: <1455658818.2463.78.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org
Cc: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Date: Tue, 16 Feb 2016 15:40:18 -0600
In-Reply-To: <CAPk1OjGDTCy6TzX1B3oi6NA3s==23vRgTdRh2SKfyVj-K7k75Q@mail.gmail.com>
References: <CAPk1OjGDTCy6TzX1B3oi6NA3s==23vRgTdRh2SKfyVj-K7k75Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Question about code which uses MPIC_NO_RESET on 85XX
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-02-04 at 14:56 +0100, Alessio Igor Bogani wrote:
> Hi,
> 
> Can we change this code (from mpc85xx_ds.c)
> 
> if (of_flat_dt_is_compatible(root, "fsl,MPC8572DS-CAMP")) {
>     mpic = mpic_alloc(NULL, 0,
>         MPIC_NO_RESET |
>         MPIC_BIG_ENDIAN |
>         MPIC_SINGLE_DEST_CPU,
>         0, 256, " OpenPIC  ");
> } else {
>     mpic = mpic_alloc(NULL, 0,
>         MPIC_BIG_ENDIAN |
>         MPIC_SINGLE_DEST_CPU,
>         0, 256, " OpenPIC  ");
> }
> 
> in this one
> 
> mpic = mpic_alloc(NULL, 0,
>     MPIC_BIG_ENDIAN |
>     MPIC_SINGLE_DEST_CPU,
>     0, 256, " OpenPIC  ");
> 
> using "pic-no-reset" in the device tree?

In theory that breaks existing device trees that don't specify pic-no-reset. 
 I'm not sure how much it matters in this case as it's primarily meant as an
example of how to do AMP rather than something that works out-of-the-box.

BTW, Kyle, it looks like there was a meaningful difference between
!MPIC_WANTS_RESET and MPIC_NO_RESET -- the former did not inhibit
initialization of non-protected vectors and was the behavior of fsl,MPC8572DS
-CAMP before your "powerpc/mpic: Remove duplicate MPIC_WANTS_RESET flag"
patch.  It's no longer possible to initialize all MPIC vectors except
protected ones.  Again, I'm not sure it matters much, but I'm also not sure
how much continued  value the protected-source code has.

-Scott

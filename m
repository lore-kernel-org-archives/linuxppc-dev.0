Return-Path: <herbert@gondor.apana.org.au>
Received: from helcar.apana.org.au (helcar.apana.org.au [209.40.204.226])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88BC41A1935
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 16:54:00 +1000 (EST)
Date: Thu, 2 Oct 2014 14:53:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2] drivers: char: hw_random: printk replacement
Message-ID: <20141002065341.GA26145@gondor.apana.org.au>
References: <1410793281-30305-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410793281-30305-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-geode@lists.infradead.org,
 Matt Mackall <mpm@selenic.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 15, 2014 at 08:31:20PM +0530, Sudip Mukherjee wrote:
> as pr_* macros are more preffered over printk, so printk replaced with corresponding pr_* macros
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> 
> The replacement was done by a bash script to avoid copy paste error. The script is as follows :
> 
> OLD="printk(KERN_ERR \?"
> OLD1="printk(KERN_NOTICE \?"
> OLD2="printk(KERN_WARNING \?"
> OLD3="printk(KERN_INFO \?"
> NEW="pr_err("
> NEW1="pr_notice("
> NEW2="pr_warn("
> NEW3="pr_info("
> TFILE="/tmp/out.tmp.$$"
> for f in *.c
> do
> sed -e "s/$OLD/$NEW/g" -e "s/$OLD1/$NEW1/g" -e "s/$OLD2/$NEW2/g" -e "s/$OLD3/$NEW3/g" "$f" > $TFILE && mv $TFILE "$f"
> done
> 
> exception is intel-rng.c . 
> in v1 the build failed due to intel-rng.c . 
> it has been corrected and has been carefully build tested.
> 
>  drivers/char/hw_random/amd-rng.c     |  4 ++--
>  drivers/char/hw_random/geode-rng.c   |  4 ++--
>  drivers/char/hw_random/intel-rng.c   | 13 ++++++-------
>  drivers/char/hw_random/pasemi-rng.c  |  2 +-
>  drivers/char/hw_random/pseries-rng.c |  2 +-
>  drivers/char/hw_random/via-rng.c     |  8 ++++----
>  6 files changed, 16 insertions(+), 17 deletions(-)

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

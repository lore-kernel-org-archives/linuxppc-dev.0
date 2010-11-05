Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: cbe-oss-dev@lists.ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH 03/49] arch/powerpc: Use vzalloc
Date: Fri, 5 Nov 2010 09:08:49 -0400
References: <alpine.DEB.2.00.1011031108260.11625@router.home>
	<5da00d7f95b5c7a96fbfa8420f5e3a8ef33e01e6.1288925424.git.joe@perches.com>
In-Reply-To: <5da00d7f95b5c7a96fbfa8420f5e3a8ef33e01e6.1288925424.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201011050908.50190.jk@ozlabs.org>
Cc: Jiri Kosina <trivial@kernel.org>, kvm@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Marcelo Tosatti <mtosatti@redhat.com>,
	Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Avi Kivity <avi@redhat.com>, Joe Perches <joe@perches.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joe,

> diff --git a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
> b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c index a101abf..3b894f5
> 100644
> --- a/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
> +++ b/arch/powerpc/platforms/cell/spufs/lscsa_alloc.c
> @@ -36,10 +36,9 @@ static int spu_alloc_lscsa_std(struct spu_state *csa)
>  	struct spu_lscsa *lscsa;
>  	unsigned char *p;
> 
> -	lscsa = vmalloc(sizeof(struct spu_lscsa));
> +	lscsa = vzalloc(sizeof(struct spu_lscsa));
>  	if (!lscsa)
>  		return -ENOMEM;
> -	memset(lscsa, 0, sizeof(struct spu_lscsa));
>  	csa->lscsa = lscsa;
> 
>  	/* Set LS pages reserved to allow for user-space mapping. */

For the spufs bit:

Acked-By: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

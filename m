Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 8EBECB7105
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 12:14:32 +1000 (EST)
Date: Fri, 10 Sep 2010 10:41:48 +0900
From: Simon Horman <horms@verge.net.au>
To: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] ppc64: increase TREEWORDS value in ppc64
Message-ID: <20100910014148.GE8477@verge.net.au>
References: <20100909202711.GA22581@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100909202711.GA22581@hmsreliant.think-freely.org>
Cc: linuxppc-dev@lists.ozlabs.org, vgoyal@redhat.com, kexec@lists.infadead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ CCed linuxppc-dev ]

On Thu, Sep 09, 2010 at 04:27:11PM -0400, Neil Horman wrote:
> hey-
>      Got a segfault recently on ppc64 kexec with a system with 256Gb of ram.
> Tracked it back to running over the end of the device tree buffer that we have
> allocated.  I can't find any docs on how big the device tree can legally be, so
> for now I figure just upping its size is sufficient.  Confirmed that this fixed
> the segfault.

Thanks Neil, though it would be nice to know what the limit actually is.
I'll hold off on applying this for a few days to see of the ppc people
have any comments on that.

> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> 
> 
>  fs2dt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
> index 238a3f2..2f0f937 100644
> --- a/kexec/arch/ppc/fs2dt.c
> +++ b/kexec/arch/ppc/fs2dt.c
> @@ -33,7 +33,7 @@
>  
>  #define MAXPATH			1024	/* max path name length */
>  #define NAMESPACE		16384	/* max bytes for property names */
> -#define TREEWORDS		65536	/* max 32 bit words for properties */
> +#define TREEWORDS		131070	/* max 32 bit words for properties */
>  #define MEMRESERVE		256	/* max number of reserved memory blks */
>  #define MAX_MEMORY_RANGES	1024
>  #define COMMAND_LINE_SIZE	512	/* from kernel */

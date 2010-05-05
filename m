Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id E36C6B7D4F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 13:00:56 +1000 (EST)
Date: Wed, 5 May 2010 12:33:16 +1000
From: Simon Horman <horms@verge.net.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec-tools, ppc64: fix build error on ppc64
Message-ID: <20100505023316.GF13035@verge.net.au>
References: <15110.1273024133@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15110.1273024133@neuling.org>
Cc: Maxim Uvarov <muvarov@gmail.com>, linuxppc-dev@ozlabs.org,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 05, 2010 at 11:48:53AM +1000, Michael Neuling wrote:
> 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
> improvements" broke pp64 as it turned on -Werror for all archs.
> 
> This fixes the warning and hence ppc64 building.

Thanks.

While I'm very much in favour of using -Werror for testing
and these kind of patches are great, I think that -Werror
by default is rather silly. We can't control what will be
a warning in the future and sometimes fixing warnings isn't
appropriate - for instance there are warnings in fs2dt.c at
the moment, that is currently considered an upstream problem.

In short, this patch is great. But I plan to also remove -Werror
as the default now that its been brought to my attention.

> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> I've posted a second patch to fix the issue of changing one archs
> Makefile, effecting all other archs.
> 
>  kexec/arch/ppc64/fs2dt.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: kexec-tools/kexec/arch/ppc64/fs2dt.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/ppc64/fs2dt.c
> +++ kexec-tools/kexec/arch/ppc64/fs2dt.c
> @@ -357,7 +357,8 @@ static void putprops(char *fn, struct di
>   * Compare function used to sort the device-tree directories
>   * This function will be passed to scandir.
>   */
> -static int comparefunc(const void *dentry1, const void *dentry2)
> +static int comparefunc(const struct dirent **dentry1,
> +		       const struct dirent **dentry2)
>  {
>  	char *str1 = (*(struct dirent **)dentry1)->d_name;
>  	char *str2 = (*(struct dirent **)dentry2)->d_name;
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

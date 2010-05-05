Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 549C4B7D11
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 May 2010 12:25:46 +1000 (EST)
To: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <15110.1273024133@neuling.org>
Message-Id: <E1O9TqO-0006eP-3q@xyzzy.farnsworth.org>
From: Dale Farnsworth <dale@farnsworth.org>
Date: Tue, 04 May 2010 18:56:12 -0700
Subject: Re: [PATCH] kexec-tools, ppc64: fix build error on ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In article <15110.1273024133@neuling.org> Michael Neuling wrote:
> 6adc05c6e3fdbc8b9f5d915af78ca05d0a09cb17 "some kexec MIPS
> improvements" broke pp64 as it turned on -Werror for all archs.
> 
> This fixes the warning and hence ppc64 building.
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

It would be nice to also remove the no-longer-needed casts.

-Dale

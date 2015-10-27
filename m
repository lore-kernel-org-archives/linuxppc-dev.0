Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 2215C1A047B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 02:54:58 +1100 (AEDT)
Message-ID: <1445961142.6332.34.camel@linux.intel.com>
Subject: Re: [PATCH v2] powerpc/pseries: Correct string length in
 pseries_of_derive_parent()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 27 Oct 2015 17:52:22 +0200
In-Reply-To: <562F9C67.3040207@linux.vnet.ibm.com>
References: <562F9C67.3040207@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-27 at 10:46 -0500, Nathan Fontenot wrote:
> Commit a030e1e4bbd085bbcfd0a23f8d355fcd41f39bed make a change to use
> kstrndup() instead of kmalloc() + strlcpy() in the
> pseries_of_derive_parent()
> routine that introduces a subtle change in the parent path name
> generated.
> The kstrndup() routine will copy n characters followed by a
> terminating null,
> whereas strlcpy() will copy n-1 characters and add a terminating
> null.
> 
> This slight difference results in having a parent path that includes
> the
> tailing '/' character, "/cpus/" vs. "/cpus". This then causes the
> subsequent
> call to of_find_node_by_path() to fail, and in the case of DLPAR add
> operations the DLPAR request fails.
> 
> This patch decrements the pointer returned from kbasename() to point
> to the
> '/' character before the base name instead of the base name. This
> then
> adjusts the string length calculations to not include the trailing
> '/'
> in the parent path name.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
> 
> Updates for v2: Decrement the pointer returned from kbasename()
> instead
> of subtracting 1 when calculating the string length.
>  
>  arch/powerpc/platforms/pseries/of_helpers.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/of_helpers.c
> b/arch/powerpc/platforms/pseries/of_helpers.c
> index 4417afe..2798933 100644
> --- a/arch/powerpc/platforms/pseries/of_helpers.c
> +++ b/arch/powerpc/platforms/pseries/of_helpers.c
> @@ -17,13 +17,16 @@ struct device_node
> *pseries_of_derive_parent(const char *path)
>  {
>  	struct device_node *parent;
>  	char *parent_path = "/";
> -	const char *tail = kbasename(path);
> +	const char *tail;
> +
> +	/* We do not want the trailing '/' character */
> +	tail = kbasename(path) - 1;
>  
>  	/* reject if path is "/" */
>  	if (!strcmp(path, "/"))
>  		return ERR_PTR(-EINVAL);
>  
> -	if (tail > path + 1) {
> +	if (tail > path) {
>  		parent_path = kstrndup(path, tail - path,
> GFP_KERNEL);
>  		if (!parent_path)
>  			return ERR_PTR(-ENOMEM);
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

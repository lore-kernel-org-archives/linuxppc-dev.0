Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id F204B1A045F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 19:17:40 +1100 (AEDT)
Message-ID: <1445933855.6332.13.camel@linux.intel.com>
Subject: Re: [PATCH] powerpc/pseries: Correct string length in
 pseries_of_derive_parent()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 27 Oct 2015 10:17:35 +0200
In-Reply-To: <562E7FF1.1040806@linux.vnet.ibm.com>
References: <562E7FF1.1040806@linux.vnet.ibm.com>
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

On Mon, 2015-10-26 at 14:33 -0500, Nathan Fontenot wrote:
> Commit a030e1e4bbd085bbcfd0a23f8d355fcd41f39bed made a change to use
> kstrndup() instead of kmalloc() + strlcpy() in
> pseries_of_derive_parent()
> which introduces a subtle change in the parent path name generated.
> The kstrndup() routine will copy n characters followed by a
> terminating null,
> whereas strlcpy() will copy n-1 characters and add a terminating
> null.

Nice catch!
One comment below.

> 
> This slight difference results in having a parent path that includes
> the
> trailing '/' character, i.e. "/cpus/" vs. "/cpus". This then causes
> the
> subsequent call to of_find_node_by_path() to fail, and in the case of
> DLPAR add operations, the DLPAR request fails.
> 
> This patch reduces the total length of the string to copy in kstrndup
> by 1
> so we no longer copy the trailing '/'.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/of_helpers.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/of_helpers.c
> b/arch/powerpc/platforms/pseries/of_helpers.c
> index 4417afe..6d90378 100644
> --- a/arch/powerpc/platforms/pseries/of_helpers.c
> +++ b/arch/powerpc/platforms/pseries/of_helpers.c
> @@ -24,7 +24,7 @@ struct device_node *pseries_of_derive_parent(const
> char *path)
>  		return ERR_PTR(-EINVAL);
>  
>  	if (tail > path + 1) {
> -		parent_path = kstrndup(path, tail - path,
> GFP_KERNEL);
> +		parent_path = kstrndup(path, (tail - 1) - path,
> GFP_KERNEL);

Since  previous line has (tail > path + 1) which is equivalent to (tail
- 1 > path), can we amend both?

For example (might be better, but first comes to my mind)

const char *tail = kbasename(path) - 1;

...

if (tail > path) {


>  		if (!parent_path)
>  			return ERR_PTR(-ENOMEM);
>  	}
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

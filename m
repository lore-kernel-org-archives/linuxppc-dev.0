Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9ABE1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 15:21:38 +1000 (AEST)
Date: Wed, 5 Aug 2015 00:20:57 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc/pseries: extract of_helpers module
Message-ID: <20150805052057.GB32178@gate.crashing.org>
References: <1438699009-112794-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438699009-112794-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andy,

On Tue, Aug 04, 2015 at 05:36:45PM +0300, Andy Shevchenko wrote:
> +struct device_node *pseries_of_derive_parent(const char *path)
> +{
> +	struct device_node *parent = NULL;
> +	char *parent_path = "/";
> +	size_t parent_path_len = strrchr(path, '/') - path + 1;
> +
> +	/* reject if path is "/" */
> +	if (!strcmp(path, "/"))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (strrchr(path, '/') != path) {
> +		parent_path = kmalloc(parent_path_len, GFP_KERNEL);

If path doesn't contain any slash this will do interesting things;
you might want to fix that too while you're at it :-)


Segher

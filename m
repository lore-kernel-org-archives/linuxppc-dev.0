Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 8DCF51A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 19:32:59 +1000 (AEST)
Message-ID: <1438767175.29746.161.camel@linux.intel.com>
Subject: Re: [PATCH 1/5] powerpc/pseries: extract of_helpers module
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 05 Aug 2015 12:32:55 +0300
In-Reply-To: <20150805052057.GB32178@gate.crashing.org>
References: <1438699009-112794-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150805052057.GB32178@gate.crashing.org>
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

On Wed, 2015-08-05 at 00:20 -0500, Segher Boessenkool wrote:
> Hi Andy,
> 
> On Tue, Aug 04, 2015 at 05:36:45PM +0300, Andy Shevchenko wrote:
> > +struct device_node *pseries_of_derive_parent(const char *path)
> > +{
> > +	struct device_node *parent = NULL;
> > +	char *parent_path = "/";
> > +	size_t parent_path_len = strrchr(path, '/') - path + 1;
> > +
> > +	/* reject if path is "/" */
> > +	if (!strcmp(path, "/"))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (strrchr(path, '/') != path) {
> > +		parent_path = kmalloc(parent_path_len, 
> > GFP_KERNEL);
> 
> If path doesn't contain any slash this will do interesting things;
> you might want to fix that too while you're at it :-)

No problem, though it is in the original code. I would do as a separate
patch on top of the series. Will be okay for you?

> 
> 
> Segher

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

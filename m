Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHLCF25KczDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 05:27:52 +1100 (AEDT)
Date: Wed, 18 Oct 2017 20:27:45 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Joe Perches <joe@perches.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.vnet.ibm.com>, Jerry
 Snitselaar <jsnitsel@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Jason Gunthorpe
 <jgunthorpe@obsidianresearch.com>, Corentin Labbe
 <clabbe.montjoie@gmail.com>, James Bottomley
 <James.Bottomley@HansenPartnership.comg>, Paul Mackerras
 <paulus@samba.org>, Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Dan Carpenter
 <dan.carpenter@oracle.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>
Subject: Re: char-TPM: Adjustments for ten function implementations
Message-ID: <20171018202745.383724bc@kitsune.suse.cz>
In-Reply-To: <1508318326.6806.1.camel@perches.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <f9b35a67-bd7f-b140-bdc1-cb4886a6b1ea@users.sourceforge.net>
 <1508255833.3129.33.camel@HansenPartnership.com>
 <1508280210.6530.32.camel@perches.com>
 <bf7fc26c-bdc9-c752-72c7-f44c22f4a328@users.sourceforge.net>
 <1508318326.6806.1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Oct 2017 02:18:46 -0700
Joe Perches <joe@perches.com> wrote:

> On Wed, 2017-10-18 at 11:00 +0200, SF Markus Elfring wrote:
> > > The printk removals do change the objects.
> > > 
> > > The value of that type of change is only for resource limited
> > > systems.  
> > 
> > I imagine that such small code adjustments are also useful for
> > other systems.  
> 
> Your imagination and mine differ.
> Where do you _think_ it matters?
> 
> For instance, nothing about
> 
> 	sizeof(type)
> vs
> 	sizeof(*ptr)
> 
> makes it easier for a human to read the code.
> 

However, it makes it less error-prone to modify the code.

If you do ptr = malloc(sizeof(*ptr)) and later you change the type of
the pointer the code is still correct whereas ptr = malloc(sizeof(some
type) no longer is.

That is the reason the source analysis tool warns about this usage and
you do not really need any more explanation for *this* change.

The others are not so clear.

Thanks

Michal

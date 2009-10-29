Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62])
	by ozlabs.org (Postfix) with ESMTP id 11CA1B7BF9
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 15:07:39 +1100 (EST)
Subject: Re: [PATCH 1/6 v5] Kernel DLPAR Infrastructure
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1256785731.26770.38.camel@pasglop>
References: <4AE8ADCF.6090104@austin.ibm.com>
	<4AE8AF4D.4030403@austin.ibm.com> <1256785731.26770.38.camel@pasglop>
Content-Type: text/plain
Date: Wed, 28 Oct 2009 22:59:13 -0500
Message-Id: <1256788753.6279.165.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-29 at 14:08 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-10-28 at 15:53 -0500, Nathan Fontenot wrote:
> > +	struct device_node *dn;
> > +	struct device_node *first_dn = NULL;
> > +	struct device_node *last_dn = NULL;
> > +	struct property *property;
> > +	struct property *last_property = NULL;
> > +	struct cc_workarea *ccwa;
> > +	int cc_token;
> > +	int rc;
> > +
> > +	cc_token = rtas_token("ibm,configure-connector");
> > +	if (cc_token == RTAS_UNKNOWN_SERVICE)
> > +		return NULL;
> > +
> > +	spin_lock(&workarea_lock);
> > +
> > +	ccwa = (struct cc_workarea *)&workarea[0];
> > +	ccwa->drc_index = drc_index;
> > +	ccwa->zero = 0;
> 
> Popping a free page with gfp (or just kmalloc'ing 4K) would avoid the
> need for the lock too.

Not kmalloc -- the alignment of the buffer isn't guaranteed when
slub/slab debug is on, and iirc  the work area needs to be 4K-aligned.
__get_free_page should be fine, I think.

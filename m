Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C4411A0762
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 11:09:10 +1000 (AEST)
Message-ID: <1434676130.3678.124.camel@kernel.crashing.org>
Subject: Re: [PATCH] agp/uninorth: fix a memleak in create_gatt_table
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, airlied@gmail.com
Date: Fri, 19 Jun 2015 11:08:50 +1000
In-Reply-To: <CAOJe8K0UrsVQraHrxKUptOB9sVr_U9LEB3Ji6j4nMenHKNt2dg@mail.gmail.com>
References: <1434092231-4155-1-git-send-email-kda@linux-powerpc.org>
 <CAOJe8K0UrsVQraHrxKUptOB9sVr_U9LEB3Ji6j4nMenHKNt2dg@mail.gmail.com>
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

On Thu, 2015-06-18 at 17:34 +0300, Denis Kirjanov wrote:
> On 6/12/15, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> > Fix the memory leak in create_gatt_table:
> > we've lost a kfree on the exit path for the pages array allocated
> > in uninorth_create_gatt_table
> >
> > Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
> 
> Hi Ben, Michael
> 
> Will you take the patch through your trees or do I need to send it to
> Dave Airlie?

I haven't had a chance to review yet...

Ben.

> Thanks
> > ---
> >  drivers/char/agp/uninorth-agp.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/char/agp/uninorth-agp.c
> > b/drivers/char/agp/uninorth-agp.c
> > index a56ee9b..0575544 100644
> > --- a/drivers/char/agp/uninorth-agp.c
> > +++ b/drivers/char/agp/uninorth-agp.c
> > @@ -361,6 +361,10 @@ static int agp_uninorth_resume(struct pci_dev *pdev)
> >  }
> >  #endif /* CONFIG_PM */
> >
> > +static struct {
> > +	struct page **pages_arr;
> > +} uninorth_priv;
> > +
> >  static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
> >  {
> >  	char *table;
> > @@ -371,7 +375,6 @@ static int uninorth_create_gatt_table(struct
> > agp_bridge_data *bridge)
> >  	int i;
> >  	void *temp;
> >  	struct page *page;
> > -	struct page **pages;
> >
> >  	/* We can't handle 2 level gatt's */
> >  	if (bridge->driver->size_type == LVL2_APER_SIZE)
> > @@ -400,8 +403,8 @@ static int uninorth_create_gatt_table(struct
> > agp_bridge_data *bridge)
> >  	if (table == NULL)
> >  		return -ENOMEM;
> >
> > -	pages = kmalloc((1 << page_order) * sizeof(struct page*), GFP_KERNEL);
> > -	if (pages == NULL)
> > +	uninorth_priv.pages_arr = kmalloc((1 << page_order) * sizeof(struct
> > page*), GFP_KERNEL);
> > +	if (uninorth_priv.pages_arr == NULL)
> >  		goto enomem;
> >
> >  	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
> > @@ -409,14 +412,14 @@ static int uninorth_create_gatt_table(struct
> > agp_bridge_data *bridge)
> >  	for (page = virt_to_page(table), i = 0; page <= virt_to_page(table_end);
> >  	     page++, i++) {
> >  		SetPageReserved(page);
> > -		pages[i] = page;
> > +		uninorth_priv.pages_arr[i] = page;
> >  	}
> >
> >  	bridge->gatt_table_real = (u32 *) table;
> >  	/* Need to clear out any dirty data still sitting in caches */
> >  	flush_dcache_range((unsigned long)table,
> >  			   (unsigned long)table_end + 1);
> > -	bridge->gatt_table = vmap(pages, (1 << page_order), 0, PAGE_KERNEL_NCG);
> > +	bridge->gatt_table = vmap(uninorth_priv.pages_arr, (1 << page_order), 0,
> > PAGE_KERNEL_NCG);
> >
> >  	if (bridge->gatt_table == NULL)
> >  		goto enomem;
> > @@ -434,7 +437,7 @@ static int uninorth_create_gatt_table(struct
> > agp_bridge_data *bridge)
> >  	return 0;
> >
> >  enomem:
> > -	kfree(pages);
> > +	kfree(uninorth_priv.pages_arr);
> >  	if (table)
> >  		free_pages((unsigned long)table, page_order);
> >  	return -ENOMEM;
> > @@ -456,6 +459,7 @@ static int uninorth_free_gatt_table(struct
> > agp_bridge_data *bridge)
> >  	 */
> >
> >  	vunmap(bridge->gatt_table);
> > +	kfree(uninorth_priv.pages_arr);
> >  	table = (char *) bridge->gatt_table_real;
> >  	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
> >
> > --
> > 2.4.0
> >
> >

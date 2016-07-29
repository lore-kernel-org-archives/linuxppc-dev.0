Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s12T45k3kzDrPh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 18:48:54 +1000 (AEST)
Date: Fri, 29 Jul 2016 10:49:54 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: walter harms <wharms@bfs.de>
cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 kernel-janitors@vger.kernel.org, elfring@users.sourceforge.net,
 julia.lawall@lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: replace loop with for_each_child_of_node(), remove
 unneeded of_node_put()
In-Reply-To: <579B1802.7070102@bfs.de>
Message-ID: <alpine.DEB.2.10.1607291049380.2161@hadrien>
References: <601fb58c-7aee-91ce-2a3d-7a29787968fc@au1.ibm.com>
 <1469764534-26948-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <579B1802.7070102@bfs.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Fri, 29 Jul 2016, walter harms wrote:

>
>
> Am 29.07.2016 05:55, schrieb Andrew Donnellan:
> > Rewrite the cxl_guest_init_afu() loop in cxl_of_probe() to use
> > for_each_child_of_node() rather than a hand-coded for loop.
> >
> > Remove the useless of_node_put(afu_np) call after the loop, where it's
> > guaranteed that afu_np == NULL.
> >
> > Reported-by: SF Markus Elfring <elfring@users.sourceforge.net>
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> >
> > ---
> >
> > Checked the of_node_put() with Fred, he thinks it was probably just left
> > over from an earlier private version of the code and we can just get rid of
> > it.
> > ---
> >  drivers/misc/cxl/of.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> > index edc4583..ec175ea 100644
> > --- a/drivers/misc/cxl/of.c
> > +++ b/drivers/misc/cxl/of.c
> > @@ -460,7 +460,7 @@ int cxl_of_probe(struct platform_device *pdev)
> >  	struct device_node *afu_np = NULL;
> >  	struct cxl *adapter = NULL;
> >  	int ret;
> > -	int slice, slice_ok;
> > +	int slice = 0, slice_ok = 0;
> >
> >  	pr_devel("in %s\n", __func__);
> >
> > @@ -476,13 +476,13 @@ int cxl_of_probe(struct platform_device *pdev)
> >  	}
> >
> >  	/* init afu */
> > -	slice_ok = 0;
> > -	for (afu_np = NULL, slice = 0; (afu_np = of_get_next_child(np, afu_np)); slice++) {
> > +	for_each_child_of_node(np, afu_np) {
> >  		if ((ret = cxl_guest_init_afu(adapter, slice, afu_np)))
> >  			dev_err(&pdev->dev, "AFU %i failed to initialise: %i\n",
> >  				slice, ret);
> >  		else
> >  			slice_ok++;
> > +		slice++;
> >  	}
>
> while you are here ..
> you could move the assign out of the condition..
>
> ret = cxl_guest_init_afu(adapter, slice, afu_np);
> if (ret) ....

Yes, please.

julia


>
> just my 2 cents,
>
> re,
>  wh
>
> >
> >  	if (slice_ok == 0) {
> > @@ -490,8 +490,6 @@ int cxl_of_probe(struct platform_device *pdev)
> >  		adapter->slices = 0;
> >  	}
> >
> > -	if (afu_np)
> > -		of_node_put(afu_np);
> >  	return 0;
> >  }
> >
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

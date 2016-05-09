Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3HTc2bX8zDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 19:41:56 +1000 (AEST)
Message-ID: <1462786915.5531.3.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Update of_remove_property() call sites to
 remove null checking
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Tyrel Datwyler
 <tyreld@linux.vnet.ibm.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: grant.likely@linaro.org, frowand.list@gmail.com, robh+dt@kernel.org,
 paulus@samba.org
Date: Mon, 09 May 2016 19:41:55 +1000
In-Reply-To: <572C08DB.9000109@gmail.com>
References: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
 <1461821695-19204-2-git-send-email-sjitindarsingh@gmail.com>
 <57292702.5070507@linux.vnet.ibm.com>
 <1462431031.12473.3.camel@ellerman.id.au> <572C08DB.9000109@gmail.com>
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

On Fri, 2016-05-06 at 13:00 +1000, Suraj Jitindar Singh wrote:
> On 05/05/16 16:50, Michael Ellerman wrote:
> > On Tue, 2016-05-03 at 15:32 -0700, Tyrel Datwyler wrote:
> > > On 04/27/2016 10:34 PM, Suraj Jitindar Singh wrote:
> > > > diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> > > > index ceb18d3..a560a98 100644
> > > > --- a/arch/powerpc/platforms/pseries/mobility.c
> > > > +++ b/arch/powerpc/platforms/pseries/mobility.c
> > > > @@ -191,8 +191,8 @@ static int update_dt_node(__be32 phandle, s32 scope)
> > > >  				break;
> > > >  
> > > >  			case 0x80000000:
> > > > -				prop = of_find_property(dn, prop_name, NULL);
> > > > -				of_remove_property(dn, prop);
> > > > +				of_remove_property(dn, of_find_property(dn,
> > > > +							prop_name, NULL));
> > > >  				prop = NULL;
> > > >  				break;
> > > > 
> > > You haven't removed a NULL check here, as suggested by the changelog,
> > > but instead made a cosmetic change to the code that still leaves behind
> > > a now unnecessary "prop = NULL;" to bit rot.

> > Yeah I think you're right. Though it's not very clear how prop is used in that
> > function.
>
> I didn't delete the prop = NULL; initially as I didn't fully understand
> how it was used in the rest of the function and the effect of deleting
> it.

Yeah, it's pretty convoluted. I don't think you can actually prove it's safe to
remove the prop = NULL for arbitrary inputs.

cheers

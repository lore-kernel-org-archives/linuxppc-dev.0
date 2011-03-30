Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4FCC5B6EF7
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2011 01:31:20 +1100 (EST)
Received: by gxk27 with SMTP id 27so654203gxk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Mar 2011 07:31:16 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 30 Mar 2011 08:31:13 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: checking status semantics with compatible functions
Message-ID: <20110330143113.GA13685@ponder.secretlab.ca>
References: <9BC4C90E-090F-4961-A242-10D769C08738@kernel.crashing.org>
	<C1B3133E-0EEE-49E9-9E3A-35026CFA78E9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C1B3133E-0EEE-49E9-9E3A-35026CFA78E9@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 30, 2011 at 03:26:29AM -0500, Kumar Gala wrote:
> [Adding proper lists on CC]
> 
> - k
> 
> On Mar 30, 2011, at 3:07 AM, Kumar Gala wrote:
> 
> > Grant,
> > 
> > We have a few helper functions like:
> > 
> > drivers/of/base.c:EXPORT_SYMBOL(of_device_is_compatible);
> > drivers/of/base.c:EXPORT_SYMBOL(of_find_compatible_node);
> > 
> > That we use in places like arch/powerpc/platform/85xx/mpc85xx_ds.c:
> > 
> >        for_each_node_by_type(np, "pci") {
> >                if (of_device_is_compatible(np, "fsl,mpc8540-pci") ||
> >                    of_device_is_compatible(np, "fsl,mpc8548-pcie") ||
> >                    of_device_is_compatible(np, "fsl,p2020-pcie")) {
> > 
> > It seems like we should check 'status' in these cases with
> > 'of_device_is_available'.  I'm thinking that we should have
> > versions of the helpers that also do the 'of_device_is_available'
> > checking.  Or should we just change the helpers to call
> > of_device_is_available?

Yes, of_device_is_available() should be checked, but it should not be
added directly to of_device_is_compatible().  I'm okay with adding
a helper variant that does the of_device_is_compatible() check.

In that particular case, I'd also suggest using for_each_matching_node().

g.

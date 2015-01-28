Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C2221A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 17:07:46 +1100 (AEDT)
Message-ID: <1422425265.11009.1.camel@ellerman.id.au>
Subject: Re: [PATCH] CXL: Fix device_node reference counting
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Date: Wed, 28 Jan 2015 17:07:45 +1100
In-Reply-To: <1422423577-sup-6588@delenn.ozlabs.ibm.com>
References: <1420609278-15338-1-git-send-email-imunsie@au.ibm.com>
 <1422417621-sup-4057@delenn.ozlabs.ibm.com>
 <1422421480.2728.1.camel@ellerman.id.au>
 <1422423577-sup-6588@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 16:53 +1100, Ian Munsie wrote:
> Excerpts from Michael Ellerman's message of 2015-01-28 16:04:40 +1100:
> > > I just wanted to check the status of this one? I can't see it in your
> > > tree and wanted to make sure you didn't simply miss it.
> > 
> > It looked fishy, but I never got around to replying.
> > 
> > The second sentence in the explanation should never be true:
> 
> Right, that was the point of the fix ;)

Sure, but bodging of_node_get()s all over the place is not a path to success.

> > You shouldn't have np unless you did an of_node_get() to get it, otherwise it's
> > pointing at something you don't have a reference for and it might go away at
> > any time.
> > 
> > So the patch may fix the bug but I don't think it's correct.
> > 
> > I think pnv_pci_to_phb_node() should be doing a get for you, before returning
> > the pointer.
> 
> Agreed - we should probably also rename it to have 'get' in the name,
> like pnv_pci_get_phb_node().

Yep.

> > See as a comparison pcibios_get_phb_of_node().
> 
> We could almost use that instead, except it's not exported for modules
> and I'm not sure if that even works with __weak functions?

It should. It's only weak until the final link and then you get a non-weak
version AIUI.

Try it.

And a follow up patch to have it use pci_bus_to_host() would be nice too.

cheers

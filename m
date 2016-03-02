Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73FAB1A01D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 12:47:06 +1100 (AEDT)
Message-ID: <1456883226.24490.4.camel@ellerman.id.au>
Subject: Re: [3/3] powerpc/pseries: Cleanup property cloning in memory dlpar
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 02 Mar 2016 12:47:06 +1100
In-Reply-To: <20160301230231.DA2A81402D8@ozlabs.org>
References: <20160301230231.DA2A81402D8@ozlabs.org>
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

On Wed, 2016-03-02 at 10:02 +1100, Michael Ellerman wrote:
> On Wed, 2016-10-02 at 17:13:29 UTC, Nathan Fontenot wrote:
> > Now that the DLPAR add/remove flow updates the ibm,dynamic-memory device
> > tree property each time we add or remove a LMB the work needed to clone
> > this property can be reduced.
> > 
> > Prior to performing any memory DLPAR operation we now clone the device
> > tree property once and convert it to cpu format. This copy is then used
> > to walk through LMBs as we process them and is thrown away when we
> > are finished. There is no longer a need to convert the entire property to
> > cpu format and then back to BE every time we update it, we can just parse
> > it in its native BE format and update the one LMB we need to modify
> > before updating the property.
> > 
> > This patch removes the BE => cpu conversion step in the clone routine and
> > creates a drconf_property_to_cpu() routine to make this conversion for the
> > one time we need to convert the entire property. This then allows us
> > to remove dlpar_update_drconf_property() since we can now do everything
> > in dlpar_update_device_tree_lmb().
> 
> Hi Nathan,
> 
> This sounds like a good cleanup on the face of it.
> 
> But even with it applied I still see a boat load of endian errors from sparse
> in this file. That worries me, can you please try and fix them.

I can merge patches 1 and 2 if you like, and leave this one for you to fixup?
Or I can just wait for a v2 of the whole series. Let me know which you'd
prefer.

cheers

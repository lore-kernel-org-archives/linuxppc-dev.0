Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <4aa09b6017041c7fe43b9138a19d9c65@embeddededge.com>
References: <1116984651.6395.60.camel@gaston>
	<2d61cb60140e879d0c8d46e7f51a9f56@freescale.com>
	<1116987700.6395.64.camel@gaston>
	<4aa09b6017041c7fe43b9138a19d9c65@embeddededge.com>
Content-Type: text/plain
Date: Wed, 25 May 2005 15:20:26 +1000
Message-Id: <1116998427.6395.86.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-05-25 at 01:14 -0400, Dan Malek wrote:
> On May 24, 2005, at 10:21 PM, Benjamin Herrenschmidt wrote:
> 
> > Do we really ever need them for anything but RAM mapping ?
> 
> Of course.  We use BATs and CAMs to address a variety of
> mapping options.
> 
> > How do we implement io_block_mapping() on CPUs without a hash table ?
> 
> What does a hash table have to do with anything?  The io_block_mapping()
> is most important on processors that don't have them, like 8xx, 82xx, 
> 83xx,
> and 85xx.   The hash table in Linux is just an unfortunate staging area 
> for PTEs.

Sorry, I meant BATs or equivalent... (see POWER4 for example who has
none of this)
> 
> The io_block_mapping() simply loads BATs, CAMs, or init's page tables.

Ok, that was my point... since init page tables can be loaded by it, why
not make ioremap work that early and do the same ? The problem is of
course allocating the pte pages but how does io_block_mapping() do on
CPUS without BAT/CAMs/whatever ?

> > .....  We
> > need page tables for these so we can have ioremap working.
> 
> The problem is you need more than page tables.  We have kernel page
> tables very early in the initialization.  

We have the pgdir, but not the PTE pages...

> The problem with ioremap() is if you
> haven't done something (like io_block_mapping()) to set up BATs or CAMs,
> it will call vmalloc() to get some VM space.  This is where the problem 
> lies.

No, we have a trick with ioremap_bot, we don't need to get vmalloc space
for ioremap to work early. In fact, it would be nice to just have
io_block_mapping be able to "dynamically" allocate virtual space using
the same mecanism instead of beeing passed a virtual address. That would
fix most of the problems with hard coded 1:1 mappings.
> 
> > ... On CPUs with
> > a hash, we could just shove entries in the hash... though we may need a
> > mecanism to bolt them or convert those mappings to page tables once
> > those are available.
> 
> We don't need anything that complicated.  As I said, this already works 
> on
> all processors that don't have hash tables.
> 
> We need to make ioremap() much, much smarter, plus we need some kind
> of board specific function to set up the BATs or CAMs, like 
> io_block_mapping()
> does today.

Well, my problem is with hard-coded v:p mappings... If we can simply
have io_block_mapping take, for example, 0 for v (or -1) and use the
ioremap_bot trick to "allocate" virtual space, that would make me happy
(it needs to return the allocated address too).

Ben.

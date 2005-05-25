Return-Path: <dan@embeddededge.com>
In-Reply-To: <1116987700.6395.64.camel@gaston>
References: <1116984651.6395.60.camel@gaston>
	<2d61cb60140e879d0c8d46e7f51a9f56@freescale.com>
	<1116987700.6395.64.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4aa09b6017041c7fe43b9138a19d9c65@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 25 May 2005 01:14:01 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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


On May 24, 2005, at 10:21 PM, Benjamin Herrenschmidt wrote:

> Do we really ever need them for anything but RAM mapping ?

Of course.  We use BATs and CAMs to address a variety of
mapping options.

> How do we implement io_block_mapping() on CPUs without a hash table ?

What does a hash table have to do with anything?  The io_block_mapping()
is most important on processors that don't have them, like 8xx, 82xx, 
83xx,
and 85xx.   The hash table in Linux is just an unfortunate staging area 
for PTEs.

The io_block_mapping() simply loads BATs, CAMs, or init's page tables.

> .....  We
> need page tables for these so we can have ioremap working.

The problem is you need more than page tables.  We have kernel page
tables very early in the initialization.  The problem with ioremap() is 
if you
haven't done something (like io_block_mapping()) to set up BATs or CAMs,
it will call vmalloc() to get some VM space.  This is where the problem 
lies.

> ... On CPUs with
> a hash, we could just shove entries in the hash... though we may need a
> mecanism to bolt them or convert those mappings to page tables once
> those are available.

We don't need anything that complicated.  As I said, this already works 
on
all processors that don't have hash tables.

We need to make ioremap() much, much smarter, plus we need some kind
of board specific function to set up the BATs or CAMs, like 
io_block_mapping()
does today.


Thanks.


	-- Dan

Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <99151309fed9dc6d9649e5e9a1299d6e@embeddededge.com>
References: <1116984651.6395.60.camel@gaston>
	<99151309fed9dc6d9649e5e9a1299d6e@embeddededge.com>
Content-Type: text/plain
Date: Wed, 25 May 2005 15:15:39 +1000
Message-Id: <1116998140.6395.81.camel@gaston>
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

On Wed, 2005-05-25 at 00:45 -0400, Dan Malek wrote:
> On May 24, 2005, at 9:30 PM, Benjamin Herrenschmidt wrote:
> 
> > As the subject says ... it's the source of endless headaches, is used 
> > in
> > a way that often prevents moving TASK_SIZE freely, etc etc etc...
> 
> Why are you so obsessed about this? :-)  We all know what it does
> and the limitations.  If someone wants to use it in addition to other
> kernel configuration options, their particular start up code will have
> to be modified to accept this.

We don't "all" know :) It's very easily misused... 

> > What are the good and unavoidable uses of it currently that cannot be
> > replaced by some sort of ioremap ?
> >
> > (Note that if the answer to the above is: page tables exist too late,
> 
> That's one reason.  The other is to pin BATs or large page table entries
> for more efficient access.

True.

> > ....  I
> > already have a reply: our initialisations happen too early, let's move
> > things around so that ioremap is useable
> 
> In most cases you can't do this.  There are boards that have to map
> serial ports for kgdb or early console debugging.

How do they map ? pinning TLBs ? ioremap can do that... ioremap can be
made to work very very early ...
 
> There are also
> boards that need access to local hardware registers to set up that
> early.  You may need to map a rom or some other non-volatile storage
> to get some system parameters.

Ok, well, it's really just requesting for comment here, I don't say I
will kill it, just wondering ...

Ben.

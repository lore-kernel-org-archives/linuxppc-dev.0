Return-Path: <dan@embeddededge.com>
In-Reply-To: <1116984651.6395.60.camel@gaston>
References: <1116984651.6395.60.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <99151309fed9dc6d9649e5e9a1299d6e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 25 May 2005 00:45:09 -0400
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


On May 24, 2005, at 9:30 PM, Benjamin Herrenschmidt wrote:

> As the subject says ... it's the source of endless headaches, is used 
> in
> a way that often prevents moving TASK_SIZE freely, etc etc etc...

Why are you so obsessed about this? :-)  We all know what it does
and the limitations.  If someone wants to use it in addition to other
kernel configuration options, their particular start up code will have
to be modified to accept this.

> What are the good and unavoidable uses of it currently that cannot be
> replaced by some sort of ioremap ?
>
> (Note that if the answer to the above is: page tables exist too late,

That's one reason.  The other is to pin BATs or large page table entries
for more efficient access.

> ....  I
> already have a reply: our initialisations happen too early, let's move
> things around so that ioremap is useable

In most cases you can't do this.  There are boards that have to map
serial ports for kgdb or early console debugging.  There are also
boards that need access to local hardware registers to set up that
early.  You may need to map a rom or some other non-volatile storage
to get some system parameters.

Thanks.


	-- Dan

Return-Path: <dan@embeddededge.com>
In-Reply-To: <362472e35e6672011614c2710183e778@freescale.com>
References: <1116987700.6395.64.camel@gaston>
	<362472e35e6672011614c2710183e778@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8818d51720e46592f49178f803ed2f0b@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 25 May 2005 01:00:10 -0400
To: Kumar Gala <kumar.gala@freescale.com>
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


On May 24, 2005, at 10:30 PM, Kumar Gala wrote:

> I know what I've done in the past is either steal a BAT (83xx) or CAM 
> (85xx) entry and then free it up when a proper ioremap can be done 
> later.

This is even more of a hack than io_block_mapping() because it is often
obscure and not documented.  Several boards have done this in the past
as well.  It's "magic" that occurs, what seems to be minor code changes
often cause this to break and makes debugging more complex :-)

> No, as far as a can tell doing a quick glance if we drop 
> io_block_mapping than we can drop setup_io_mappings().

We've got to have something to address the board unique requirements
that are currently satisfied by this.

There is a real problem that we have to solve.  Some boards just need
access to mapped hardware before the VM is set up.  You can't just
remove a feature or tell them their design is wrong.  I don't think 
obscure
mapping tricks are the solution, either.

The only solution is to make ioremap() smart enough to properly use
BATs and CAMs that are available to a processor.   I suspect this is 
going
to lead to a bunch of also undesirable configuration options to address
the customizations necessary.

Thanks.


	-- Dan

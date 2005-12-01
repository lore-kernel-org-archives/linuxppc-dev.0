Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 8FA1968865
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 05:56:24 +1100 (EST)
Date: Thu, 1 Dec 2005 11:56:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Message-ID: <20051201115621.B4701@cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B8594B6@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8594B6@ismail.innsys.innovsys.com>;
	from runet@innovsys.com on Thu, Dec 01, 2005 at 12:43:02PM -0600
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 32bits and big RAM mapping problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 01, 2005 at 12:43:02PM -0600, Rune Torgersen wrote:
> > -----Original Message-----
> > From: Laurent Lagrange
> > Sent: Thursday, December 01, 2005 11:48
> > To: linuxppc-embedded@ozlabs.org
> > Subject: PPC 32bits and big RAM mapping problem
> 
> > So I'm under the impression to be cornered in my shoes.
> > Any idea, book, article, prediction would be welcome.
> 
> I have 2GB of ram working on my PPC32 board.
> 
> You have to change the following in the kernel config:
> Under Advanced Setup:
> 	Set Maximum Low memory (Set to 0x40000000)
> 	Set Custom Kernel config address (Set to 0xA0000000)
> 
> I do not remember if I had to change anything else.

If you have 2GB you had to have something else. Right now
you have it set to constrict the max lowmem to 1GB. So,
you must have CONFIG_HIGHMEM on as well to utilize the
other 1GB.

To answer the original poster's question: simply enable
CONFIG_HIGHMEM and UP system will have 768MB in lowmem and
the rest in highmem.  If there's some constraint on your
application (like many embedded apps) that requires all
2GB in lowmem then configure:

Set Maximum low memory (Set to 0x80000000)
Set custom kernel base address (Set to 0x40000000)
Set custom user task size (Set to 0x40000000)

Don't do this unless highmem won't work for your app. If you
use this approach each process will be limited to 1GB of virtual
memory which may or may not be an OK tradeoff for your app.

-Matt

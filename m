Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx2.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31CB9DDF02
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 17:46:41 +1000 (EST)
Date: Wed, 09 Apr 2008 16:46:31 +0900 (JST)
Message-Id: <20080409.164631.-1300534920.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
In-Reply-To: <1207295412.10388.364.camel@pasglop>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Fri, 2008-04-04 at 15:42 +0900, Ishizaki Kou wrote:
> > 
> > As you pointed, spider I/O functions in Cell blades need 2 step
> > indirections by our patch. Shall I make another one for Cell blades
> > whose spider I/O functions need one step indirection?
> > (But you will need 2 step indirections when you use PCI-ex.)
> 
> I think the blades will need the same stuff as celleb since it's
> possible to use the PCI-Express on them too.
> 
> Maybe an option is to do a if () / else statement rather than a function
> pointer in there, it would at least be cheaper in term of CPU cycle
> don't you think ? Anyway, do as you prefer.

I want to keep my patch as it is, because I think it is easier to add
function pointers than if () / else statement when someone adds new
I/O functions to the io-workaround. For 2.6.27 or later, I think about
adding null I/O functions for Celleb internal pci bus to reduce
overhead for searching bus.

Best regards,
Kou Ishizaki

Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id E04B267CB4
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 01:16:34 +1000 (EST)
In-Reply-To: <1159941148.13323.6.camel@localhost.localdomain>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<1159941148.13323.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <80EE3621-ED80-408E-BF04-BA3CB985C769@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 4 Oct 2006 10:57:42 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 4, 2006, at 1:52 AM, Benjamin Herrenschmidt wrote:

> I don't see how a mecanism of feature call at the board support  
> level is
> in any way incompatible with the device-tree thing.

It isn't.

> ...  I'm happy mixing
> both on powermac :)

I know.  This was just an opportunity to make people
realize that a board port does require the writing of
some board specific code.  Using the feature call is
an excellent model of portability and flexibility.  My
point was that any BCSR access is necessary to be
hidden behind such a function, because it is truly
board specific.  You can't require the drivers to
have this kind of logic in them, they must call out
to board support functions for assistance.

Just like the powermac ports, embedded drivers
will need a feature call at some points during
their processing (set up clock routing, IO pin
configuration, board specific bus connections,
power management, etc).  Some board ports
may do nothing, others may do lots of work.

Therefore, I see no reason why a BSCR address
and all of it's associated format can't simply
be a #define in a board specific file.  There is no
need for this in the device tree.


	-- Dan

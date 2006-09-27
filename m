Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.mud.yahoo.com (smtp104.biz.mail.mud.yahoo.com
	[68.142.200.252]) by ozlabs.org (Postfix) with SMTP id C413467BB5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 00:48:54 +1000 (EST)
In-Reply-To: <20060927165556.04c8d5d7@vitb.ru.mvista.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 27 Sep 2006 10:42:17 -0400
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 27, 2006, at 8:55 AM, Vitaly Bordug wrote:

> hence let's open a discussion what others think about that. The  
> problem seems common (and for some boards
> is called somewhat else apparently), but at this point we should  
> come to some conclusion, document it, and use it.

Well, I haven't voiced my opinion lately..........  :-)

I think this is totally out of control.  I don't even know what
we are trying to create here any more.  We took a reasonable
idea to express some configuration flexibility and are running
off into into some world that we think we need to create
something infinitely flexible that anyone can use for anything
they wish.  I could expect this from a university research
project, but not from seasoned developers that are trying
to create products where only a few real configuration
combinations make sense.

Since BCSRs are board specific, does anyone remember
the day when a simple #define, ioremap, and a few lines
of code in the board setup file was all that was needed? :-)
What wrong with still doing that?  It seems everyone is
obsessed with device tree syntax and forget that a
few lines of code may still be a reasonable solution.

I still think an embedded_feature_call() support in a
board port would be the best solution to many of these
complex things we are trying to define in this device
tree information.  In the places where we need some
kind of board specific support, like hardware set up for
some peripheral, just do the feature_call, passing enough
information to indicate what is needed, and let the
board support do what is necessary.  This could be
setting bits in a BCSR, setting up the processor IO
ports, enabling power to external logic, etc.  This has
been proven to work well on the PMAC, just extend it
to be used on embedded boards.

Thanks.

	-- Dan

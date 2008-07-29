Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 974C2DDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 19:01:33 +1000 (EST)
Subject: Re: [PATCH] powerpc/lpar - defer prefered console setup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bastian Blank <waldi@debian.org>
In-Reply-To: <20080729080727.GA32595@wavehammer.waldi.eu.org>
References: <20080728185651.GA29530@wavehammer.waldi.eu.org>
	<1217300778.11188.233.camel@pasglop>
	<20080729073611.GA30627@wavehammer.waldi.eu.org>
	<1217317404.11188.242.camel@pasglop>
	<20080729080727.GA32595@wavehammer.waldi.eu.org>
Content-Type: text/plain
Date: Tue, 29 Jul 2008 19:00:47 +1000
Message-Id: <1217322047.11188.244.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-29 at 10:07 +0200, Bastian Blank wrote:
> > Hrm... we do most of the console discovery from console_initcall for
> > legacy UARTs. see the code in legacy_serial.c, we just avoid doing
> > the add_preferred_console() thingy if there's a console= on the
> command
> > line :-)
> 
> The code did that, but the check was removed because it trips on
> netconsole=. See 5faae2e5d1f53df9dce482032c8486bc3a1feffc.

Argh. That's a mess. Well, legacy_serial still does that :-)

Ben.

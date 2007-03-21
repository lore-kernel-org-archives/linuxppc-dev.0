Return-Path: <david-b@pacbell.net>
Received: from smtp109.sbc.mail.re2.yahoo.com (smtp109.sbc.mail.re2.yahoo.com
	[68.142.229.96]) by ozlabs.org (Postfix) with SMTP id 655A8DDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 09:07:52 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
Date: Wed, 21 Mar 2007 13:47:49 -0700
References: <20070319105352.771599000@sipsolutions.net>
	<1174315651.5044.4.camel@localhost.localdomain>
	<Pine.LNX.4.60.0703192236420.10137@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0703192236420.10137@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703211347.50221.david-b@pacbell.net>
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 19 March 2007 2:51 pm, Guennadi Liakhovetski wrote:

> David, what's the status of that your patch?

Those RTC framework changes are now in the MM tree, and I expect they will
merge soon after the 2.6.22 merge window opens.


One related topic to consider:  the I2C stack is also getting updated
to (finally!!) leverage about the driver model.  If those changes aren't
in the MM tree yet, they will be soonish.  This means that the RTCs based
on I2C will be converted to use a different config scheme(*) ... and that
board init code will need updates to support it.

Boards using RTCs that hook up without I2C could convert to the generic RTC
framework at any time after those RTC core changes merge.  But when I2C is
involved, some other conversions will be in the mix too.  Me, I have no idea
what PPC platforms combine PM, RTC, and I2C.  :)

- Dave

(*) Most of the I2C based RTCs rely on kernel command line parameters,
    because of the vagaries of I2C.  "New style" I2C drivers will replace
    command line declarations ("rv5c386 RTC on bus 0 at address 0x32")
    with ones in the board specific init logic.

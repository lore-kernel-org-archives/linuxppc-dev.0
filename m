Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 746A4DE480
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 04:55:05 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/4] powerpc/qe: new call to revert a gpio to a dedicated
	function
Date: Wed, 24 Sep 2008 11:54:59 -0700
References: <20080924000255.GA28054@oksana.dev.rtsoft.ru>
	<B8BAAB1F-10B5-419D-84A7-F724A7E77F41@kernel.crashing.org>
	<20080924114231.GA8469@oksana.dev.rtsoft.ru>
In-Reply-To: <20080924114231.GA8469@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809241155.00814.david-b@pacbell.net>
Cc: Greg Kroah-Hartman <greg@kroah.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 September 2008, Anton Vorontsov wrote:
> > what do you mean by dedicated function.. be a bit clearer in the commit 
> > log.
> 
> This term is from the QE spec, I didn't invent anything. ;-)
> 
> "Each pin in the I/O ports can be configured as a general-purpose
> I/O signal or as a dedicated peripheral interface signal. ...many
> dedicated peripheral functions are multiplexed onto the ports."

Which, to me, highlights the point I've made previously:  the
right abstraction for you to work with is "pin", not GPIO.

You need to switch a QE "pin" from one of its roles to the other.

Evil things, like oopsing, will happen if you try to use this call
on a GPIO that's not backed by a QE pin.

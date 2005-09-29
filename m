Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 27817683BC
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Sep 2005 06:37:28 +1000 (EST)
Date: Thu, 29 Sep 2005 13:36:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Corey Minyard <minyard@acm.org>
Message-ID: <20050929203647.GA6597@mag.az.mvista.com>
References: <20050929183221.GA17292@i2.minyard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050929183221.GA17292@i2.minyard.local>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: MV64x60 watchdog timer driver updates
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 29, 2005 at 01:32:21PM -0500, Corey Minyard wrote:
> James looked at an earlier version and said it was ok, and suggested
> a few changes.  This has been tested against 2.6.14-rc2 on a Katana.
> 
> Note that the bus_clk value from the platform information seems to
> be in MHZ, but the actual frequency is generally 133,333,333, not
> 133,000,000.  I don't think the inaccuracy matters here, but it seems
> a little odd.

Yes, it makes more sense to me to pass the actual frequency and not do
the '* 1000000'.

Also--I should have thought of this earlier--there should probably be a
patch to add a default platform_data entry in arch/ppc/syslib/mv64x60.c
and a patch for katana.c if the defaults in mv64x60.c aren't correct
for the katana.  At least, that's how things are done now.

Mark

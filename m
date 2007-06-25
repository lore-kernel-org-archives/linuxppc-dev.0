Return-Path: <dgibson@ozlabs.org>
Date: Mon, 25 Jun 2007 13:33:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] Create add_rtc() function to enable the RTC CMOS driver
Message-ID: <20070625033348.GC9763@localhost.localdomain>
References: <1182298510.5674.358.camel@rhino> <1182358772.5674.383.camel@rhino>
	<20070622033158.GA21419@localhost.localdomain>
	<ba34492532ac9dfd43bd9f2ae427deef@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ba34492532ac9dfd43bd9f2ae427deef@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 22, 2007 at 09:56:24AM +0200, Segher Boessenkool wrote:
> > Hrm.  It seems rather specific.  Can we do this more generally, by
> > creating an of_platform device which binds to rtc nodes, then
> > registers an appropriate platform device for each so that the generic
> > rtc drivers pick them up.  Obviously we'd need some sort of table
> > mapping the device node compatible properties to the appropriate
> > platform device names.
> 
> >> +	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
> >> +	 * address provided by the device node matches.
> >> +	 */
> >> +	if (res.start != RTC_PORT(0)) {
> >> +		of_node_put(np);
> >> +		return -ENODEV;
> >> +	}
> >
> > This looks totally bogus.  If we have a device tree we should be using
> > the address information from there, not using hardcoded magic.  Sounds
> > like asm/mc146818rtc.h needs some serious fixing.
> 
> Both of your comments would be nice extensions (and the right
> way forwards), but Wade's patch is good as-is already.

True enough.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

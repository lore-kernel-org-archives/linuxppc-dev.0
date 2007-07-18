Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25352DDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 07:55:14 +1000 (EST)
Subject: Re: [PATCH] Add StorCenter DTS first draft.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <5F6EB5F7-C5AE-437F-9DF1-22FE38D7A841@kernel.crashing.org>
References: <E1IAnwC-0003Xm-6U@jdl.com>
	<1184722754.25235.183.camel@localhost.localdomain>
	<5F6EB5F7-C5AE-437F-9DF1-22FE38D7A841@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 07:54:38 +1000
Message-Id: <1184795678.25235.269.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-18 at 18:13 +0200, Segher Boessenkool wrote:
> >> +		PowerPC,603e {			/* Really 8241 */
> >> +			device_type = "cpu";
> >> +			reg = <0>;
> >> +			clock-frequency = <d# 200000000>;	/* Hz */
> >> +			timebase-frequency = <d# 33333333>;	/* Hz */
> >> +			bus-frequency = <0>;
> >> +			/* Following required by dtc but not used */
> >> +			i-cache-line-size = <0>;
> >> +			d-cache-line-size = <0>;
> >> +			i-cache-size = <4000>;
> >> +			d-cache-size = <4000>;
> >> +		};
> >
> > The 32 bits kernel may not be using those yet, but it will. 64 bits  
> > does
> > already and I plan to merge those bits at one point.
> 
> Hrm, what does it use it for?  Are you going to require
> all other defined CPU properties as well (like the PowerPC
> binding does)?

Cache line size is used by the kernel on ppc64 for things like clearing
memory (to get the stride between subsequent dcbz) or flushing the
cache :-) It's also passed on to userland.

If it's absent from the device-tree, we default to the values in the
cputable, but if you're going to put the properties in the tree, don't
put a 0 in there. As it is, the day I make the 64 bits code common, your
DT will break unless I special case "0".

Ben.

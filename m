Return-Path: <imp@bsdimp.com>
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 588DEB7109
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Aug 2010 01:56:41 +1000 (EST)
Date: Fri, 27 Aug 2010 09:35:21 -0600 (MDT)
Message-Id: <20100827.093521.467748298504420477.imp@bsdimp.com>
To: richardcochran@gmail.com
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20100827140205.GA3293@riccoc20.at.omicron.at>
References: <20100827075727.GA3818@riccoc20.at.omicron.at>
	<20100827134154.50eef56c@lxorguk.ukuu.org.uk>
	<20100827140205.GA3293@riccoc20.at.omicron.at>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: giometti@linux.it, johnstul@us.ibm.com, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	christian.riesch@omicron.at, alan@lxorguk.ukuu.org.uk, khc@pm.waw.pl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In message: <20100827140205.GA3293@riccoc20.at.omicron.at>
            Richard Cochran <richardcochran@gmail.com> writes:
: On Fri, Aug 27, 2010 at 01:41:54PM +0100, Alan Cox wrote:
: > > The master node in a PTP network probably takes its time from a
: > > precise external time source, like GPS. The GPS provides a 1 PPS
: > > directly to the PTP clock hardware, which latches the PTP hardware
: > > clock time on the PPS edge. This provides one sample as input to a
: > > clock servo (in the PTPd) that, in turn, regulates the PTP clock
: > > hardware.
: > 
: > A PTP clock is TAI, Unix time is UTC.
: 
: But TAI and UTC progress at the same rate, and UTC differs from TAI by
: a constant offset. In fact, the needed conversion is provided by the
: protocol, so it is not hard to take a 1 PPS from GPS and set the PTP
: clock to TAI.

Except for leap seconds, this is true.   However, Unix time isn't UTC
either.  Unix time is UTC that pretends leap seconds just don't
exist.  POSIX enshrined this long ago, and nobody is going to change
that any time soon.

I don't believe IEEEv2 propagates leap seconds, does it?

Warner

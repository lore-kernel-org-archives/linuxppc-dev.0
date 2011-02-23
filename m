Return-Path: <scottwood@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48162B719F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 04:27:05 +1100 (EST)
Date: Wed, 23 Feb 2011 11:26:12 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found on
	the MPC85xx.
Message-ID: <20110223112612.30071995@schlenkerla>
In-Reply-To: <20110223165058.GE14597@angua.secretlab.ca>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Mike Frysinger <vapier@gentoo.org>, Christoph Lameter <cl@linux.com>,
	Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rodolfo Giometti <giometti@linux.it>, devicetree-discuss@lists.ozlabs.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 23 Feb 2011 09:50:58 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Wed, Feb 23, 2011 at 11:38:17AM +0100, Richard Cochran wrote:
> > +
> > +* Gianfar PTP clock nodes
> > +
> > +General Properties:
> > +
> > +  - compatible   Should be "fsl,etsec-ptp"
> 
> Should specify an *exact* part; ie: "fsl,mpc8313-etsec-ptp" instead of
> trying to define a generic catchall.  The reason is that the same
> marketing name can end up getting applied to a wide range of parts.
> 
> Instead, choose one specific device to stand in as the 'common'
> implementation and get all parts with the same core to claim
> compatibility with it.  ie: a p2020 might have:
> 
> 	compatible = "fsl,mpc2020-etsec-ptp", "fsl,mpc8313-etsec-ptp";

eTSEC is versioned, that's more reliable than the chip name since chips
have revisions (rev 2.1 of mpc8313 has eTSEC 1.6, not sure about previous
revs of mpc8313).  Logic blocks can be and have been uprevved between one
revision of a chip to the next.  I think "fsl,mpc8313rev2.1-etsec-ptp"
would be taking things a bit too far (and there could be board-level bugs
too...).

If you really need to know the exact SoC you're on, look in SVR (which
will provide revision info as well).  Isn't the device tree for things that
can't be probed?

The eTSEC revision is probeable as well, but due the way PTP is described as
a separate node, the driver doesn't have straightforward access to those
registers.

Insisting on an explicit chip also encourages people to claim compatibility
with that chip without ensuring that it really is fully compatible.

-Scott

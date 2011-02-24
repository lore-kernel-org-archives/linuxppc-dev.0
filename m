Return-Path: <scottwood@freescale.com>
Date: Thu, 24 Feb 2011 11:08:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found on
	the MPC85xx.
Message-ID: <20110224110804.74b546c0@schlenkerla>
In-Reply-To: <20110224163944.GA15234@riccoc20.at.omicron.at>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
	<20110223112612.30071995@schlenkerla>
	<20110223175459.GH14597@angua.secretlab.ca>
	<20110224163944.GA15234@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Mike Frysinger <vapier@gentoo.org>, Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rodolfo Giometti <giometti@linux.it>, Christoph Lameter <cl@linux.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 24 Feb 2011 17:39:44 +0100
Richard Cochran <richardcochran@gmail.com> wrote:

> On Wed, Feb 23, 2011 at 10:54:59AM -0700, Grant Likely wrote:
> > On Wed, Feb 23, 2011 at 11:26:12AM -0600, Scott Wood wrote:
> 
> > > The eTSEC revision is probeable as well, but due the way PTP is described as
> > > a separate node, the driver doesn't have straightforward access to those
> > > registers.
> > 
> > Ignorant question: Should the ptp be described as a separate node?
> 
> Well, the PTP Hardware Clock function is logically separate from the
> MAC function.

The eTSEC node doesn't describe the MAC function, it describes the whole
device (or at least it should... we make an exception for MDIO, which
should probably have been a subnode instead).

> PHCs can be implemented in the MAC, in the PHY, or in
> between in an FPGA on MII bus.
> 
> If the PHC is in the MAC, then it might be wise to implement one
> driver that offers both the MAC and the PHC.
> 
> In the case of gianfar, it is not really necessary to combine the PHC
> into the gianfar driver, since the registers are pretty well
> separated.

How the drivers are structured in Linux is a separate concern from how the
devices are described in the device tree.  The tree is supposed to be an
OS-independent representation of hardware.

If Linux has multiple drivers that correspond to portions of one node, a
toplevel driver can register platform devices for the components, adding
in any additional information like versioning that it gets from the
toplevel registers.

-Scott

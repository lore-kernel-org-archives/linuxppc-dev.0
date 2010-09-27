Return-Path: <cl@linux.com>
Received: from smtp107.prem.mail.ac4.yahoo.com
	(smtp107.prem.mail.ac4.yahoo.com [76.13.13.46])
	by ozlabs.org (Postfix) with SMTP id B4AB5B70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 01:37:42 +1000 (EST)
Date: Mon, 27 Sep 2010 10:37:35 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Christian Riesch <christian@riesch.at>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <4C9BC7CE.8020400@riesch.at>
Message-ID: <alpine.DEB.2.00.1009271035110.9258@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
	<1285268380.2587.11.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231402420.2962@router.home>
	<1285273684.2587.92.camel@localhost.localdomain>
	<alpine.DEB.2.00.1009231533040.7522@router.home>
	<20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
	<4C9BC7CE.8020400@riesch.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-api@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Richard Cochran <richardcochran@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Sep 2010, Christian Riesch wrote:

> > > It implies clock tuning in userspace for a potential sub microsecond
> > > accurate clock. The clock accuracy will be limited by user space
> > > latencies and noise. You wont be able to discipline the system clock
> > > accurately.
> >
> > Noise matters, latency doesn't.
>
> Well put! That's why we need hardware support for PTP timestamping to reduce
> the noise, but get along well with the clock servo that is steering the PHC in
> user space.

Even if I buy into the catch phrase above: User space is subject to noise
that the in kernel code is not. If you do the tuning over long intervals
then it hopefully averages out but it still causes jitter effects that
affects the degree of accuracy (or sync) that you can reach. And the noise
varies with the load on the system.

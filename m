Return-Path: <richardcochran@gmail.com>
Date: Fri, 24 Sep 2010 15:14:07 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
Message-ID: <20100924131407.GA3113@riccoc20.at.omicron.at>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<20100923213654.0c64b047@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100923213654.0c64b047@lxorguk.ukuu.org.uk>
Cc: John Stultz <johnstul@us.ibm.com>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 23, 2010 at 09:36:54PM +0100, Alan Cox wrote:
> Drop the clockid_t and swap it for a file handle like a proper Unix or
> Linux interface. The rest is much the same
> 
> 	fd = open /sys/class/timesource/[whatever]
> 
> 	various queries you may want to do to check the name etc
> 
> 	fclock_adjtime(fd, ...)

Okay, but lets extend the story:

	clock_getttime(fd, ...);

	clock_settime(fd, ...);

	timer_create(fd, ...);

Can you agree to that as well?

(We would need to ensure that 'fd' avoids the range 0 to MAX_CLOCKS).

Richard

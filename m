Return-Path: <john.stultz@linaro.org>
Subject: Re: [PATCH V12 4/4] ptp: Added a clock driver for the National
	Semiconductor PHYTER.
From: John Stultz <john.stultz@linaro.org>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <f8af215ebe32a8c0f4b3a82b8ee7e8008b4feb1e.1298878618.git.richard.cochran@omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<f8af215ebe32a8c0f4b3a82b8ee7e8008b4feb1e.1298878618.git.richard.cochran@omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Mar 2011 14:46:25 -0700
Message-ID: <1300916785.848.54.camel@work-vm>
Mime-Version: 1.0
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
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

On Mon, 2011-02-28 at 08:58 +0100, Richard Cochran wrote:
> This patch adds support for the PTP clock found on the DP83640.
> The basic clock operations and one external time stamp have
> been implemented.

Just locking rule comment nits here.

> +static int tdr_write(int bc, struct phy_device *dev,
> +		     const struct timespec *ts, u16 cmd)
> +{
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_nsec & 0xffff);/* ns[15:0]  */
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_nsec >> 16);   /* ns[31:16] */
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_sec & 0xffff); /* sec[15:0] */
> +	ext_write(bc, dev, PAGE4, PTP_TDR, ts->tv_sec >> 16);    /* sec[31:16]*/
> +
> +	ext_write(bc, dev, PAGE4, PTP_CTL, cmd);
> +
> +	return 0;
> +}

The above needs to hold the extreg_lock, and should be commented as
such.

And again, the function names are sort of generic, and could use a
dp83640_ prefix or something.

thanks
-john

Return-Path: <richardcochran@gmail.com>
Date: Tue, 18 May 2010 08:36:08 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/3] ptp: Added a clock that uses the eTSEC found on
	the MPC85xx.
Message-ID: <20100518063608.GA2720@riccoc20.at.omicron.at>
References: <cover.1273855016.git.richard.cochran@omicron.at>
	<ee6c3edca3ee6aa86565e59da999375f79c9de1b.1273855017.git.richard.cochran@omicron.at>
	<4BED8C91.8020107@freescale.com>
	<20100517082757.GA9703@riccoc20.at.omicron.at>
	<4BF18582.6000500@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4BF18582.6000500@freescale.com>
Cc: netdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 17, 2010 at 01:05:54PM -0500, Scott Wood wrote:
> >>> >+  - tmr_fiper1   Fixed interval period pulse generator.
> >>> >+  - tmr_fiper2   Fixed interval period pulse generator.
> >>
> 
> MPC8572 and P2020 have fiper3 as well.

I doubt they really have a third fiper.

First of all, this signal is not routed anywhere on the boards. Also,
according to the documentation, it has no bit in the TMR_CTRL or the
TMR_TEMASK registers. Unless there is a bit in TMR_TEMASK, you cannot
get an interrupt from it.

If you cannot use the signal externally (in the "real" world) and you
cannot get an interrupt, what good is it to have such a periodic
signal? Polling the bit in the TMR_TEVENT to see when a pulse occurs
seems pointless.

Scott, you have connections, right? Can you clarify this for me?

Thanks,

Richard

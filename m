Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0177.hostedemail.com
 [216.40.44.177])
 by lists.ozlabs.org (Postfix) with ESMTP id D75F11A0332
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2015 10:16:24 +1000 (AEST)
Message-ID: <1428279374.2775.78.camel@perches.com>
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
From: Joe Perches <joe@perches.com>
To: Stefan Agner <stefan@agner.ch>
Date: Sun, 05 Apr 2015 17:16:14 -0700
In-Reply-To: <d55b1a1240db66ae651cb99cd713694a@agner.ch>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
 <d55b1a1240db66ae651cb99cd713694a@agner.ch>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Patrice Chotard <patrice.chotard@st.com>, Pat Gefre <pfg@sgi.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>,
 sparclinux@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>,
 Jiri Slaby <jslaby@suse.cz>, Alexandre Courbot <gnurou@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>,
 =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-serial@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linux-tegra@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>,
 Barry Song <baohua@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>,
 Vineet Gupta <vgupta@synopsys.com>, nios2-dev@lists.rocketboards.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-04-06 at 01:09 +0200, Stefan Agner wrote:
> On 2015-04-05 20:24, Joe Perches wrote:
> > Still compiled only x86 and not cross-compiled or tested.
> 
> Cross-compiled with multi_v7_defconfig
[]
> >  drivers/tty/serial/fsl_lpuart.c             | 4 ++--
> 
> Tested that driver on actual hardware, looks fine.

> This driver seems to alter the startup function on initialization:
> 
>   CC      drivers/video/of_display_timing.o
> ../drivers/tty/serial/samsung.c: In function 's3c24xx_serial_init_port':
> ../drivers/tty/serial/samsung.c:1702:3: error: assignment of member
> 'startup' in read-only object
>    s3c24xx_serial_ops.startup = s3c64xx_serial_startup;
>    ^

Thanks Stefan.  Then that one can't be const.

> That is the only thing which popped up with multi_v7_defconfig.

I appreciate the testing.

Greg, Jiri, I'll resend with this fixed in a week or so
after waiting for any other comment or sign of brokenness.

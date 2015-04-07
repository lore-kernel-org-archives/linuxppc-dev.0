Return-Path: <Vineet.Gupta1@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com [198.182.47.9])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A028B1A056E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 22:54:58 +1000 (AEST)
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Joe Perches <joe@perches.com>, Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
Date: Tue, 7 Apr 2015 12:46:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307566598FD3@IN01WEMBXB.internal.synopsys.com>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "kernel@stlinux.com" <kernel@stlinux.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Patrice Chotard <patrice.chotard@st.com>, Pat Gefre <pfg@sgi.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Sonic Zhang <sonic.zhang@analog.com>, Jiri Slaby <jslaby@suse.cz>,
 Alexandre Courbot <gnurou@gmail.com>, Russell King <linux@arm.linux.org.uk>,
 Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Tobias Klauser <tklauser@distanz.ch>, Stephen Warren <swarren@wwwdotorg.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Vineet
 Gupta <Vineet.Gupta1@synopsys.com>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 David Brown <davidb@codeaurora.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Maxime Coquelin <maxime.coquelin@st.com>, Barry Song <baohua@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <kernel@pengutronix.de>, Srinivas
 Kandagatla <srinivas.kandagatla@gmail.com>,
 "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 05 April 2015 11:55 PM, Joe Perches wrote:

These structs can be const, so make them const.

Miscellanea:

o Add static to struct uart_ops declaration in bfin_sport_uart

Signed-off-by: Joe Perches <joe@perches.com><mailto:joe@perches.com>
---
On Sun, 2015-04-05 at 00:04 +0200, Stefan Agner wrote:


> On 2015-04-04 19:47, Joe Perches wrote:


> > Done with:
> > sed -r -i -e 's/\bstruct\s+uart_ops\s+(\w+)\s*=3D\s*/const struct
> > uart_ops \1 =3D /g' drivers/tty/serial/*.c


[]


> +++ b/drivers/tty/serial/fsl_lpuart.c
> Something went wrong in this driver, const is twice...


Apologies, thanks for noticing.
The sed was mistakenly done twice on that file.

V2:

o Fix duplicate const in fsl_lpuart.c
o Add static to drivers/tty/serial/bfin_sport_uart.c

Still compiled only x86 and not cross-compiled or tested.

 drivers/tty/serial/21285.c                  | 2 +-
 drivers/tty/serial/altera_jtaguart.c        | 2 +-
 drivers/tty/serial/altera_uart.c            | 2 +-
 drivers/tty/serial/amba-pl010.c             | 2 +-
 drivers/tty/serial/amba-pl011.c             | 2 +-
 drivers/tty/serial/apbuart.c                | 2 +-
 drivers/tty/serial/ar933x_uart.c            | 2 +-
 drivers/tty/serial/arc_uart.c               | 2 +-

Acked-by: Vineet Gupta <vgupta@synopsys.com><mailto:vgupta@synopsys.com> # =
for arc_uart

Th,
-Vineet

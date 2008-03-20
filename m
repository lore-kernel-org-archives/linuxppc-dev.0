Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 5BD38DDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 09:04:23 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so258778anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 15:04:18 -0700 (PDT)
Message-ID: <fa686aa40803201504w418bba53q3dc0e371b6de20f7@mail.gmail.com>
Date: Thu, 20 Mar 2008 16:04:17 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <john.linn@xilinx.com>
Subject: Re: [PATCH 3/3] [POWERPC] Xilinx: boot support for Xilinx uart 16550.
In-Reply-To: <20080320144402.695C1518064@mail63-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<1206024232655-git-send-email-john.linn@xilinx.com>
	<20080320144402.695C1518064@mail63-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 8:43 AM, John Linn <john.linn@xilinx.com> wrote:
> The Xilinx 16550 uart core is not a standard 16550, because it uses
>  word-based addressing rather than byte-based addressing.  As a result,
>  it is not compatible with the open firmware 'ns16550' compatible
>  binding.
>
>  This code adds the Xilinx uart 16550 to the serial console
>  of the boot. A new initialization function for the Xilinx 16550 uart
>  is added to the ns16550 driver. It sets up the correct register base
>  and regshift properties specific to the Xilinx 16550.
>
>  Signed-off-by: John Linn <john.linn@xilinx.com>
>  ---
>   arch/powerpc/boot/ns16550.c |   24 ++++++++++++++++++++++++
>   arch/powerpc/boot/ops.h     |    1 +
>   arch/powerpc/boot/serial.c  |    8 ++++++++
>   3 files changed, 33 insertions(+), 0 deletions(-)
>
>  diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
>  index f8f1b2f..5385255 100644
>  --- a/arch/powerpc/boot/ns16550.c
>  +++ b/arch/powerpc/boot/ns16550.c
>  @@ -77,3 +77,27 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>
>         return 0;
>   }
>  +
>  +int xilinx16550_console_init(void *devp, struct serial_console_data *scdp)
>  +{
>  +       int n;
>  +       unsigned long reg_phys;
>  +
>  +       n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
>  +       if (n != sizeof(reg_base)) {
>  +               if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
>  +                       return -1;
>  +
>  +               reg_base = (void *)reg_phys + 3;
>  +       }
>  +
>  +       reg_shift = 2;
>  +
>  +       scdp->open = ns16550_open;
>  +       scdp->putc = ns16550_putc;
>  +       scdp->getc = ns16550_getc;
>  +       scdp->tstc = ns16550_tstc;
>  +       scdp->close = NULL;
>  +
>  +       return 0;

This is mostly duplicated code.  xilinx16550_console_init should
simply call ns16550_console_init and then modify reg_base/reg_shift
after it returns.

However, if something like sparse16550 is used, then the need for this
function disappears.  In fact, ns16550_console_init already supports
the reg-shift property.  It just doesn't know about the 3 byte offset.

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

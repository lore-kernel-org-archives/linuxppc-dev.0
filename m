Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 2A034DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 12:16:30 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so716578anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Apr 2008 18:16:29 -0700 (PDT)
Message-ID: <fa686aa40804021816k1b109319r62ca6a6ce6a3a65@mail.gmail.com>
Date: Wed, 2 Apr 2008 19:16:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <john.linn@xilinx.com>, linuxppc-dev@ozlabs.org,
	grant.likely@secretlab.ca
Subject: Re: [PATCH 3/3][POWERPC][V2] Xilinx: boot support for Xilinx uart
	16550.
In-Reply-To: <20080403000229.GA6663@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12071551351007-git-send-email-john.linn@xilinx.com>
	<20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
	<20080403000229.GA6663@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 2, 2008 at 6:02 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Wed, Apr 02, 2008 at 09:52:14AM -0700, John Linn wrote:
>  > The Xilinx 16550 uart core is not a standard 16550 because it uses
>  > word-based addressing rather than byte-based adressing. With
>  > additional properties it is compatible with the open firmware
>  > 'ns16550' compatible binding.
>  >
>  > This code updates the ns16550 driver to use the reg-offset property
>  > so that the Xilinx UART 16550 can be used with it. The reg-shift
>  > was already being handled.
>  >
>  > Signed-off-by: John Linn <john.linn@xilinx.com>
>  > ---
>  >  arch/powerpc/boot/ns16550.c |    5 +++++
>  >  1 files changed, 5 insertions(+), 0 deletions(-)
>  >
>  > diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
>  > index f8f1b2f..da9d2c2 100644
>  > --- a/arch/powerpc/boot/ns16550.c
>  > +++ b/arch/powerpc/boot/ns16550.c
>  > @@ -56,6 +56,7 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>  >  {
>  >       int n;
>  >       unsigned long reg_phys;
>  > +     u32 reg_offset;
>  >
>  >       n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
>  >       if (n != sizeof(reg_base)) {
>  > @@ -65,6 +66,10 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>  >               reg_base = (void *)reg_phys;
>  >       }
>  >
>  > +     n = getprop(devp, "reg-offset", &reg_offset, sizeof(reg_offset));
>  > +     if (n == sizeof(reg_offset))
>  > +             reg_base += reg_offset;
>
>  Uh... how does the behaviour of reg-offset differ from just bumping
>  the address in "reg"?

Mostly because the registers are actually 32 bit registers that can be
accessed with 32bit reads at offset 0.  Using this property keeps the
reg property describing the real address range.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

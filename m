Return-Path: <dgibson@ozlabs.org>
Date: Thu, 3 Apr 2008 11:02:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH 3/3][POWERPC][V2] Xilinx: boot support for Xilinx uart
	16550.
Message-ID: <20080403000229.GA6663@localhost.localdomain>
References: <12071551351007-git-send-email-john.linn@xilinx.com>
	<20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 02, 2008 at 09:52:14AM -0700, John Linn wrote:
> The Xilinx 16550 uart core is not a standard 16550 because it uses
> word-based addressing rather than byte-based adressing. With
> additional properties it is compatible with the open firmware
> 'ns16550' compatible binding.
> 
> This code updates the ns16550 driver to use the reg-offset property
> so that the Xilinx UART 16550 can be used with it. The reg-shift
> was already being handled.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
>  arch/powerpc/boot/ns16550.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
> index f8f1b2f..da9d2c2 100644
> --- a/arch/powerpc/boot/ns16550.c
> +++ b/arch/powerpc/boot/ns16550.c
> @@ -56,6 +56,7 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>  {
>  	int n;
>  	unsigned long reg_phys;
> +	u32 reg_offset;
>  
>  	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
>  	if (n != sizeof(reg_base)) {
> @@ -65,6 +66,10 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>  		reg_base = (void *)reg_phys;
>  	}
>  
> +	n = getprop(devp, "reg-offset", &reg_offset, sizeof(reg_offset));
> +	if (n == sizeof(reg_offset))
> +		reg_base += reg_offset;

Uh... how does the behaviour of reg-offset differ from just bumping
the address in "reg"?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

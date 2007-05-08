Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 May 2007 15:54:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 3/3] [POWERPC] dts: kill hardcoded phandles
Message-ID: <20070508055431.GA21009@localhost.localdomain>
References: <20070508053049.18428.50622.stgit@localhost.localdomain>
	<20070508054855.18428.29080.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070508054855.18428.29080.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 09:48:56AM +0400, Vitaly Bordug wrote:
> 
> Removed explicit linux,phandle usage. Using references and labels now in
> PQ and PQ2 boards currently supported in arch/powerpc.
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> 
> ---
> 
>  arch/powerpc/boot/dts/mpc8272ads.dts |   42 ++++++++++++----------------------
>  arch/powerpc/boot/dts/mpc866ads.dts  |   31 +++++++++----------------
>  arch/powerpc/boot/dts/mpc885ads.dts  |    2 +-
>  3 files changed, 27 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> index 423eedc..83461fe 100644
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -14,12 +14,10 @@
>         compatible = "MPC8260ADS";
>         #address-cells = <1>;
>         #size-cells = <1>;
> -       linux,phandle = <100>;
>  
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> -               linux,phandle = <200>;
>  
>                 PowerPC,8272@0 {
>                         device_type = "cpu";
> @@ -32,12 +30,10 @@
>                         bus-frequency = <0>;
>                         clock-frequency = <0>;
>                         32-bit;
> -                       linux,phandle = <201>;
>                 };
>         };
>  
> -       interrupt-controller@f8200000 {
> -               linux,phandle = <f8200000>;
> +		pci_pic:interrupt-controller@f8200000 {

I'd like to establish a convention of putting a space after the : and
using capitals for labels unless there's a strong reason not to in a
particular case.  It makes them easier to visually distinguish next to
the node name.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

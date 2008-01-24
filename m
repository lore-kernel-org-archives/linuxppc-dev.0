Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0EA7BDDE1F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:48:19 +1100 (EST)
Date: Thu, 24 Jan 2008 18:48:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Poonam_Aggrwal-b10812 <b10812@freescale.com>
Subject: Re: [PATCH UCC TDM 1/3 Updated] Platform changes for UCC TDM driver
	for MPC8323eRDB. Also includes related QE changes and dts entries.
Message-ID: <20080124154804.GA22178@localhost.localdomain>
References: <Pine.LNX.4.64.0801241553270.4984@linux121>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <Pine.LNX.4.64.0801241553270.4984@linux121>
Cc: michael.barkowski@freescale.com, netdev@vger.kernel.org,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	rubini@vision.unipv.it, linuxppc-dev@ozlabs.org,
	ashish.kalra@freescale.com, rich.cutler@freescale.com,
	akpm@linux-foundation.org, timur@freescale.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Poonam,

On Thu, Jan 24, 2008 at 04:00:06PM +0530, Poonam_Aggrwal-b10812 wrote:
> Thanks Stephen for your comments, incorporated them.
> From: Poonam Aggrwal <b10812@freescale.com>
> 
> This patch makes necessary changes in the QE and UCC framework to support 
> TDM. It also adds support to configure the BRG properly through device 
> tree entries. Includes the device tree changes for UCC TDM driver as well.
> It also includes device tree entries for UCC TDM driver.
> 
> Tested on MPC8323ERDB platform.
> 
> Signed-off-by: Poonam Aggrwal <b10812@freescale.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@freescale.com>
> Signed-off-by: Kim Phillips <Kim.Phillips@freescale.com>
> Signed-off-by: Michael Barkowski <michael.barkowski@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc832x_rdb.dts |   58 +++++++
>  arch/powerpc/sysdev/qe_lib/qe.c       |  184 +++++++++++++++++++++--
>  arch/powerpc/sysdev/qe_lib/ucc.c      |  265 +++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/qe_lib/ucc_fast.c |   37 +++++
>  include/asm-powerpc/qe.h              |    8 +
>  include/asm-powerpc/ucc.h             |    4 +
>  include/asm-powerpc/ucc_fast.h        |    4 +
>  7 files changed, 548 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> index 388c8a7..c0e6283 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -105,6 +105,17 @@
>  			device_type = "par_io";
>  			num-ports = <7>;
>  
> +			ucc1pio:ucc_pin@01 {
> +				pio-map = <
> +			/* port  pin  dir  open_drain  assignment  has_irq */
> +					0  e  2  0  1  0	/* CLK11 */
> +					3 16  1  0  2  0	/* BRG9 */
> +					3 1b  1  0  2  0	/* BRG3 */
> +					0  0  3  0  2  0	/* TDMATxD0 */
> +					0  4  3  0  2  0	/* TDMARxD0 */
> +					3 1b  2  0  1  0>;	/* CLK1 */
> +			};
> +

Can we not introduce new pio-maps in the device trees? There
were debates regarding this, and if I understood everything
correctly, pio-maps considered as a bad taste. Better
do bunch of par_io_config_pin() in the board file. Better
yet fixup the firmware (u-boot) to set up dedicated pins
correctly.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

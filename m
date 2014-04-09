Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 449A21400BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 10:45:02 +1000 (EST)
Message-ID: <1397004291.32034.327.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 2/3] devcietree: bindings: add some MFD Keymile FPGAs
From: Scott Wood <scottwood@freescale.com>
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Date: Tue, 8 Apr 2014 19:44:51 -0500
In-Reply-To: <1395754915-14534-3-git-send-email-valentin.longchamp@keymile.com>
References: <1395754915-14534-1-git-send-email-valentin.longchamp@keymile.com>
 <1395754915-14534-3-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-03-25 at 14:41 +0100, Valentin Longchamp wrote:
> These are the bindings for 2 MFD devices used on some of the Keymile boards.
> The first one is the chassis managmenet bfticu FPGA.
> The second one is the board controller (reset, LEDs, GPIOs) QRIO CPDL.
> These FPGAs are used in the kmcoge4 board.
> 
> This patch also add KEYMILE to the vendor-prefixes.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> 
> ---
> Changes in v3:
> - add a patch with the bindings for the KEYMILE FPGAs
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mfd/bfticu.txt   | 26 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/qriox.txt    | 17 ++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  3 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/bfticu.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qriox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/bfticu.txt b/Documentation/devicetree/bindings/mfd/bfticu.txt
> new file mode 100644
> index 0000000..92de32e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/bfticu.txt
> @@ -0,0 +1,26 @@
> +KEYMILE bfticu Chassis Management FPGA
> +
> +The bfticu is a multifunction device that manages the whole chassis.
> +Its main functionality is to collect IRQs from the whole chassis and signals
> +them to a single controller.
> +
> +Required properties:
> +- compatible: "keymile,bfticu"
> +- interrupt-controller: the bfticu FPGA is an interrupt controller
> +- interrupts: the main IRQ line to signal the collected IRQs
> +- #interrupt-cells : is 2
> +	- The 1st cell is the local IRQ number on the bfticu
> +	- The 2nd cell is the type of the IRQ (IRQ_TYPE_xxx)

Device tree bindings should not depend on the content of Linux headers.
One is stable ABI, and the other isn't.

If you want you can make the values the same for convenience, as is done
by IPIC, CPM PIC, etc -- but the values need to be explicitly stated in
the binding.  It'll still break if the Linux values change (so it may
not be a good idea to try to keep the values the same), but at least the
fix would be in Linux code rather than an ABI change.

> diff --git a/Documentation/devicetree/bindings/mfd/qriox.txt b/Documentation/devicetree/bindings/mfd/qriox.txt
> new file mode 100644
> index 0000000..f301e2d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qriox.txt
> @@ -0,0 +1,17 @@
> +KEYMILE qrio Board Control CPLD
> +
> +The qrio is a multifunction device that controls the KEYMILE boards based on
> +the kmp204x design.
> +It is consists of a reset controller, watchdog timer, LEDs, and 2 IRQ capable
> +GPIO blocks.
> +
> +Required properties:
> +- compatible: "keymile,qriox"
> +- reg: access on the parent local bus (chip select, offset in chip select, size)
> +
> +Example:
> +
> +	board-control@1,0 {
> +		compatible = "keymile,qriox";
> +		reg = <1 0 0x80>;
> +	};

If it has GPIO blocks, shouldn't it be using the GPIO binding?

-Scott

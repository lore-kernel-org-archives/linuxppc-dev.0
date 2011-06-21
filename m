Return-Path: <robherring2@gmail.com>
Message-ID: <4E00F9ED.1020500@gmail.com>
Date: Tue, 21 Jun 2011 15:07:09 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/5] drivers/amba: create devices from device tree
References: <20110621181127.18176.1384.stgit@ponder>
	<20110621184503.18176.88260.stgit@ponder>
In-Reply-To: <20110621184503.18176.88260.stgit@ponder>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
	Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant,

On 06/21/2011 01:45 PM, Grant Likely wrote:
> Add a function to create amba_devices (i.e. primecell peripherals)
> from device tree nodes. The device tree scanning is done by the
> of_platform_populate() function which can call of_amba_device_create
> based on a match table entry.
> 
> Nodes with a "arm,primecell-periphid" property can override the h/w
> peripheral id value.
> 
> Based on the original work by Jeremy Kerr.
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> [grant.likely: add Jeremy's original s-o-b line, changes from review
>                comments, and moved all code to drivers/of/platform.c]
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  .../devicetree/bindings/arm/primecell.txt          |   21 ++++++
>  drivers/of/platform.c                              |   71 ++++++++++++++++++++
>  2 files changed, 92 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/primecell.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/primecell.txt b/Documentation/devicetree/bindings/arm/primecell.txt
> new file mode 100644
> index 0000000..1d5d7a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/primecell.txt
> @@ -0,0 +1,21 @@
> +* ARM Primecell Peripherals
> +
> +ARM, Ltd. Primecell peripherals have a standard id register that can be used to
> +identify the peripheral type, vendor, and revision. This value can be used for
> +driver matching.
> +
> +Required properties:
> +
> +- compatible : should be a specific value for peripheral and "arm,primecell"

Can I review what I wrote... Perhaps we should put strings in for all
existing drivers in the kernel. This should be a complete list:

arm,pl010
arm,pl011
st,pl011
arm,pl022
st,pl022
st,pl023
arm,pl030
arm,pl031
st,pl031
arm,pl061
arm,pl050
arm,pl080
arm,pl081
st,pl080
arm,pl110
arm,pl180
arm,pl330
arm,sp804
arm,sp805


Otherwise, they may never get added.

Rob

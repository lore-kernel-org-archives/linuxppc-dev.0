Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9593CDDE35
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 03:48:42 +1100 (EST)
Date: Wed, 26 Dec 2007 19:50:04 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5] qe: add ability to upload QE firmware
Message-ID: <20071226165004.GA11449@localhost.localdomain>
References: <11970422334145-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <11970422334145-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 07, 2007 at 09:43:53AM -0600, Timur Tabi wrote:
> Define the layout of a binary blob that contains a QE firmware and instructions
> on how to upload it.  Add function qe_upload_firmware() to parse the blob
> and perform the actual upload.  Fully define 'struct rsp' in immap_qe.h to
> include the actual RISC Special Registers.  Added description of a new
> QE firmware node to booting-without-of.txt.

> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> Argh, another booting-without-of.txt fix.  There are 8 virtual traps, not 16.
> 
> This patch is for Kumar's for-2.6.25 branch.  This code is necessary for
> my QE UART driver.
> 
>  Documentation/powerpc/00-INDEX               |    3 +
>  Documentation/powerpc/booting-without-of.txt |   33 +++-
>  Documentation/powerpc/qe_firmware.txt        |  295 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/Kconfig               |    1 +
>  arch/powerpc/sysdev/qe_lib/qe.c              |  240 +++++++++++++++++++++
>  include/asm-powerpc/immap_qe.h               |   34 +++-
>  include/asm-powerpc/qe.h                     |   61 ++++++
>  7 files changed, 663 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/powerpc/qe_firmware.txt
> 

> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index e9a3cb1..8b27711 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
...
> +
> +	 Example:
> +
> +		firmware {
> +			id = "Soft-UART";
> +			extended_modes = <0 0>;
> +			virtual_traps = <0 0 0 0 0 0 0 0>;

I believe using underscores for the property name is discouraged.

> +		}
> +
...
> +VI - Sample Code for Creating Firmware Files
> +============================================
> +
> +A Python program that creates firmware binaries from the header files normally
> +distributed by Freescale can be found on http://opensource.freescale.com.

Hm... I didn't find it there. Could you provide more specific pointer?

...
> index 1df3b4a..497eb88 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
...
> +struct qe_firmware_info *qe_get_firmware_info(void)
> +{
> +	static int initialized;
> +
> +	/*
> +	 * If we haven't checked yet, and a driver hasn't uploaded a firmware
> +	 * yet, then check the device tree for information.
> +	 */
> +	do {
        ^^^^
This is very unusual method of error handling. You could stick
to gotos and lower the indentation level.

> +		struct device_node *qe;
> +		struct device_node *fw = NULL;
> +		const char *sprop;
> +		const u32 *iprop;
> +
> +		if (initialized || qe_firmware_uploaded)
> +			break;
> +
> +		initialized = 1;
> +
> +		qe = of_find_node_by_type(NULL, "qe");

Please, add compatible "fsl,qe" matching, so this code could
work with new device trees.

> +		if (!qe)
> +			break;
> +
> +		/* Find the 'firmware' child node */
> +		while ((fw = of_get_next_child(qe, fw)))
> +			if (strcmp(fw->name, "firmware") == 0)
> +				break;

Hmm. Maybe of_find_node_by_name? Or better by compatible.

> +
> +		/* Did we find the 'firmware' node? */
> +		if (!fw) {
> +			of_node_put(qe);
> +			break;
> +		}
> +
> +		qe_firmware_uploaded = 1;
> +
> +		/* Copy the data into qe_firmware_info*/
> +		sprop = of_get_property(fw, "id", NULL);
> +		if (sprop)
> +			strncpy(qe_firmware_info.id, sprop,
> +				sizeof(qe_firmware_info.id) - 1);
> +
> +		iprop = of_get_property(fw, "extended_modes", NULL);

Checking for size?

> +		if (iprop)
> +			qe_firmware_info.extended_modes =
> +				(u64) iprop[0] << 32 | iprop[1];
> +
> +		iprop = of_get_property(fw, "virtual_traps", NULL);

size?


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

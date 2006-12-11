Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8523D67C7B
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 08:57:00 +1100 (EST)
Message-ID: <457DD485.9010501@ru.mvista.com>
Date: Tue, 12 Dec 2006 00:58:29 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] update MTD OF implementation
References: <20061206153627.43fdc59c.vitalywool@gmail.com>
In-Reply-To: <20061206153627.43fdc59c.vitalywool@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, dwmw2@redhat.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Vitaly Wool wrote:

> the patch below updates the powerpc part of the MTD OF implementation with the new field probe-type and also fixes the typos/build warning for rom.c.
> So therefore it in a way supersedes the patch from Geoff which can be seen at http://ozlabs.org/pipermail/linuxppc-dev/2006-December/028831.html.
> 
>  Documentation/powerpc/booting-without-of.txt |   19 +++++++++++--------
>  arch/powerpc/sysdev/rom.c                    |    1 +
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index b3bd366..3399427 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1703,29 +1703,32 @@ platforms are moved over to use the flat
>      Required properties:
>  
>       - device_type : has to be "rom"
> -     - compatible : Should specify what this ROM device is compatible with
> -       (i.e. "onenand"). Currently, this is most likely to be "direct-mapped"
> -       (which corresponds to the MTD physmap mapping driver).
> -     - regs : Offset and length of the register set (or memory mapping) for
> +     - compatible : Should specify what this flash device is compatible with.
> +       Currently, this is most likely to be "direct-mapped" (which
> +       corresponds to the MTD physmap mapping driver).
> +     - reg : Offset and length of the register set (or memory mapping) for
>         the device.
> +     - bank-width : Width of the flash data bus in bytes. Required
> +       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
>  
>      Recommended properties :
>  
> -     - bank-width : Width of the flash data bus in bytes. Required
> -       for the NOR flashes (compatible == "direct-mapped" and others) ONLY.
>       - partitions : Several pairs of 32-bit values where the first value is
>         partition's offset from the start of the device and the second one is
>         partition size in bytes with LSB used to signify a read only
> -       partititon (so, the parition size should always be an even number).
> +       partition (so, the parition size should always be an even number).
>       - partition-names : The list of concatenated zero terminated strings
>         representing the partition names.
> +     - probe-type : The type of probe which should be done for the chip
> +       (JEDEC vs CFI actually). Valid ONLY for NOR flashes.
>  
>     Example:
>  
>   	flash@ff000000 {
>   		device_type = "rom";
>   		compatible = "direct-mapped";
> - 		regs = <ff000000 01000000>;
> + 		probe-type = "CFI";
> + 		reg = <ff000000 01000000>;
>   		bank-width = <4>;
>   		partitions = <00000000 00f80000
>   			      00f80000 00080001>;
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> diff --git a/arch/powerpc/sysdev/rom.c b/arch/powerpc/sysdev/rom.c
> index bf5b3f1..c855a3b 100644
> --- a/arch/powerpc/sysdev/rom.c
> +++ b/arch/powerpc/sysdev/rom.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kernel.h>
>  #include <asm/of_device.h>
> +#include <asm/of_platform.h>
>  
>  static int __init powerpc_flash_init(void)
>  {

WBR, Sergei

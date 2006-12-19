Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 66BF4DDE3B
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 08:20:58 +1100 (EST)
Message-ID: <458857AF.6000406@ru.mvista.com>
Date: Wed, 20 Dec 2006 00:20:47 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH][trivial][respin] update MTD OF documentation
References: <20061219184425.d924c4c2.vitalywool@gmail.com>
In-Reply-To: <20061219184425.d924c4c2.vitalywool@gmail.com>
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

> the patch below updates the Documentation/powerpc part of the MTD OF implementation with the new field probe-type. Its support has already been implemented in MTD part (drivers/mtd/maps/physmap_of.c).

>  Documentation/powerpc/booting-without-of.txt |   19 +++++++++++--------
>  1 files changed, 11 insertions(+), 8 deletions(-)
> 
> Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

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

WBR, Sergei

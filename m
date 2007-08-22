Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03684DDF01
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 06:47:22 +1000 (EST)
In-Reply-To: <11878048362390-git-send-email-timur@freescale.com>
References: <11878048362390-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8BBF45B8-01B0-4E9D-A3DB-20A40686E527@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] add clrsetbits macros
Date: Wed, 22 Aug 2007 15:49:15 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 12:47 PM, Timur Tabi wrote:

> This patch adds the clrsetbits() macro, which is used to set and clear
> multiple bits in a single read-modify-write operation.  Specify the  
> bits to
> clear in the 'clear' parameter and the bits to set in the 'set'  
> parameter.
> These macros can also be used to set a multiple-bit bit pattern  
> using a mask,
> by specifying the mask in the 'clear' parameter and the new bit  
> pattern in the
> 'set' parameter.  The 'type' parameter is used to specify the size  
> and endian.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> Replace multiple macros with a single one that uses macro  
> concatenation to
> handle the endian/size.
>
>  include/asm-powerpc/io.h |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
> index 4c0b550..030ed4e 100644
> --- a/include/asm-powerpc/io.h
> +++ b/include/asm-powerpc/io.h
> @@ -737,6 +737,19 @@ static inline void * bus_to_virt(unsigned long  
> address)
>  #define setbits8(_addr, _v) out_8((_addr), in_8(_addr) |  (_v))
>  #define clrbits8(_addr, _v) out_8((_addr), in_8(_addr) & ~(_v))
>
> +/* Clear and set bits in one shot.  This macrocan be used to clear  
> and set
> + * multiple bits in a register using a single read-modify-write.   
> It can
> + * also be used to set a multiple-bit bit pattern using a mask, by
> + * specifying the mask in the 'clear' parameter and the new bit  
> pattern in
> + * the 'set' parameter.
> + *
> + * For 'type', specify 8, le16, be16, le32, be32, le64, or be64.   
> The latter
> + * two only work on 64-bit PowerPC (__powerpc64__ is defined).
> + */
> +
> +#define clrsetbits(type, addr, clear, set) \
> +	out_##type((addr), (in_##type(addr) & ~(clear)) | (set))
> +

I think we should define the *_le{32,64}, *_be{32,64}, and _8  
versions using this.

- k

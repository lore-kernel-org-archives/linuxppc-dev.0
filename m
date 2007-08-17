Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id C4F84DDEBF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 16:44:36 +1000 (EST)
Date: Fri, 17 Aug 2007 08:44:33 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: add setclrbits macros
In-Reply-To: <11873041991712-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.62.0708170843060.8381@pademelon.sonytel.be>
References: <11873041991712-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-716351684-1187333073=:8381"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-716351684-1187333073=:8381
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Aug 2007, Timur Tabi wrote:
> This patch adds the setclrbits_xxx() macros, which are used to set and clear
> multiple bits in a single read-modify-write operation.  Specify the bits
> to set in the 'set' parameter and the bits to clear in the 'clear' parameter.
> These macros can also be used to set a multiple-bit bit pattern using a mask,
> by specifying the mask in the 'clear' parameter and the new bit pattern in the
> 'set' parameter.  There are big-endian and little-endian versions for 8, 16,
> 32, and 64 bits.

Sorry for nitpicking again, but since the clear is done before the set (cfr.
the expanded functionality), perhaps they should be changed to
clrsetbits_X(addr, clear, set)?

> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> Changed the macros from setmaskedbits_xxx to setclrbits_xxx and added a comment
> indicating the expanded functionality.
> 
>  include/asm-powerpc/io.h |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
> index bb8d965..58c8b96 100644
> --- a/include/asm-powerpc/io.h
> +++ b/include/asm-powerpc/io.h
> @@ -734,6 +734,33 @@ static inline void * bus_to_virt(unsigned long address)
>  #define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
>  #define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
>  
> +/* Set and clear bits in one shot.  These macros can be used to clear and
> + * set multiple bits in a register using a single read-modify-write.  These
> + * macros can also be used to set a multiple-bit bit pattern using a mask,
> + * by specifying the mask in the 'clear' parameter and the new bit pattern
> + * in the 'set' parameter.
> + */
> +
> +#ifdef __powerpc64__
> +#define setclrbits_be64(addr, set, clear) \
> +	out_be64((addr), (in_be64(addr) & ~(clear)) | (set))
> +#define setclrbits_le64(addr, set, clear) \
> +	out_le64((addr), (in_le64(addr) & ~(clear)) | (set))
> +#endif
> +
> +#define setclrbits_be32(addr, set, clear) \
> +	out_be32((addr), (in_be32(addr) & ~(clear)) | (set))
> +#define setclrbits_be16(addr, set, clear) \
> +	out_be16((addr), (in_be16(addr) & ~(clear)) | (set))
> +
> +#define setclrbits_le32(addr, set, clear) \
> +	out_le32((addr), (in_le32(addr) & ~(clear)) | (set))
> +#define setclrbits_le16(addr, set, clear) \
> +	out_le16((addr), (in_le16(addr) & ~(clear)) | (set))
> +
> +#define setclrbits_8(addr, set, clear) \
> +	out_8((addr), (in_8(addr) & ~(clear)) | (set))
> +
>  #endif /* __KERNEL__ */
>  
>  #endif /* _ASM_POWERPC_IO_H */
> -- 
> 1.5.2.4
> 

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-716351684-1187333073=:8381--

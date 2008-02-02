Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.247])
	by ozlabs.org (Postfix) with ESMTP id 55111DDE43
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 17:59:47 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 31so5394agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 01 Feb 2008 22:59:45 -0800 (PST)
Message-ID: <fa686aa40802012259s251c12c5t6db8918cfdb41c5d@mail.gmail.com>
Date: Fri, 1 Feb 2008 23:59:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, jwboyer@gmail.com, scottwood@freescale.com,
	stephen.neuendorffer@xilinx.com
Subject: Re: [RFC][POWERPC] bootwrapper: Add a firmware-independent simpleboot
	target.
In-Reply-To: <20080202065517.12920.20235.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080202065517.12920.20235.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> This target produces a flat binary rather than an ELF file,
> fixes the entry point at the beginning of the image, and takes
> a complete device tree with no fixups needed.
>
> Based on 'raw' target written by Scott Wood.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> diff --git a/arch/powerpc/boot/io.h b/arch/powerpc/boot/io.h
> index ccaedae..ec57ec9 100644
> --- a/arch/powerpc/boot/io.h
> +++ b/arch/powerpc/boot/io.h
> @@ -99,4 +99,11 @@ static inline void barrier(void)
>         asm volatile("" : : : "memory");
>  }
>
> +static inline void disable_irq(void)
> +{
> +       int dummy;
> +       asm volatile("mfmsr %0; rlwinm %0, %0, 0, ~(1<<15); mtmsr %0" :
> +                    "=r" (dummy) : : "memory");
> +}
> +
>  #endif /* _IO_H */

Oops, ignore this bit.  This is leftover cruft from the original
patch.  I've now removed it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <tommusta@gmail.com>
Received: from mail-vb0-x235.google.com (mail-vb0-x235.google.com
 [IPv6:2607:f8b0:400c:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E79742C00FB
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:22:56 +1000 (EST)
Received: by mail-vb0-f53.google.com with SMTP id i3so2846323vbh.12
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 05:22:51 -0700 (PDT)
Message-ID: <5236F818.7080303@gmail.com>
Date: Mon, 16 Sep 2013 07:22:48 -0500
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/8][v4] power: implement is_instr_load_store().
References: <1379119755-21025-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1379119755-21025-8-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1379119755-21025-8-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/13/2013 7:49 PM, Sukadev Bhattiprolu wrote:
> Implement is_instr_load_store() to detect whether a given instruction
> is one of the fixed-point or floating-point load/store instructions.
> This function will be used in a follow-on patch to save memory hierarchy
> information of the load/store.
>
>
> +/*
> + * Values of bits 21:30 of Fixed-point and Floating-point Load and Store
> + * instructions.
> + *
> + * Reference:	PowerISA_V2.06B_Public.pdf, Sections 3.3.2 through 3.3.6 and
> + *		4.6.2 through 4.6.4.
> + */
> +#define	x_lbzx		87
> +#define	x_lbzux		119
> +#define	x_lhzx		279
> <snip>
> +
> +static unsigned int x_form_load_store[] = {
> +	x_lbzx,     x_lbzux,    x_lhzx,     x_lhzux,    x_lhax,
> +	x_lhaux,    x_lwzx,     x_lwzux,    x_lwax,     x_lwaux,
> +	x_ldx,      x_ldux,     x_stbx,     x_stbux,    x_sthx,
> +	x_sthux,    x_stwx,     x_stwux,    x_stdx,     x_stdux,
> +	x_lhbrx,    x_lwbrx,    x_sthbrx,   x_stwbrx,   x_ldbrx,
> +	x_stdbrx,   x_lswi,     x_lswx,     x_stswi,    x_stswx,
> +	x_lfsx,     x_lfsux,    x_lfdx,     x_lfdux,    x_lfiwax,
> +	x_lfiwzx,   x_stfsx,    x_stfsux,   x_stfdx,    x_stfdux,
> +	x_stfiwax,  x_lfdpx,    x_stfdpx
> +};
> +
> <snip>
> +
>   
>   
Can you explain why this function only covers fixed point and floating 
point instructions?  I.e., why did you skip Altivec and VSX?

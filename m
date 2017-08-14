Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xW6bf5CwKzDr9Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 17:26:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/17] powerpc/vas: Move GET_FIELD/SET_FIELD to vas.h
In-Reply-To: <1502233622-9330-3-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1502233622-9330-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1502233622-9330-3-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Mon, 14 Aug 2017 17:26:04 +1000
Message-ID: <87zib2r4oj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Move the GET_FIELD and SET_FIELD macros to vas.h as VAS and other
> users of VAS, including NX-842 can use those macros.
>
> There is a lot of related code between the VAS/NX kernel drivers
> and skiboot. For consistency switch the order of parameters in
> SET_FIELD to match the order in skiboot.
>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Reviewed-by: Dan Streetman <ddstreet@ieee.org>

> diff --git a/arch/powerpc/include/uapi/asm/vas.h b/arch/powerpc/include/uapi/asm/vas.h
> index ddfe046..21249f5 100644
> --- a/arch/powerpc/include/uapi/asm/vas.h
> +++ b/arch/powerpc/include/uapi/asm/vas.h
> @@ -22,4 +22,12 @@
>  #define VAS_THRESH_FIFO_GT_QTR_FULL	2
>  #define VAS_THRESH_FIFO_GT_EIGHTH_FULL	3
>  
> +/*
> + * Get/Set bit fields
> + */
> +#define GET_FIELD(m, v)		(((v) & (m)) >> MASK_LSH(m))
> +#define MASK_LSH(m)		(__builtin_ffsl(m) - 1)
> +#define SET_FIELD(m, v, val)	\
> +		(((v) & ~(m)) | ((((typeof(v))(val)) << MASK_LSH(m)) & (m)))

This has no business being in a uapi header for VAS.

Put it in asm/vas.h if you must.

Personally I really dislike these sort of macros because they completely
obscure what the final value should end up being, and it's the final
value you'll see when you're debugging it.

> +	ccw = SET_FIELD(CCW_CT, ccw, nx842_ct);
> +	ccw = SET_FIELD(CCW_CI_842, ccw, 0); /* use 0 for hw auto-selection */
> +	ccw = SET_FIELD(CCW_FC_842, ccw, fc);

eg. that could also be written:

       ccw = (nx842_ct << 16) | (fc & 7);

cheers

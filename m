Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EECC1A0612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 12:14:04 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Sun, 21 Feb 2016 18:14:02 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 168AD3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 18:13:59 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1M1Dw1W28967110
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 18:13:58 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1M1DwPA002838
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 18:13:58 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: Fwd: [PATCH v4 11/18] cxl: Separate bare-metal fields in adapter
 and AFU data structures
References: <1455658751-16970-12-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CA2CD1.7020908@linux.vnet.ibm.com>
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
To: fbarrat@linux.vnet.ibm.com
Cc: Ian Munsie <imunsie@au1.ibm.com>, michael.neuling@au1.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Message-ID: <56CA60E8.6090607@linux.vnet.ibm.com>
Date: Sun, 21 Feb 2016 19:14:16 -0600
MIME-Version: 1.0
In-Reply-To: <56CA2CD1.7020908@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe, Fred: Perhaps none of these comments below are specific
to your patch, but clarification would help the next reviewer.

--
Manoj Kumar

> Subject: [PATCH v4 11/18] cxl: Separate bare-metal fields in adapter and

>
> -    WARN_ON(afu->spa_size > 0x100000); /* Max size supported by the
> hardware */
> +    WARN_ON(afu->native->spa_size > 0x100000); /* Max size supported by
> the hardware */

Would prefer to see a MACRO defined, instead of the literal 0x1000000


>
>       cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);

Same as above.


>       p1n_base = p1_base(dev) + 0x10000 + (afu->slice * p1n_size);

Same as above.

>
> @@ -621,7 +622,7 @@ static int cxl_read_afu_descriptor(struct cxl_afu *afu)
>       afu->pp_size = AFUD_PPPSA_LEN(val) * 4096;

Both val and pp_size are 64bit quantities. Not clear how the overflow
during multiplication is going to be handled.


>       afu->crs_len = AFUD_CR_LEN(val) * 256;

What do the 4096 and 256 represent?


>       /* Convert everything to bytes, because there is NO WAY I'd look
> at the
>        * code a month later and forget what units these are in ;-) */
> -    adapter->ps_off = ps_off * 64 * 1024;
> +    adapter->native->ps_off = ps_off * 64 * 1024;
>       adapter->ps_size = ps_size * 64 * 1024;
> -    adapter->afu_desc_off = afu_desc_off * 64 * 1024;
> -    adapter->afu_desc_size = afu_desc_size *64 * 1024;
> +    adapter->native->afu_desc_off = afu_desc_off * 64 * 1024;
> +    adapter->native->afu_desc_size = afu_desc_size * 64 * 1024;

Is this (64k) page size related?

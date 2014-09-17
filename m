Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AC461A0070
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 17:06:59 +1000 (EST)
Message-ID: <1410937582.27681.9.camel@concordia>
Subject: Re: [1/5] pseries: Define rtas hotplug event sections
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 17 Sep 2014 17:06:22 +1000
In-Reply-To: <54174C20.1000009@linux.vnet.ibm.com>
References: <54174C20.1000009@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mon, 2014-09-15 at 15:29 -0500, Nathan Fontenot wrote:
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index b390f55..a01879e 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -273,6 +273,7 @@ inline uint32_t rtas_ext_event_company_id(struct rtas_ext_event_log_v6 *ext_log)
>  #define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
>  #define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
>  #define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
> +#define PSERIES_ELOG_SECT_ID_HOTPLUG		(('H' << 8) | 'P')
>  
>  /* Vendor specific Platform Event Log Format, Version 6, section header */
>  struct pseries_errorlog {
> @@ -296,6 +297,31 @@ inline uint16_t pseries_errorlog_length(struct pseries_errorlog *sect)
>  	return be16_to_cpu(sect->length);
>  }
>  
> +/* RTAS pseries hotplug errorlog section */
> +struct pseries_hp_errorlog {
> +	uint8_t	resource;
> +	uint8_t	action;
> +	uint8_t	id_type;
> +	uint8_t	reserved;

These should be u8.

> +	union {
> +		__be32	drc_index;
> +		__be32	drc_count;
> +		char	drc_name[1];

I don't see drc_name used?

> +	} _drc_u;
> +};

cheers

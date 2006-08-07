Return-Path: <hollisb@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 152A3679E1
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 10:21:58 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k770Lrp1014297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Aug 2006 20:21:53 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k770Lr4a149864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Aug 2006 18:21:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k770LroT008750
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Aug 2006 18:21:53 -0600
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
From: Hollis Blanchard <hollisb@us.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060719230014.GB3887@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 19:21:51 -0500
Message-Id: <1154910111.27074.87.camel@diesel>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-07-19 at 16:00 -0700, an unknown sender wrote:
> diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
> new file mode 100644
> index 0000000..2a2fa2b
> --- /dev/null
> +++ b/arch/powerpc/boot/types.h
> @@ -0,0 +1,29 @@
> +#ifndef _TYPES_H_
> +#define _TYPES_H_
> +
> +#define        COMMAND_LINE_SIZE       512
> +#define        MAX_PATH_LEN            256
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
> +typedef unsigned char          u8;
> +typedef unsigned short         u16;
> +typedef unsigned int           u32;
> +#ifdef __powerpc64__
> +typedef unsigned long          u64;
> +#else
> +typedef unsigned long long     u64;
> +#endif 

As long as we're adding new typedefs, could we please use the stdint.h
ones (e.g. uint32_t)? For Xen, I need to do flat tree munging in
userspace, so using real types would help with code reuse.

-- 
Hollis Blanchard
IBM Linux Technology Center

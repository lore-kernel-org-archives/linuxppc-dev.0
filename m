Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 92B60B7003
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2012 22:13:06 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 7/15] powerpc: merge STK_REG/PARAM/FRAMESIZE
References: <1339155365.316308.981577666228.qpush@ale>
 <20120608113605.80B73D43B2B__2857.47079547054$1339155968$gmane$org@localhost.localdomain>
Date: Fri, 08 Jun 2012 14:12:56 +0200
In-Reply-To: <20120608113605.80B73D43B2B__2857.47079547054$1339155968$gmane$org@localhost.localdomain>
 (Michael Neuling's message of "Fri, 08 Jun 2012 21:36:05 +1000")
Message-ID: <m2wr3it31z.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Index: clone3/arch/powerpc/include/asm/ppc_asm.h
> ===================================================================
> --- clone3.orig/arch/powerpc/include/asm/ppc_asm.h
> +++ clone3/arch/powerpc/include/asm/ppc_asm.h
> @@ -178,6 +178,11 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLP
>  #define HMT_HIGH	or	3,3,3
>  #define HMT_EXTRA_HIGH	or	7,7,7		# power7 only
>  
> +#define STACKFRAMESIZE 256
> +#define STK_REG(i)     (112 + ((i)-14)*8)
> +
> +#define STK_PARAM(i)	(48 + ((i)-3)*8)

That should probably be bracketed by CONFIG_PPC64, since it is only
applicable to 64-bit code.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

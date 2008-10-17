Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 77F3EDDF12
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 23:57:23 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ibm_newemac: Fix new MAL feature handling
Date: Fri, 17 Oct 2008 14:56:52 +0200
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<1224133010.8157.543.camel@pasglop>
	<20081016143840.GA29805@yoda.jdub.homelinux.org>
In-Reply-To: <20081016143840.GA29805@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810171456.53599.arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 16 October 2008, Josh Boyer wrote:
> +#ifdef CONFIG_PPC_DCR_NATIVE
> =A0=A0=A0=A0=A0=A0=A0=A0if (mal_has_feature(mal, MAL_FTR_CLEAR_ICINTSTAT))
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mtdcri(SDR0, DCRN_SDR_ICI=
NTSTAT,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0(mfdcri(SDR0, DCRN_SDR_ICINTSTAT) | ICINTSTAT_ICTX)=
);
> +#endif
> =A0

So what if you have a mmio based DRC implementation and still want to use
this feature?

I guess you really should use dcr_read/dcr_write here instead of mtdcr/mfdc=
r.

	Arnd <><

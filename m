Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CECF967D9E
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 18:04:33 +1100 (EST)
Date: Mon, 13 Nov 2006 01:03:30 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] iSeries: fix slb.c for combined build
Message-ID: <20061113010330.1d821876@pb15>
In-Reply-To: <20061113144918.84647810.sfr@canb.auug.org.au>
References: <20061113144918.84647810.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Nov 2006 14:49:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> -#ifndef CONFIG_PPC_ISERIES
> - {
> -	unsigned long lflags, vflags;
> +	if (!firmware_has_feature(FW_FEATURE_ISERIES)) {
> +		unsigned long lflags, vflags;
>  
> -	lflags = SLB_VSID_KERNEL | linear_llp;

It'll be a little tidier if you move the stab_rr setting (common code
at the bottom of the function) up above the test, and just return early
for iseries, instead of indenting everything an extra level.


-Olof

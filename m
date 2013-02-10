Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BE9E2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 02:46:29 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 11 Feb 2013 01:44:46 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EBF852CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 02:46:23 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1AFY1DM59441182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 02:34:06 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1AFkHaw021050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 02:46:18 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Phileas Fogg <phileas-fogg@mail.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Re[3]: PS3 platform is broken on Linux 3.7.0
In-Reply-To: <1360498641.346858866@f116.mail.ru>
References: <1355488506.55692113@f147.mail.ru>
 <1355954017.5397.53.camel@pasglop> <1360496719.267074236@f380.i.mail.ru>
 <1360498641.346858866@f116.mail.ru>
Date: Sun, 10 Feb 2013 21:16:15 +0530
Message-ID: <87mwvc41fc.fsf@linux.vnet.ibm.com>
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

Phileas Fogg <phileas-fogg@mail.ru> writes:

>  Please ignore the previous patch to fix the PACA issue on PS3 arch.
> This is the correct one:
>
> --- a/arch/powerpc/kernel/setup_64.c	2013-02-10 13:56:12.803855673 +0100
> +++ b/arch/powerpc/kernel/setup_64.c	2013-02-10 14:07:22.870561322 +0100
> @@ -186,6 +186,9 @@
>  	initialise_paca(&boot_paca, 0);
>  	setup_paca(&boot_paca);
>  
> +	/* Allow percpu accesses to "work" until we setup percpu data */
> +	boot_paca.data_offset = 0;
> +
>  	/* Initialize lockdep early or else spinlocks will blow */
>  	lockdep_init();
>  
>

commit 466921c5a4669f4315528a25f9afd66601ce2c04 is done to fix the
lockdep related issue on ppc64. So this may need little bit more
explanation. So if we explicitly use boot_paca, do we still need the
changes in the above commit ?

-aneesh

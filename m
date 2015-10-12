Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 061061A073D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 08:47:42 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0105.outbound.protection.outlook.com [157.56.110.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 437371402B7
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 08:47:40 +1100 (AEDT)
Message-ID: <1444686438.5185.94.camel@freescale.com>
Subject: Re: [PATCH 5/6] powerpc/kconfig: Move cpu options after platform
 options
From: Scott Wood <scottwood@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@ozlabs.org>, <thuth@redhat.com>
Date: Mon, 12 Oct 2015 16:47:18 -0500
In-Reply-To: <1444338557-14988-5-git-send-email-mpe@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
 <1444338557-14988-5-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-09 at 08:09 +1100, Michael Ellerman wrote:
> In general platforms are a more important configuration decision than
> cpus, so the platforms should come first.
> 
> My basis for saying that is that our cpu selection options are generally
> just about tuning for a cpu, rather than enabling/disabling support for
> a cpu. On the other hand disabling a platform means you can't boot on
> those machines, and any associated cpu options should vanish.

Kconfig.cputype *is* about enabling/disabling support for a cpu.  On 32-bit, 
the first choice is between "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx", 
"Freescale 85xx", "Freescale 8xx", "AMCC 40x", "AMCC 44x, 46x or 47x", or 
"Freescale e200".  Until that is set correctly, the platforms available for 
selection will not be correct.

Likewise, on 64-bit one must choose book3s versus book3e, before going on to 
the tuning selection you describe above.

-Scott

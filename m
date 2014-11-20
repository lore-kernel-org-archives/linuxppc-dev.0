Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81A5F1A09F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 01:23:51 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4FE4E140142
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 01:23:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 21 Nov 2014 00:23:48 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6CD733578048
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 01:23:45 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAKENJH533423522
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 01:23:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAKENiA4003523
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2014 01:23:44 +1100
Message-ID: <546DF910.4060802@linux.vnet.ibm.com>
Date: Thu, 20 Nov 2014 19:52:08 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
In-Reply-To: <20141116171605.4750.17472.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11/16/2014 10:47 PM, Neelesh Gupta wrote:
> The patch exposes the available i2c busses on the PowerNV platform
> to the kernel and implements the bus driver to support i2c and
> smbus commands.
> The driver uses the platform device infrastructure to probe the busses
> on the platform and registers them with the i2c driver framework.
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Hi Wolfram,

Did you get the chance to look at it?
The patch addresses the comments and discussions on v1.

Thanks,
Neelesh

>   arch/powerpc/include/asm/opal.h                |   29 ++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |    1
>   arch/powerpc/platforms/powernv/opal.c          |   11 +
>   drivers/i2c/busses/Kconfig                     |   11 +
>   drivers/i2c/busses/Makefile                    |    1
>   drivers/i2c/busses/i2c-opal.c                  |  295 ++++++++++++++++++++++++
>   6 files changed, 348 insertions(+)
>   create mode 100644 drivers/i2c/busses/i2c-opal.c
>
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9124b0e..537807b 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
>

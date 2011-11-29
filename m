Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 819CAB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 05:52:31 +1100 (EST)
Message-ID: <4ED529E3.4090609@freescale.com>
Date: Tue, 29 Nov 2011 12:52:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc/85xx: consolidate of_platform_bus_probe calls
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-2-git-send-email-dbaryshkov@gmail.com>
 <CAOZdJXXZG38v-tgA2Ty7-uxJ3AxoFCmNxMO3dKJnJYQtJFb9DA@mail.gmail.com>
 <38BAFE03-DB17-4442-8CC2-E386E46FEB19@kernel.crashing.org>
 <4ED5058F.90004@freescale.com> <4ED50633.4020506@freescale.com>
 <2C30517A-CF00-455A-ABE4-CA92A8856C70@kernel.crashing.org>
In-Reply-To: <2C30517A-CF00-455A-ABE4-CA92A8856C70@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Ben would probably have to answer that.  I can't remember why he wanted it.  I'm sure he has a good reason.

Well, I'm not sure what's going on with the code.  I *think* what's happening is that the first call of_platform_bus_probe() is scanning most, but not all, of the tree, and it's somehow reserving all of those nodes.  Then we call of_platform_bus_probe() again, but it never finds the DMA nodes.  of_platform_bus_probe() never actually calls of_platform_bus_create() this time around.  Perhaps the recursive nature of of_platform_bus_create() is part of the problem.

The only fix I can think of is to move "fsl,eloplus-dma" into mpc85xx_common_ids[].  I'll post a patch that does that, and we can discuss it.

-- 
Timur Tabi
Linux kernel developer at Freescale

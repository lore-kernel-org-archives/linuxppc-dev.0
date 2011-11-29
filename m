Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7D439B6F6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 09:53:42 +1100 (EST)
Message-ID: <4ED5626C.1080201@freescale.com>
Date: Tue, 29 Nov 2011 16:53:32 -0600
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
 <4ED529E3.4090609@freescale.com>
 <F763A5A8-8F4B-477A-ADD3-EDEF71C8F801@kernel.crashing.org>
In-Reply-To: <F763A5A8-8F4B-477A-ADD3-EDEF71C8F801@kernel.crashing.org>
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
>> > The only fix I can think of is to move "fsl,eloplus-dma" into mpc85xx_common_ids[].  I'll post a patch that does that, and we can discuss it.

> what if you make the p1022_ds_ids call first?  Maybe we need to add 'soc' to p1022_ds_ids list

Reversing the calls does not help.  p1022_ds_ids[] is ignored either way.  The same problem exists in mpc85xx_publish_devices(), so this patch breaks several boards.

Copying lines into p1022_ds_ids[] causes kernel BUGS() like this:

sysfs: cannot create duplicate filename '/devices/e0005000.localbus'

because we end up duplicating probes.

-- 
Timur Tabi
Linux kernel developer at Freescale

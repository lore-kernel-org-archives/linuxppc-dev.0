Return-Path: <srs0=9pr5=eu=xenosoft.de=chzigotzky@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRxHD0PPSzDqy5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 20:16:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zRxHC6XLnz8sxQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 20:16:23 +1100 (AEDT)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zRxH93bxQz9s1h
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2018 20:16:20 +1100 (AEDT)
Subject: [PATCH 07/11] powerpc/64s: Add support for RFI flush of L1-D cache
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, oohall@gmail.com, anton@samba.org, paulus@samba.org,
 tglx@linutronix.de
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-7-mpe@ellerman.id.au>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <d73cc972-420d-4106-cc08-0d0683435afa@xenosoft.de>
Date: Thu, 25 Jan 2018 10:10:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180108165453.26066-7-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FYI:

A-EON AmigaOne X1000 (CPU P.A. Semi PWRficient PA6T-1682M with two PA6T 
cores):

/sys/devices/system/cpu/vulnerabilities/

-r--r--r-- 1 root root 4096 Jan 25 09:38 meltdown
-r--r--r-- 1 root root 4096 Jan 25 09:38 spectre_v1
-r--r--r-- 1 root root 4096 Jan 25 09:38 spectre_v2

meltdown Vulnerable
spectre_v1 Not affected
spectre_v2 Not affected


On 08 January 2018 at 5:54PM, Michael Ellerman wrote:
> At this time we do not know the status of the vulnerability on other CPUs
> such as the 970 (Apple G5), pasemi CPUs (AmigaOne X1000) or Freescale
> CPUs.

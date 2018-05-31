Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xFBg1XW0zDrpN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:40:26 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4V4dDod036323
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:40:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ja6ueedy5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 00:40:24 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 31 May 2018 05:40:22 +0100
Date: Thu, 31 May 2018 10:10:12 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH] [SCHEME 1] Add support for new idle device tree format
References: <1527735184-24465-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1527735184-24465-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20180531044003.2zpkgzhsxyph3tdc@aksadiga.ibm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 31, 2018 at 08:23:04AM +0530, Akshay Adiga wrote:
> This patch adds support for new device-tree format for idle state
> description.
> 
> Previously if a older kernel runs on a newer firmware, it may enable
> all available states irrespective of its capability of handling it.
> New device tree format adds a compatible flag, so that only kernel
> which has the capability to handle the version of stop state will enable
> it.
> 
> Older kernel will still see stop0 and stop0_lite in older format and we
> will depricate it after some time.
> 
> Idea is to bump up the version in firmware if we find a bug or
> regression in stop states. A fix will be provided in linux which would
> now know about the bumped up version of stop states, where as kernel
> without fixes would ignore the states.
> 
> New idle state device tree format :
>        power-mgt {
>             ...
>         ibm,enabled-stop-levels = <0xec000000>;
>         ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
>         ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
>         ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
>         ibm,cpu-idle-state-flags = <0x100000 0x101000>;
>         ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
>         ibm,idle-states {
>                 phandle = <0xff>;
>                     stop4 {
>                         flags = <0x207000>;
>                         compatible = "ibm,cpuidle-state-v1";
>                         psscr-mask = <0x0 0x3003ff>;
>                         handle = <0x102>;
>                         latency-ns = <0x186a0>;
>                         residency-ns = <0x989680>;
>                         psscr = <0x0 0x300374>;
>                  };
> 
>                     ...
>                     stop11 {
>                         ...
>                         compatible = "ibm,cpuoffline-state-v1";
>                         ...
> 
>            };
>            };
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

This is intended to be a RFC patch. 
The skiboot patch for the device tree is posted here :
https://patchwork.ozlabs.org/patch/923120/

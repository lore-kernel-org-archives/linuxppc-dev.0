Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRTyj67q4zDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 14:44:29 +1100 (AEDT)
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vRTyj2Jvcz9s7Z
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 14:44:28 +1100 (AEDT)
Received: by mail-pg0-x235.google.com with SMTP id a123so11582622pgc.0
 for <linuxppc-dev@ozlabs.org>; Sun, 19 Feb 2017 19:44:28 -0800 (PST)
Message-ID: <1487562261.10535.8.camel@gmail.com>
Subject: Re: [next-20170217] WARN @/arch/powerpc/include/asm/xics.h:124
 .icp_hv_eoi+0x40/0x140
From: Balbir Singh <bsingharora@gmail.com>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-next@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Date: Mon, 20 Feb 2017 14:44:21 +1100
In-Reply-To: <E96217CD-2ADD-430D-86BD-27FF87752D7F@linux.vnet.ibm.com>
References: <E96217CD-2ADD-430D-86BD-27FF87752D7F@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-02-19 at 20:39 +0530, Sachin Sant wrote:
> While booting next-20170217 on a POWER6 box, I ran into following
> warning. This is a full system lpar. Previous next tree was good.
> I will try a bisect tomorrow.
> 
> ipr: IBM Power RAID SCSI Device Driver version: 2.6.3 (October 17, 2015)
> ipr 0200:00:01.0: Found IOA with IRQ: 305
> ------------[ cut here ]------------
> WARNING: CPU: 12 PID: 1 at ./arch/powerpc/include/asm/xics.h:124 .icp_hv_eoi+0x40/0x140


This indicates that the CPPR stack underflow'd (we don't know the CPPR value
at the time of the interrupt that we are going to do an EOI for).  The problem
could have occured elsewhere, but shows up at the first interrupt after
the real cause. Could you past the full dmesg and config and follow Michael's
suggestion for debugging SHIRQ's

Balbir

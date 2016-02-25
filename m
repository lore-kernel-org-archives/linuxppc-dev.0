Return-Path: <manoj@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCB421A0063
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 03:44:38 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <manoj@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 09:44:35 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 776143E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 09:44:32 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1PGiWeK27394158
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 09:44:32 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1PGiWvh022764
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 09:44:32 -0700
Reply-To: manoj@linux.vnet.ibm.com
Subject: Re: [PATCH v5 15/18] cxl: Parse device tree and create cxl device(s)
 at boot
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1456244519-18934-16-git-send-email-fbarrat@linux.vnet.ibm.com>
 <56CE0F71.60404@linux.vnet.ibm.com> <56CEFF5B.8010000@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Manoj Kumar <manoj@linux.vnet.ibm.com>
Message-ID: <56CF2F86.70102@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 10:44:54 -0600
MIME-Version: 1.0
In-Reply-To: <56CEFF5B.8010000@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fred: Thanks for the clarification.

Reviewed-by: Manoj Kumar <manoj@linux.vnet.ibm.com>

---
Manoj Kumar


On 2/25/2016 7:19 AM, Frederic Barrat wrote:
>
>
> Le 24/02/2016 21:15, Manoj Kumar a écrit :
>> On 2/23/2016 10:21 AM, Frederic Barrat wrote:
>>> +module_init(cxl_base_init);
>>
>> Is this a remnant from when there were two modules?
>> Do you really need two module_init() calls (can't one be called from the
>> other)?
>> What is the tear-down portion of this (module_exit)?
>
> No, this is not a left-over from the previous 2-module implementation of
> the cxl driver.
> The file base.c is not part of the "normal" cxl driver. It is either
> part of the kernel if the cxl driver is a module or configured in the
> kernel. Or it is discarded if cxl is not even a module. So code in that
> file is either in the kernel or it's not even compiled. That was already
> the case on bare-metal.
> Code in module_init() is executed when the kernel boots and it is not
> going away.
>
>    Fred

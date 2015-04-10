Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D3A81A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 20:55:59 +1000 (AEST)
Message-ID: <1428663358.21137.4.camel@ellerman.id.au>
Subject: Re: [RFC v2 powerpc] perf/hv-24x7  fail 24x7 initcall if
 create_events_from_catalog() fails
From: Michael Ellerman <mpe@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Date: Fri, 10 Apr 2015 20:55:58 +1000
In-Reply-To: <1428655351.16563.11.camel@TP420>
References: <1423993377.2932.23.camel@TP420>
 <20150325095120.8F48F1400EA@ozlabs.org> <20150325184153.GA6579@us.ibm.com>
 <1427341876.16501.2.camel@ellerman.id.au> <1428655351.16563.11.camel@TP420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 16:42 +0800, Li Zhong wrote:
> As Michael pointed out, create_events_from_catalog() fails when 
> we either have:
>  - a kernel bug
>  - some sort of hypervisor misconfiguration
>  - ENOMEM
> 
> In all the above cases, we can also fail 24x7 initcall. 

Thanks.
 
> In the patch below, I used ENODEV for hypervisor errors, not sure 
> whether some other error values is more proper here. 

ENODEV is a special case, if an initcall returns ENODEV no error is reported to
dmesg.

In this case I think we would like an error to be reported, so EIO would be
better I think.

cheers

Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svr9M2VD2zDt09
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 23:47:35 +1100 (AEDT)
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3svr9L5sLkz9ryZ
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2016 23:47:34 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id hh10so4783198pac.0
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2016 05:47:34 -0700 (PDT)
Subject: Re: [PATCH] powerpc/mm: Drop dump_numa_memory_topology()
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1476336450-27862-1-git-send-email-mpe@ellerman.id.au>
Cc: anton@samba.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f10b9e4e-da30-fea5-5e02-b65b014ad527@gmail.com>
Date: Thu, 13 Oct 2016 23:47:34 +1100
MIME-Version: 1.0
In-Reply-To: <1476336450-27862-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/10/16 16:27, Michael Ellerman wrote:
> At boot we dump the NUMA memory topology in dump_numa_memory_topology(),
> at KERN_DEBUG level, resulting in output like:
> 
>   Node 0 Memory: 0x0-0x100000000
>   Node 1 Memory: 0x100000000-0x200000000
> 
> Which is nice enough, but immediately after that we iterate over each
> node and call setup_node_data(), which also prints out the node ranges,
> at KERN_INFO, giving eg:
> 
>   numa: Initmem setup node 0 [mem 0x00000000-0xffffffff]
>   numa: Initmem setup node 1 [mem 0x100000000-0x1ffffffff]
> 
> So drop dump_numa_memory_topology() as superfluous chatter.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---


Actually the ranges for the lower output seem a little better
(inclusive), the output on top is not clear

Acked-by: Balbir Singh <bsingharora@gmail.com>

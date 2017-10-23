Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x234.google.com (mail-pg0-x234.google.com
 [IPv6:2607:f8b0:400e:c05::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL1FC35FRzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 13:53:51 +1100 (AEDT)
Received: by mail-pg0-x234.google.com with SMTP id l24so10647870pgu.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Oct 2017 19:53:50 -0700 (PDT)
Date: Mon, 23 Oct 2017 13:53:38 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: "Stephen  Bates" <sbates@raithlin.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Logan
 Gunthorpe" <logang@deltatee.com>
Subject: Re: lpar issue for ZONE_DEVICE p2pmem in 4.14-rc
Message-ID: <20171023135338.58d0ab31@MiWiFi-R3-srv>
In-Reply-To: <AF0CC512-DC7D-45EB-B1AB-7132B48C38E1@raithlin.com>
References: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
 <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
 <AF0CC512-DC7D-45EB-B1AB-7132B48C38E1@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 21 Oct 2017 15:03:29 +0000
"Stephen  Bates" <sbates@raithlin.com> wrote:

> > I am guessing that the hotplug of ZONE_DEVICE memory was done
> > incorrectly as it lead to HPT resizing (the system thinking this is
> > normal memory). Ideally one would expect that the driver would online
> > ZONE_DEVICE memory and not go through the HOTPLUG path. Are you using
> > devm_memremap_pages() path to add these pages?
> >  
> 
> Thanks for the response Balbir. Yes we use devm_memremap_pages() to add these pages and it does call arch_add_memory(). We do have an alternate set of patches which still calls devm_memremap_pages() but can take a flag to indicate the memory being added is io memory and uses io_remap() rather than arch_add_memory() for that type of memory [1]. Would that be a better approach for this arch? I can try and apply this patch but __add_pages() has gone through some changes recently so it will take me a few days to get to that. 

I just double checked, for pmem you do need to come in via arch_add_memory(). I was confused
by what we do for HMM, which is call __add_pages(), but we do need a section mapping so
the interface is correct.

The following

[    3.537780] lpar: Attempting to resize HPT to shift 21
[    3.539251] Unable to resize hash page table to target order 21: -1
[    3.541079] Unable to create mapping for hot added memory 0xc000210000000000..0xc000210004000000: -2

Needs to be debugged further. For #1 above please check if your qemu supports
H_RESIZE_HPT_* hcalls? For create mapping failures, the rc is -ENOENT. Can
you help debug this further? We could do hcall tracing or enable debugging.

Balbir Singh.

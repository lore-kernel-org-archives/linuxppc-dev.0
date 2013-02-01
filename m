Return-Path: <simon.jeons@gmail.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com
 [IPv6:2607:f8b0:4001:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BF8A2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 13:48:22 +1100 (EST)
Received: by mail-ie0-f175.google.com with SMTP id c12so3014877ieb.20
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 18:48:19 -0800 (PST)
Message-ID: <1359685040.1303.6.camel@kernel>
Subject: Re: [PATCH v6 00/15] memory-hotplug: hot-remove physical memory
From: Simon Jeons <simon.jeons@gmail.com>
To: Tang Chen <tangchen@cn.fujitsu.com>
Date: Thu, 31 Jan 2013 20:17:20 -0600
In-Reply-To: <510B20F9.10408@cn.fujitsu.com>
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1359463973.1624.15.camel@kernel> <5108F2B3.3090506@cn.fujitsu.com>
 <1359595344.1557.13.camel@kernel> <5109E59F.5080104@cn.fujitsu.com>
 <1359613162.1587.0.camel@kernel> <510A18FA.2010107@cn.fujitsu.com>
 <1359622123.1391.19.camel@kernel> <510A3CE6.202@cn.fujitsu.com>
 <1359628705.2048.5.camel@kernel> <510B1B4B.5080207@huawei.com>
 <1359682576.3574.1.camel@kernel> <510B20F9.10408@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, glommer@parallels.com,
 Jianguo Wu <wujianguo@huawei.com>, yinghai@kernel.org, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tang,
On Fri, 2013-02-01 at 09:57 +0800, Tang Chen wrote:
> On 02/01/2013 09:36 AM, Simon Jeons wrote:
> > On Fri, 2013-02-01 at 09:32 +0800, Jianguo Wu wrote:
> >>>
> >>> So if config NUMA, kernel memory will not be linear mapping anymore? For
> >>> example,
> >>>
> >>> Node 0  Node 1
> >>>
> >>> 0 ~ 10G 11G~14G
> 
> It has nothing to do with linear mapping, I think.
> 
> >>>
> >>> kernel memory only at Node 0? Can part of kernel memory also at Node 1?
> 
> Please refer to find_zone_movable_pfns_for_nodes().

I see, thanks. :)

> The kernel is not only on node0. It uses all the online nodes evenly. :)
> 
> >>>
> >>> How big is kernel direct mapping memory in x86_64? Is there max limit?
> >>
> >>
> >> Max kernel direct mapping memory in x86_64 is 64TB.
> >
> > For example, I have 8G memory, all of them will be direct mapping for
> > kernel? then userspace memory allocated from where?
> 
> I think you misunderstood what Wu tried to say. :)
> 
> The kernel mapped that large space, it doesn't mean it is using that 
> large space.
> The mapping is to make kernel be able to access all the memory, not for 
> the kernel
> to use only. User space can also use the memory, but each process has 
> its own mapping.
> 
> For example:
> 
>                                         64TB, what ever 
>     xxxTB, what ever
> logic address space:     |_____kernel_______|_________user_________________|
>                                         \  \  /  /
>                                          \  /\  /
> physical address space:              |___\/__\/_____________|  4GB or 
> 8GB, what ever
>                                            *****

How much address space user process can have on x86_64? Also 8GB?

> 
> The ***** part physical is mapped to user space in the process' own 
> pagetable.
> It is also direct mapped in kernel's pagetable. So the kernel can also 
> access it. :)

But how to protect user process not modify kernel memory?

> 
> >
> >>
> >>> It seems that only around 896MB on x86_32.
> >>>
> >>>>
> >>>> We need firmware take part in, such as SRAT in ACPI BIOS, or the firmware
> >>>> based memory migration mentioned by Liu Jiang.
> >>>
> >>> Is there any material about firmware based memory migration?
> 
> No, I don't have any because this is a functionality of machine from HUAWEI.
> I think you can ask Liu Jiang or Wu Jianguo to share some with you. :)
> 
> Thanks. :)

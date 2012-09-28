Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 07D162C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 12:00:33 +1000 (EST)
Message-ID: <5065005A.4020907@cn.fujitsu.com>
Date: Fri, 28 Sep 2012 09:41:46 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: Re: [RFC v9 PATCH 00/21] memory-hotplug: hot-remove physical memory
References: <1346837155-534-1-git-send-email-wency@cn.fujitsu.com>
 <20120926164649.GA7559@dhcp-192-168-178-175.profitbricks.localdomain>
 <5063F41A.3010600@cn.fujitsu.com>
 <20120927103557.GA30772@dhcp-192-168-178-175.profitbricks.localdomain>
In-Reply-To: <20120927103557.GA30772@dhcp-192-168-178-175.profitbricks.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 09/27/2012 06:35 PM, Vasilis Liaskovitis Wrote:
> On Thu, Sep 27, 2012 at 02:37:14PM +0800, Wen Congyang wrote:
>> Hi Vasilis Liaskovitis
>>
>> At 09/27/2012 12:46 AM, Vasilis Liaskovitis Wrote:
>>> Hi,
>>>
>>> I am testing 3.6.0-rc7 with this v9 patchset plus more recent fixes [1],[2],[3]
>>> Running in a guest (qemu+seabios from [4]). 
>>> CONFIG_SLAB=y
>>> CONFIG_DEBUG_SLAB=y
>>>
>>> After succesfull hot-add and online, I am doing a hot-remove with "echo 1 > /sys/bus/acpi/devices/PNP/eject"
>>> When I do the OSPM-eject, I often get slab corruption in "acpi-state" cache, or in other caches
>>
>> I can't reproduce this problem. Can you provide the following information:
>> 1. config file
>> 2. qemu's command line
>>
>> You said you did OSPM-eject. Do you mean write 1 to /sys/bus/acpi/devices/PNP0C80:XX/eject?
> yes.
> 
> example qemu command line with one dimm:
> 
> "/opt/qemu-kvm-memhp/bin/qemu-system-x86_64 -bios
> /opt/extra/vliaskov/devel/seabios-upstream/out/bios.bin -enable-kvm -M pc -smp
> 4,maxcpus=8 -cpu host -m 2048 -drive file=/opt/extra/debian-template.raw,if=none,id=drive-virtio-disk0,format=raw
> -device virtio-blk-pci,bus=pci.0,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
> -vga cirrus -netdev type=tap,id=guest0,vhost=on -device virtio-net-pci,netdev=guest0
> -monitor unix:/tmp/qemu.monitor11,server,nowait -chardev stdio,id=seabios  -device
> isa-debugcon,iobase=0x402,chardev=seabios
> -dimm id=n0,size=512M,node=0"
> 
> or last line with 2 numa nodes:
> "-dimm id=n0,size=512M,node=0 -dimm id=n1,size=512M,node=1 -numa node,nodeid=0 -numa node,nodeid=1"

I have reproduced this problem. It only can be reproduced when the dimm's memory is on node 0.
I investigate it now.

Thanks
Wen Congyang

> 
> attached config. Tree is at:
> https://github.com/vliaskov/linux/commits/memhp-fujitsu
> 
> thanks,
> - Vasilis

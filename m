Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGpHk1MZhzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 08:29:53 +1100 (AEDT)
Received: by mail-vk0-x243.google.com with SMTP id q13so2071246vkb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 14:29:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
References: <2A16FB2A-71B2-41F1-993C-5A66DB2ADB1F@raithlin.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 18 Oct 2017 08:29:49 +1100
Message-ID: <CAKTCnz=6ab=TCWFOknvAq2QxoXbTMhDfQMt5wOFzzUoYJRnUMA@mail.gmail.com>
Subject: Re: lpar issue for ZONE_DEVICE p2pmem in 4.14-rc
To: Stephen Bates <sbates@raithlin.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2017 at 7:38 AM, Stephen  Bates <sbates@raithlin.com> wrote=
:
> Hi All
>
> I am hoping someone can help shed some light on an issue I am seeing with=
 my attempt to add p2pmem [1] to the ppc64el kernel. p2pmem is a (currently=
) out-of-tree patchset that allows one to add device memory with struct pag=
e backing into the Linux kernel. It leverages MEMORY_HOTPLUG and ZONE_DEVIC=
E which were added to ppc64 in 4.14 so I thought it would be fun to try it =
out.
>
> We constructed a patchset based off 4.14-rc1 [1] and build a kernel based=
 off the pseries defconfig and ran this on upstream qemu-system-ppc64. The =
exact command to run QEMU was:
>
> qemu-system-ppc64 \
>     -machine pseries \
>     -cpu power8 \
>     -smp 1 -m 2048 \
>     -kernel ~/kernel/linux-ppc64el/vmlinux \
>     -append "nvme.use_cmb=3D24 console=3Dhvc root=3D/dev/sda rootwait rw"=
 \
>     -serial mon:stdio -drive file=3Dimage-ppc64el.img,if=3Dscsi,format=3D=
raw,index=3D0 \
>     -nographic \
>     -drive file=3D../images/nvme.qcow2,if=3Dnone,id=3Dnvme1,snapshot=3Don=
 \
>     -device nvme,drive=3Dnvme1,serial=3Dnvme1 \
>     -drive file=3D../images/nvme2.qcow2,if=3Dnone,id=3Dnvme2,snapshot=3Do=
n \
>     -device nvme,drive=3Dnvme2,serial=3Dnvme2,cmb_size_mb=3D64
>
> This resulted in the following extract from dmesg when registering the p2=
pmem associated with one of the NVMe SSDs.
>
> [    3.508497] nvme 0000:00:03.0: enabling device (0100 -> 0102)
> [    3.510743] nvme 0000:00:03.0: Using 64-bit direct DMA at offset 80000=
0000000000
> [    3.535706] p2pmem p2pmem0: registered
> [    3.537780] lpar: Attempting to resize HPT to shift 21
> [    3.539251] Unable to resize hash page table to target order 21: -1

I am guessing that the hotplug of ZONE_DEVICE memory was done
incorrectly as it lead to HPT resizing (the system thinking this is
normal memory). Ideally one would expect that the driver would online
ZONE_DEVICE memory and not go through the HOTPLUG path. Are you using
devm_memremap_pages() path to add these pages?

Balbir Singh.

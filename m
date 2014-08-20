Return-Path: <bhelgaas@google.com>
Received: from mail-qg0-x233.google.com (mail-qg0-x233.google.com
 [IPv6:2607:f8b0:400d:c04::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 243A11A0037
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 13:12:51 +1000 (EST)
Received: by mail-qg0-f51.google.com with SMTP id a108so6793455qge.24
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 20:12:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140820023404.GC6904@richard>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20140819211942.GA6295@google.com> <20140820023404.GC6904@richard>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 Aug 2014 22:12:27 -0500
Message-ID: <CAErSpo5Dm4Eu0TcvJn2fYLVd005OgJCy-yZAhqsttjbb8jwm=A@mail.gmail.com>
Subject: Re: [PATCH V7 00/17] Enable SRIOV on POWER8
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Mike Qiu <qiudayu@linux.vnet.ibm.com>,
 Guo Chao <yan@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2014 at 9:34 PM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Tue, Aug 19, 2014 at 03:19:42PM -0600, Bjorn Helgaas wrote:
>>On Thu, Jul 24, 2014 at 02:22:10PM +0800, Wei Yang wrote:
>>> This patch set enables the SRIOV on POWER8.
>>>
>>> The gerneral idea is put each VF into one individual PE and allocate required
>>> resources like DMA/MSI.
>>>
>>> One thing special for VF PE is we use M64BT to cover the IOV BAR. M64BT is one
>>> hardware on POWER platform to map MMIO address to PE. By using M64BT, we could
>>> map one individual VF to a VF PE, which introduce more flexiblity to users.
>>>
>>> To achieve this effect, we need to do some hack on pci devices's resources.
>>> 1. Expand the IOV BAR properly.
>>>    Done by pnv_pci_ioda_fixup_iov_resources().
>>> 2. Shift the IOV BAR properly.
>>>    Done by pnv_pci_vf_resource_shift().
>>> 3. IOV BAR alignment is the total size instead of an individual size on
>>>    powernv platform.
>>>    Done by pnv_pcibios_sriov_resource_alignment().
>>> 4. Take the IOV BAR alignment into consideration in the sizing and assigning.
>>>    This is achieved by commit: "PCI: Take additional IOV BAR alignment in
>>>    sizing and assigning"
>>>
>>> Test Environment:
>>>        The SRIOV device tested is Emulex Lancer and Mellanox ConnectX-3 on
>>>        POWER8.
>>>
>>> Examples on pass through a VF to guest through vfio:
>>>      1. install necessary modules
>>>         modprobe vfio
>>>         modprobe vfio-pci
>>>      2. retrieve the iommu_group the device belongs to
>>>         readlink /sys/bus/pci/devices/0000:06:0d.0/iommu_group
>>>         ../../../../kernel/iommu_groups/26
>>>         This means it belongs to group 26
>>>      3. see how many devices under this iommu_group
>>>         ls /sys/kernel/iommu_groups/26/devices/
>>>      4. unbind the original driver and bind to vfio-pci driver
>>>         echo 0000:06:0d.0 > /sys/bus/pci/devices/0000:06:0d.0/driver/unbind
>>>         echo  1102 0002 > /sys/bus/pci/drivers/vfio-pci/new_id
>>>         Note: this should be done for each device in the same iommu_group
>>>      5. Start qemu and pass device through vfio
>>>         /home/ywywyang/git/qemu-impreza/ppc64-softmmu/qemu-system-ppc64 \
>>>                 -M pseries -m 2048 -enable-kvm -nographic \
>>>                 -drive file=/home/ywywyang/kvm/fc19.img \
>>>                 -monitor telnet:localhost:5435,server,nowait -boot cd \
>>>                 -device "spapr-pci-vfio-host-bridge,id=CXGB3,iommu=26,index=6"
>>>
>>> Verify this is the exact VF response:
>>>      1. ping from a machine in the same subnet(the broadcast domain)
>>>      2. run arp -n on this machine
>>>         9.115.251.20             ether   00:00:c9:df:ed:bf   C eth0
>>>      3. ifconfig in the guest
>>>         # ifconfig eth1
>>>         eth1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
>>>              inet 9.115.251.20  netmask 255.255.255.0  broadcast 9.115.251.255
>>>              inet6 fe80::200:c9ff:fedf:edbf  prefixlen 64  scopeid 0x20<link>
>>>              ether 00:00:c9:df:ed:bf  txqueuelen 1000 (Ethernet)
>>>              RX packets 175  bytes 13278 (12.9 KiB)
>>>              RX errors 0  dropped 0  overruns 0  frame 0
>>>              TX packets 58  bytes 9276 (9.0 KiB)
>>>              TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
>>>      4. They have the same MAC address
>>>
>>>      Note: make sure you shutdown other network interfaces in guest.
>>>
>>> ---
>>> v6 -> v7:
>>>    1. add IORESOURCE_ARCH flag for IOV BAR on powernv platform.
>>>    2. when IOV BAR has IORESOURCE_ARCH flag, the size is retrieved from
>>>       hardware directly. If not, calculate as usual.
>>>    3. reorder the patch set, group them by subsystem:
>>>       PCI, powerpc, powernv
>>>    4. rebase it on 3.16-rc6
>>
>>This doesn't apply for me on v3.16-rc6:
>>
>>  02:48:57 ~/linux$ stg rebase v3.16-rc6
>>  Checking for changes in the working directory ... done
>>  Rebasing to "v3.16-rc6" ... done
>>  No patches applied
>>  02:49:14 ~/linux$ stg import -M --sign m/wy
>>  Checking for changes in the working directory ... done
>>  Importing patch "pci-iov-export-interface-for" ... done
>>  Importing patch "pci-iov-get-vf-bar-size-from" ... done
>>  Importing patch "pci-add-weak" ... done
>>  Importing patch "pci-take-additional-iov-bar" ... done
>>  Importing patch "powerpc-pci-don-t-unset-pci" ... done
>>  Importing patch "powerpc-pci-define" ... done
>>  Importing patch "powrepc-pci-refactor-pci_dn" ... done
>>  Importing patch "powerpc-powernv-use-pci_dn-in" ... error: patch failed:
>>  arch/powerpc/platforms/powernv/pci.c:376
>>  error: arch/powerpc/platforms/powernv/pci.c: patch does not apply
>>  stg import: Diff does not apply cleanly
>>
>>What am I missing?
>>
>>I assume you intend these all to go through my tree just to keep them all
>>together.  The ideal rebase target for me would be v3.17-rc1.
>
> Ok, I will rebase it on v3.17-rc1 upstream. While I guess the conflict is due
> to some patches from Gavin, which is not merged at that moment. I will make
> sure it applies to v3.17-rc1.

I tried applying them on v3.16-rc6 as well as on every change to
arch/powerpc/platforms/powernv/pci.c between v3.16-rc6 and v3.17-rc1,
and none applied cleanly.  Patches you post should be based on some
upstream tag, not on something that includes unmerged patches.

Bjorn

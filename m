Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfCMp0MsYzDqKQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 15:25:09 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v525NsvW146771
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 01:25:02 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ats3sescg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 01:25:02 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 23:25:01 -0600
Subject: Re: [Patch 2/2]: powerpc/hotplug/mm: Fix hot-add memory node assoc
To: Michael Ellerman <mpe@ellerman.id.au>,
 Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Shailendra Singh <shailendras@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
References: <3bb44d92-b2ff-e197-4bdf-ec6d588d6dab@linux.vnet.ibm.com>
 <20170523155251.bqwc5mc4jpgzkqlm@arbab-laptop.localdomain>
 <1c1d70e3-4e45-b035-0e75-1b0f531c111b@linux.vnet.ibm.com>
 <20170523214922.bns675oqzqj4pkhc@arbab-laptop.localdomain>
 <ee96df3d-ad0f-c4dc-e7d5-290018ec8afd@linux.vnet.ibm.com>
 <87poeya4dt.fsf@concordia.ellerman.id.au>
 <8e2417d8-d108-2949-40f2-997d53a3f367@linux.vnet.ibm.com>
 <87a861a25y.fsf@concordia.ellerman.id.au>
 <20170525151011.m4ae4ipxbqsj3mn7@arbab-laptop.localdomain>
 <87zie08ekt.fsf@concordia.ellerman.id.au>
 <20170526143147.z4lmtrs7vowucbkf@arbab-laptop.localdomain>
 <87lgpg6xe2.fsf@concordia.ellerman.id.au>
 <54877b2b-8446-20f6-e316-25af809ae11f@linux.vnet.ibm.com>
 <87tw402go0.fsf@concordia.ellerman.id.au>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Fri, 2 Jun 2017 00:24:54 -0500
MIME-Version: 1.0
In-Reply-To: <87tw402go0.fsf@concordia.ellerman.id.au>
Content-Type: multipart/mixed; boundary="------------6B63FE12B3F1A5388F30DE40"
Message-Id: <54ebacf1-1249-cc6a-80a5-b293e581f401@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------6B63FE12B3F1A5388F30DE40
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit



On 06/01/2017 04:36 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> On 05/29/2017 12:32 AM, Michael Ellerman wrote:
>>> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>>>
>>>> On Fri, May 26, 2017 at 01:46:58PM +1000, Michael Ellerman wrote:
>>>>> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>>>>>
>>>>>> On Thu, May 25, 2017 at 04:19:53PM +1000, Michael Ellerman wrote:
>>>>>>> The commit message for 3af229f2071f says:
>>>>>>>
>>>>>>>    In practice, we never see a system with 256 NUMA nodes, and in fact, we
>>>>>>>    do not support node hotplug on power in the first place, so the nodes
>>>>>>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>>>    that are online when we come up are the nodes that will be present for
>>>>>>>    the lifetime of this kernel.
>>>>>>>
>>>>>>> Is that no longer true?
>>>>>>
>>>>>> I don't know what the reasoning behind that statement was at the time,
>>>>>> but as far as I can tell, the only thing missing for node hotplug now is
>>>>>> Balbir's patchset [1]. He fixes the resource issue which motivated
>>>>>> 3af229f2071f and reverts it.
>>>>>>
>>>>>> With that set, I can instantiate a new numa node just by doing
>>>>>> add_memory(nid, ...) where nid doesn't currently exist.
>>>>>
>>>>> But does that actually happen on any real system?
>>>>
>>>> I don't know if anything currently tries to do this. My interest in 
>>>> having this working is so that in the future, our coherent gpu memory 
>>>> could be added as a distinct node by the device driver.
>>>
>>> Sure. If/when that happens, we would hopefully still have some way to
>>> limit the size of the possible map.
>>>
>>> That would ideally be a firmware property that tells us the maximum
>>> number of GPUs that might be hot-added, or we punt and cap it at some
>>> "sane" maximum number.
>>>
>>> But until that happens it's silly to say we can have up to 256 nodes
>>> when in practice most of our systems have 8 or less.
>>>
>>> So I'm still waiting for an explanation from Michael B on how he's
>>> seeing this bug in practice.
>>
>> I already answered this in an earlier message.
> 
> Which one? I must have missed it.
> 
>> I will give an example.
>>
>> * Let there be a configuration with nodes (0, 4-5, 8) that boots with 1 VP
>>   and 10G of memory in a shared processor configuration.
>> * At boot time, 4 nodes are put into the possible map by the PowerPC boot
>>   code.
> 
> I'm pretty sure we never add nodes to the possible map, it starts out
> with MAX_NUMNODES possible and that's it.

Let me reword that.  It enables the nodes in the possible map.

> 
> Do you actually see mention of nodes 0 and 8 in the dmesg?

When the 'numa.c' code is built with debug messages, and the system was
given that configuration by pHyp, yes, I did.

> 
> What does it say?

The debug message for each core thread would be something like,

    removing cpu 64 from node 0
    adding cpu 64 to node 8

repeated for all 8 threads of the CPU, and usually with the messages
for all of the CPUs coming out intermixed on the console/dmesg log.

> 
>> * Subsequently, the NUMA code executes and puts the 10G memory into nodes
>>   4 & 5.  No memory goes into Node 0.  So we now have 2 nodes in the
>>   node_online_map.
>> * The VP and its threads get assigned to Node 4.
>> * Then when 'initmem_init()' in 'powerpc/numa.c' executes the instruction,
>>      node_and(node_possible_map, node_possible_map, node_online_map);
>>   the content of the node_possible_map is reduced to nodes 4-5.
>> * Later on we hot-add 90G of memory to the system.  It tries to put the
>>   memory into nodes 0, 4-5, 8 based on the memory association map.  We
>>   should see memory put into all 4 nodes.  However, since we have reduced
>>   the 'node_possible_map' to only nodes 4 & 5, we can now only put memory
>>   into 2 of the configured nodes.
> 
> Right. So it's not that you're hot adding memory into a previously
> unseen node as you implied in earlier mails.

In the sense that the nodes were defined in the device tree, that is correct.

In the sense that those nodes are currently deleted from node_possible_map in
'numa.c' by the instruction 'node_and(node_possible_map,node_possible_map,
node_online_map);', the nodes are no longer available to place memory or CPU.

>> # We want to be able to put memory into all 4 nodes via hot-add operations,
>>   not only the nodes that 'survive' boot time initialization.  We could
>>   make a number of changes to ensure that all of the nodes in the initial
>>   configuration provided by the pHyp can be used, but this one appears to
>>   be the simplest, only using resources requested by the pHyp at boot --
>>   even if those resource are not used immediately.
> 
> I don't think that's what the patch does. It just marks 32 (!?) nodes as
> online. Or if you're talking about reverting 3af229f2071f that leaves
> you with 256 possible nodes. Both of which are wasteful> > The right fix is to make sure any nodes which are present at boot remain
> in the possible map, even if they don't have memory/CPUs assigned at
> boot.

Okay, I can try to insert code that extracts all of the nodes from the
ibm,associativity-lookup-arrays property and merge them with the nodes
put into the online map from the CPUs that were found previously during
boot of the powerpc code.

> What does your device tree look like? Can you send us the output of:
> 
>  $ lsprop /proc/device-tree

See attachment 'device-tree.log'.  Note though that this boot of my test
system only has 2 nodes, 0 and 2.

> 
> cheers
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

--------------6B63FE12B3F1A5388F30DE40
Content-Type: text/x-log;
 name="device-tree.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="device-tree.log"

ibm,partition-name
		 "ltcalpine2-lp20"
ibm,aix-diagnostics
	=09
ibm,drc-names    0000219e 4c4d4233 004c4d42 34004c4d
		 4235004c 4d423600 4c4d4237 004c4d42
		 38004c4d 4239004c 4d423130 004c4d42
		 3131004c 4d423132 004c4d42 3133004c
		 4d423134 004c4d42 3135004c 4d423136
		 004c4d42 3137004c 4d423138 004c4d42
		 3139004c 4d423230 004c4d42 3231004c
		 4d423232 004c4d42 3233004c 4d423234
		 [73812 bytes total]
hmc-managed?     ffffffff ffffffff
ibm,drc-types    0000219e 4d454d00 4d454d00 4d454d00
		 4d454d00 4d454d00 4d454d00 4d454d00
		 4d454d00 4d454d00 4d454d00 4d454d00
		 4d454d00 4d454d00 4d454d00 4d454d00
		 4d454d00 4d454d00 4d454d00 4d454d00
		 4d454d00 4d454d00 4d454d00 4d454d00
		 4d454d00 4d454d00 4d454d00 4d454d00
		 4d454d00 4d454d00 4d454d00 4d454d00
		 [34428 bytes total]
compatible       "IBM,8408-E8E"
ibm,extended-clock-frequency
		 00000000 00000000
ibm,max-boot-devices
		 00000005
ibm,drc-indexes  0000219e 80000002 80000003 80000004
		 80000005 80000006 80000007 80000008
		 80000009 8000000a 8000000b 8000000c
		 8000000d 8000000e 8000000f 80000010
		 80000011 80000012 80000013 80000014
		 80000015 80000016 80000017 80000018
		 80000019 8000001a 8000001b 8000001c
		 8000001d 8000001e 8000001f 80000020
		 [34428 bytes total]
ibm,max-vios-function-level
		 00000000
device_type      "chrp"
ibm,fw-bytes-per-boot-device
		 00000100 (256)
ibm,fw-net-compatibility
		 "1"
ibm,service-indicator-mode
		 00000001
ibm,model-class  "E5"
ibm,partition-performance-parameters-level
		 00000001
model            "IBM,8408-E8E"
ibm,partition-no 00000014 (20)
ibm,migratable-partition
	=09
#address-cells   00000002
ibm,fru-9006-deactivate
		 00000001
#size-cells      00000002
ibm,drc-power-domains
		 0000219e ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 [34428 bytes total]
ibm,fw-net-version
		 "bPF160504 00:04:36 /gsa/ausgsa-p1/01/pfw/pfw860/PF160504/obj/rios_aix=
_4/of"
ibm,partition-uuid
		 "205f9615-9df1-4423-afb0-60d21df83633"
ibm,plat-res-int-priorities
		 0000000c 000000e4
clock-frequency  00000000
ibm,converged-loc-codes
	=09
ibm,phandle      ffffffff (-1)
ibm,fault-behavior
		 00000001
ibm,platform-hardware-notification
		 00000001 504f5745 52385f30 30344230 32303100
ibm,eeh-default  00000001
linux,phandle    00c91548 (13178184)
ibm,ignore-hp-po-fails-for-dlpar
	=09
ibm,enable-ci64-capable
	=09
system-id        "IBM,0210A7ACV"
ibm,extended-address
	=09
name             ""
ibm,pci-full-cfg 00000001
ibm,lpar-capable
ibm,linux-le-capable
	=09

/proc/device-tree/ibm,serial:
compatible       "hvterm1"
device_type      "serial"
linux,phandle    00c9c140 (13222208)
used-by-rtas   =20
name             "ibm,serial"

/proc/device-tree/vdevice:
interrupt-ranges 000a0000 000001f3
ibm,drc-names    000001f4 55383430 382e4538 452e3130
		 41374143 562d5632 302d4330 00553834
		 30382e45 38452e31 30413741 43562d56
		 32302d43 31005538 3430382e 4538452e
		 31304137 4143562d 5632302d 43320055
		 38343038 2e453845 2e313041 37414356
		 2d563230 2d433300 55383430 382e4538
		 452e3130 41374143 562d5632 302d4334
		 [13394 bytes total]
ibm,drc-types    000001f4 534c4f54 00534c4f 5400534c
		 4f540053 4c4f5400 534c4f54 00534c4f
		 5400534c 4f540053 4c4f5400 534c4f54
		 00534c4f 5400534c 4f540053 4c4f5400
		 534c4f54 00534c4f 5400534c 4f540053
		 4c4f5400 534c4f54 00534c4f 5400534c
		 4f540053 4c4f5400 534c4f54 00534c4f
		 5400534c 4f540053 4c4f5400 534c4f54
		 [2504 bytes total]
compatible       "IBM,vdevice"
ibm,max-virtual-dma-size
		 00050000 (327680)
ibm,drc-indexes  000001f4 30000000 30000001 30000002
		 30000003 30000004 30000005 30000006
		 30000007 30000008 30000009 3000000a
		 3000000b 3000000c 3000000d 3000000e
		 3000000f 30000010 30000011 30000012
		 30000013 30000014 30000015 30000016
		 30000017 30000018 30000019 3000001a
		 3000001b 3000001c 3000001d 3000001e
		 [2004 bytes total]
device_type      "vdevice"
#interrupt-cells 00000002
#address-cells   00000001
#size-cells      00000000
ibm,drc-power-domains
		 000001f4 ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 [2004 bytes total]
ibm,reserved-virtual-addresses
		 00000fff ffd1fff0 00010000 00000fff
		 ffd2fff0 00010000 00000fff ffd3fff0
		 00010000 00000fff ffd4fff0 00010000
		 00000fff ffd5fff0 00010000 00000fff
		 ffd6fff0 00010000 00000fff ffd7fff0
		 00010000 00000fff ffd8fff0 00010000
		 00000fff ffd9fff0 00010000 00000fff
		 ffdafff0 00010000 00000fff ffdbfff0
		 [540 bytes total]
ibm,phandle      fffffffc (-4)
linux,phandle    00e0f338 (14742328)
name             "vdevice"
interrupt-controller
	=09

/proc/device-tree/vdevice/rtc@4001:
device_type      "rtc"
reg              00004001 (16385)
linux,phandle    00e3f240 (14938688)
ibm,fw-device-code
		 da190000
used-by-rtas   =20
name             "rtc"

/proc/device-tree/vdevice/IBM,sp@4000:
device_type      "IBM,sp"
reg              00004000 (16384)
linux,phandle    00e3e738 (14935864)
used-by-rtas   =20
name             "IBM,sp"

/proc/device-tree/vdevice/gscsi@4004:
device_type      "scsi-2"
#address-cells   00000001
#size-cells      00000000
reg              00004004 (16388)
linux,phandle    00e3fe40 (14941760)
used-by-rtas   =20
name             "gscsi"

/proc/device-tree/vdevice/gscsi@4004/disk:
device_type      "block"
ibm,write-supported
	=09
linux,phandle    00e40738 (14944056)
name             "disk"

/proc/device-tree/vdevice/v-scsi@30000078:
ibm,#vscsi-address-bits
		 00000040 (64)
ibm,#dma-size-cells
		 00000002
compatible       "IBM,v-scsi"
ibm,fw-adapter-name
		 "Virtual SCSI"
device_type      "vscsi"
ibm,my-drc-index 30000078 (805306488)
ibm,#dma-address-cells
		 00000002
interrupts       000a0078 00000000
ibm,write-blocks-supported
	=09
ibm,my-dma-window
		 10000078 00000000 00000000 00000000 20000000
ibm,loc-code     "U8408.E8E.10A7ACV-V20-C120-T1"
reg              30000078 (805306488)
ibm,phandle      30000078 (805306488)
linux,phandle    00e25560 (14832992)
name             "v-scsi"

/proc/device-tree/vdevice/v-scsi@30000078/disk:
device_type      "block"
ibm,write-supported
	=09
ibm,16byte-cdb-supported
	=09
linux,phandle    00e2d478 (14865528)
name             "disk"

/proc/device-tree/vdevice/v-scsi@30000078/tape:
device_type      "byte"
linux,phandle    00e2fd90 (14876048)
name             "tape"

/proc/device-tree/vdevice/nvram@4002:
device_type      "nvram"
#bytes           00003c00 (15360)
reg              00004002 (16386)
linux,phandle    00e3fb50 (14941008)
used-by-rtas   =20
name             "nvram"

/proc/device-tree/vdevice/l-lan@30000002:
ibm,#dma-size-cells
		 00000002
compatible       "IBM,l-lan"
mac-address      ba 68 98 2a 1b 02                              .h.*..
ibm,illan-options
	=09
local-mac-address
		 ba 68 98 2a 1b 02                              .h.*..
ibm,fw-adapter-name
		 "Interpartition Logical LAN"
device_type      "network"
max-frame-size   000005dc (1500)
ibm,my-drc-index 30000002 (805306370)
supported-network-types
		 "ethernet,auto,none,auto"
ibm,mac-address-filters
		 000000ff (255)
ibm,#dma-address-cells
		 00000002
interrupts       000a0002 00000000
chosen-network-type
		 "ethernet,auto,none,auto"
ibm,vserver    =20
address-bits     00000030 (48)
ibm,my-dma-window
		 10000002 00000000 00000000 00000000 10000000
ibm,loc-code     "U8408.E8E.10A7ACV-V20-C2-T1"
reg              30000002 (805306370)
ibm,phandle      30000002 (805306370)
linux,phandle    00e1d2b0 (14799536)
name             "l-lan"

/proc/device-tree/vdevice/vty@30000000:
compatible       "hvterm1"
device_type      "serial"
ibm,my-drc-index "0"
		 ""
		 ""
interrupts       000a0000 00000000
ibm,loc-code     "U8408.E8E.10A7ACV-V20-C0"
reg              "0"
		 ""
		 ""
ibm,phandle      "0"
		 ""
		 ""
linux,phandle    00e1b528 (14791976)
name             "vty"

/proc/device-tree/memory@0:
device_type      "memory"
ibm,associativity
		 00000004 00000000 00000001 00000002 00000002
available        00000000 001fffff 00000000 00000001
		 00000000 0021ffff 00000000 00000001
		 00000000 00bfffff 00000000 00000001
		 00000000 0a6bdbf3 00000000 0000240d
		 00000000 0cd02878 00000000 000fd788
		 00000000 0ef84b1a 00000000 0000b4e6
		 00000000 0f090000 00000000 0f9c0000
#address-cells   00000001
#size-cells      00000000
reg              00000000 00000000 00000000 20000000
ibm,phandle      fffffffa (-6)
linux,phandle    00cae9d0 (13298128)
name             "memory"

/proc/device-tree/event-sources:
interrupt-ranges 00090000 00000008
#interrupt-cells 00000002
linux,phandle    00e026e8 (14690024)
name             "event-sources"
ibm,fw-lpevent-xirr
		 00090000 (589824)
interrupt-controller
	=09

/proc/device-tree/event-sources/epow-events:
interrupts       00090001 00000000
linux,phandle    00e048a0 (14698656)
name             "epow-events"

/proc/device-tree/ibm,dynamic-reconfiguration-memory:
ibm,lmb-size     00000000 10000000
ibm,memory-flags-mask
		 000000ff (255)
ibm,dynamic-memory
		 0000059e 00000000 20000000 80000002
		 00000000 00000001 00000008 00000000
		 30000000 80000003 00000000 00000001
		 00000008 00000000 40000000 80000004
		 00000000 00000001 00000008 00000000
		 50000000 80000005 00000000 00000001
		 00000008 00000000 60000000 80000006
		 00000000 00000001 00000008 00000000
		 [34516 bytes total]
ibm,phandle      fffffff9 (-7)
linux,phandle    00ce70c0 (13529280)
ibm,associativity-lookup-arrays
		 00000002 00000004 00000000 00000000 00000000
		 00000000 00000000 00000001 00000002 00000002
ibm,memory-preservation-time
		 00000000
name             "ibm,dynamic-reconfiguration-memory"

/proc/device-tree/options:
oem-banner?      "false"
screen-#columns  "80"
ibm,shadow-boot-device
		 ",AIX-VDASD-IBM     IPR-0   58C1F90000000220"
ibm,fw-default-mac-address?
		 "false"
ibm,fw-force-ior "false"
real-base        "12582912"
ibm,fw-dc-select "100"
use-nvramrc?     "false"
ibm,fw-n-dbfp    "00000000"
ibm,fw-find-tape-alias
		 "false"
ibm,fw-n-ru      "Y"
ibm,fw-tty-language
		 "1"
boot-command     "boot"
ibm,fw-find-cdrom-alias
		 "false"
menu?            "false"
reboot-command   ""
ibm,last-booted  "AIX-VDASD-IBM     IPR-0   58C1F90000000220"
ibm,fw-nbr-reboots
		 "0"
ibm,fw-src-os-vec5
		 19 00 f3 00 c0 c0 05 00 00 00 00 01 00 00 00 00................
		 00 e0 00 00 00 01 00 00 00 00 00               ...........
input-device     "/vdevice/vty"
real-size        "134217728"
ibm,fw-override-cas
		 "false"
ibm,fw-usedrcinfo?
		 "false"
ibm,fw-new-mem-def
		 "true"
ibm,fw-n-dafp    "00000000"
oem-logo?        "false"
real-mode?       "true"
boot-file        ""
diag-switch?     "false"
nvramrc          ""
boot-device      2f766465 76696365 2f6c2d6c 616e4033
		 30303030 3030323a 73706565 643d6175
		 746f2c64 75706c65 783d6175 746f2c39
		 2e34302e 3139322e 38322c62 6f6f746c
		 6f616465 722d3031 2d62612d 36382d39
		 382d3261 2d31622d 30322c39 2e34302e
		 3139352e 3230332c 392e3430 2e313935
		 2e312c35 2c352c32 35352e32 35352e32
		 [184 bytes total]
ibm,fw-forced-boot
		 ""
virt-base        "4294967295"
output-device    "/vdevice/vty"
oem-banner       ""
ibm,fw-show-true-pcie?
		 "true"
little-endian?   "false"
ibm,fw-oflite-dbg
		 "false"
ibm,fw-n-rc      "A"
ibm,fw-n-bc      "255.255.255.255"
ibm,associativity-form
		 "1"
diag-device      2f766465 76696365 2f6c2d6c 616e4033
		 30303030 3030323a 73706565 643d6175
		 746f2c64 75706c65 783d6175 746f2c39
		 2e34302e 3139322e 38322c2c 392e3430
		 2e313935 2e323033 2c392e34 302e3139
		 352e312c 352c352c 3235352e 3235352e
		 3235352e 302c3531 32202f76 64657669
		 63652f76 2d736373 69403330 30303030
		 [153 bytes total]
fcode-debug?     "true"
ibm,fw-prev-boot-vpd
	=09
oem-logo       =20
ibm,fw-prev-neg-vec5
		 14 00 f3 00 00 c0 00 00 00 00 00 01 00 00 00 00................
		 00 e0 00 00 00 00                              ......
ibm,fw-menu-ba68982a1b02
		 "auto,auto,9.40.195.203,9.40.192.82,9.40.195.1,255.255.255.0,Standard,=
Yes,,5,512,5"
ibm,fw-usedynmemv2?
		 "false"
auto-boot?       "true"
ibm,fw-vlan-menu-ba68982a1b02
		 "0,0"
ibm,phandle      fffffffb (-5)
selftest-#megs   "0"
ibm,dasd-spin-interval
		 "5"
boot-last-label  73657470 6172616d 73202752 65642048
		 61742045 6e746572 70726973 65204c69
		 6e757820 53657276 65722028 342e3132
		 2e302d72 63332e77 69393132 37355f30
		 3534615f 30353031 30312e70 70633634
		 6c652b29 20372e33 20284d61 69706f29
		 270a0a09 6c6f6164 5f766964 656f0a09
		 696e736d 6f642067 7a696f0a 09696e73
		 [832 bytes total]
load-base        "16384"
ibm,fw-src-os-vec4
		 01 00 01                                       ...
ibm,fw-keyboard  "1"
linux,phandle    00c9e0c0 (13230272)
virt-size        "4294967295"
diag-file        "diag"
name             "options"
ibm,os-restart-policy
		 "1"
screen-#rows     "24"

/proc/device-tree/rtas:
power-domains-names
		 "root power domain"
get-sensor-state 0000000c (12)
linux,rtas-entry 1ea51548 (514135368)
ibm,configure-kernel-dump-version
		 00010001 (65537)
rtas-sensors     00000001 00000000 00000005 00000000
		 00000009 00000000 0000232d 00000000
system-reboot    00000014 (20)
stop-self        00000018 (24)
ibm,hypertas-functions
		 6863616c 6c2d7066 74006863 616c6c2d
		 74636500 6863616c 6c2d7370 72673000
		 6863616c 6c2d636f 70790068 63616c6c
		 2d646562 75670068 63616c6c 2d746572
		 6d006863 616c6c2d 696e7465 72727570
		 74006863 616c6c2d 6d696772 61746500
		 6863616c 6c2d7065 72666d6f 6e006863
		 616c6c2d 73706c70 61720053 4c422d62
		 [434 bytes total]
ibm,lpar-perftools
		 00000045 (69)
ibm,create-pe-dma-window
		 00000054 (84)
ibm,nmi-register-2
		 00000030 (48)
ibm,nmi-register 00000030 (48)
ibm,configure-pe 00000052 (82)
ibm,display-line-length
		 00000010 (16)
ibm,lrdr-capacity
		 0000005a 00000000 00000000 10000000 00000020
ibm,dma-delay-time
		 0003e800 (256000)
ibm,nmi-interlock
		 00000031 (49)
ibm,indicator-0002
		 ""
ibm,get-indicator-indices-types
		 0000232e 0000232f
ibm,read-slot-reset-state2
		 00000048 (72)
ibm,slot-error-detail
		 00000036 (54)
ibm,update-nodes 0000004f (79)
platform-power-sources
		 00035b60 00004a38 000038a4 00000032
ibm,errinjct     00000027 (39)
ibm,set-dynamic-indicator
		 00000046 (70)
ibm,update-properties
		 00000050 (80)
ibm,sensor-0009  ""
ibm,request-partition-shutdown
		 00000000
ibm,power-off-ups
		 0000004a (74)
ibm,flash-block-version
		 00000001
ibm,recoverable-epow3
	=09
ibm,integrated-stop-self
	=09
set-indicator    0000000b (11)
nvram-fetch      00000001
ibm,change-msi   0000004b (75)
ibm,manage-flash-image
		 0000003c (60)
ibm,configure-connector
		 0000002a (42)
rtas-error-log-max
		 00000800 (2048)
power-domains-tree
		 00000000 00000002 00000000 00000001
		 00000000 000000fa 00000064 00000001
		 00000000 000000fa 00000000
ibm,sensor-9005  ""
ibm,change-msix-capable
	=09
ibm,get-vpd      00000042 (66)
ibm,configure-kernel-dump-sizes
		 00000001 00000000 00200020 00000002 00000000 00001000
ibm,set-eeh-option
		 0000002b (43)
ibm,form-feed    0000000c (12)
ibm,get-sensor-indices-types
		 0000232e 0000232f
ibm,remove-pe-dma-window
		 00000055 (85)
ibm,sensor-0005  ""
ibm,query-interrupt-source-number
		 0000004c (76)
rtas-display-device
		 00e3e738 (14935864)
ibm,indicator-9005
		 ""
ibm,write-pci-config
		 0000002f (47)
ibm,int-on       00000024 (36)
ibm,reset-pe-dma-window
		 00000056 (86)
ibm,max-associativity-domains
		 00000005 00000001 00000008 00000020 00000020 00000100
ibm,set-system-parameter
		 00000034 (52)
ibm,set-slot-reset
		 0000002c (44)
ibm,rks-hcalls   e0000000
start-cpu        00000019 (25)
ibm,get-config-addr-info
		 0000004d (77)
ibm,reset-capabilities
		 00000001
ibm,set-xive     00000023 (35)
get-power-level  0000000e (14)
ibm,display-truncation-length
		 00000010 00000050
ibm,activate-firmware
		 00000043 (67)
ibm,suspend-me   0000004e (78)
ibm,extended-os-term
	=09
event-scan       00000006
set-power-level  0000000d (13)
ibm,configure-bridge
		 00000038 (56)
ibm,validate-flash-image
		 0000003d (61)
ibm,configure-kernel-dump
		 00000051 (81)
ibm,get-dynamic-sensor-state
		 00000047 (71)
ibm,sensor-0001  ""
ibm,open-errinjct
		 00000026 (38)
rtas-indicators  00000001 00000000 00000002 00000000 0000232d 00000000
ibm,associativity-reference-points
		 00000004 00000002
ibm,close-errinjct
		 00000028 (40)
ibm,get-config-addr-info2
		 0000004d (77)
ibm,os-term      0000001a (26)
display-character
		 0000000a (10)
rtas-size        015b0000 (22740992)
get-time-of-day  00000003
ibm,update-flash-64-and-reboot
		 00000021 (33)
check-exception  00000007
nvram-store      00000002
ibm,indicator-0001
		 ""
ibm,vpd-size     0004b000 (307200)
ibm,phandle      fffffffd (-3)
power-sources-names
		 "power supply"
set-time-of-day  00000004
power-off        00000011 (17)
set-time-for-power-on
		 00000005
rtas-event-scan-rate
		 00000004
linux,rtas-base  1ea50000 (514129920)
ibm,read-pci-config
		 0000002e (46)
ibm,get-indices  00000037 (55)
linux,phandle    00e068a0 (14706848)
ibm,read-slot-reset-state-functions
		 00000003
power-domains-controllers
		 00e3e738 (14935864)
ibm,int-off      00000025 (37)
ibm,get-system-parameter
		 00000032 (50)
query-cpu-stopped-state
		 0000001e (30)
rtas-version     00000001
ibm,display-number-of-lines
		 00000002
ibm,errinjct-tokens
		 7265636f 76657265 642d7370 65636961
		 6c2d6576 656e7400 00000003 636f7272
		 75707465 642d7061 67650000 00000469
		 6f612d62 75732d65 72726f72 00000000
		 07636f72 72757074 65642d64 63616368
		 652d7374 61727400 00000009 636f7272
		 75707465 642d6463 61636865 2d656e64
		 00000000 0a636f72 72757074 65642d69
		 [236 bytes total]
ibm,get-xive     00000022 (34)
ibm,query-pe-dma-window
		 00000053 (83)
name             "rtas"
rtas-last-error  0000001f (31)
ibm,platform-dump
		 0000003b (59)
power-on-max-latency
		 ffffffff (-1)

/proc/device-tree/interrupt-controller@0:
compatible       "IBM,ppc-xicp"
device_type      "PowerPC-External-Interrupt-Presentation"
model            "IBM, Logical PowerPC-PIC, 00"
ibm,interrupt-buid-size
		 00000014 (20)
built-in       =20
reg              00000000 00000000 00000000 00000000
ibm,interrupt-server-ranges
		 00000000 00000080
linux,phandle    00e04a10 (14699024)
name             "interrupt-controller"
interrupt-controller
	=09

/proc/device-tree/aliases:
nvram            "/vdevice/nvram@4002"
net              "/vdevice/l-lan@30000002"
scsi             "/vdevice/v-scsi@30000078"
ibm,sp           "/vdevice/IBM,sp@4000"
network          "/vdevice/l-lan@30000002"
linux,phandle    00cefa00 (13564416)
name             "aliases"
rtc              "/vdevice/rtc@4001"

/proc/device-tree/chosen:
linux,stdout-package
		 00e1b528 (14791976)
ibm,architecture-vec-5
		 14 00 f3 00 00 c0 00 00 00 00 00 01 00 00 00 00................
		 00 e0 00 00 00 00                              ......
nvram            08b05100 (145772800)
bootargs         424f4f54 5f494d41 47453d2f 766d6c69
		 6e757a2d 342e3132 2e302d72 63332e77
		 69393132 37355f30 3534615f 30353031
		 30312e70 70633634 6c652b20 726f6f74
		 3d2f6465 762f6d61 70706572 2f726865
		 6c5f6c74 63616c70 696e6532 2d2d6c70
		 32302d72 6f6f7420 726f2063 72617368
		 6b65726e 656c3d61 75746f20 72642e6c
		 [196 bytes total]
linux,initrd-start
		 00000000 0ce00000
cpu              08bc0480 (146539648)
linux,kernel-end 00000000 02550000
ibm,client-architecture-support-reboot
		 00000001
linux,initrd-end 00000000 0ef84b1a
stdout           08b04f80 (145772416)
memory           08bc0700 (146540288)
ibm,phandle      fffffff7 (-9)
stdin            08b05800 (145774592)
linux,stdout-path
		 "/vdevice/vty@30000000"
linux,phandle    00c9dd50 (13229392)
bootpath         "/vdevice/v-scsi@30000078/disk@8100000000000000"
name             "chosen"
mmu              08bc0480 (146539648)
linux,memory-limit
		 00000000 00000000

/proc/device-tree/ibm,platform-facilities:
interrupt-ranges 00090400 00000400
ibm,interrupt-pool
		 00000000
device_type      "ibm,platform-facilities"
#address-cells   00000001
#size-cells      00000000
ibm,phandle      fffffff6 (-10)
linux,phandle    00d26c88 (13790344)
name             "ibm,platform-facilities"
ibm,max-async-ops-per-processor
		 00000004

/proc/device-tree/ibm,platform-facilities/ibm,compression-v1:
compatible       "ibm,compression"
ibm,max-sg-len   00000ff0 (4080)
ibm,resource-id  00000000
ibm,max-sync-cop 00000001 00010000 000001fe 00000001 00010000 000001fe
status           "okay"
ibm,phandle      fffffff4 (-12)
linux,phandle    00d28550 (13796688)
name             "ibm,compression-v1"
ibm,shared-interrupt-pool
		 00d26c88 (13790344)

/proc/device-tree/ibm,platform-facilities/ibm,random-v1:
compatible       "ibm,random"
ibm,max-sync-cop 00000000
status           "okay"
ibm,phandle      fffffff5 (-11)
linux,phandle    00d28368 (13796200)
name             "ibm,random-v1"
ibm,shared-interrupt-pool
		 00d26c88 (13790344)

/proc/device-tree/ibm,platform-facilities/ibm,sym-encryption-v1:
compatible       "ibm,sym-encryption"
ibm,max-sg-len   00000ff0 (4080)
ibm,resource-id  00000001
ibm,max-sync-cop 00000000 00000000 00000003 00000080
		 00062000 000000c4 000000c0 00062000
		 000000c4 00000100 00062000 000000c4
		 00000000 00000001 00000003 00000080
		 00062000 000000c4 000000c0 00062000
		 000000c4 00000100 00062000 000000c4
		 00000000 00000002 00000003 00000080
		 00062000 000000c4 000000c0 00062000
		 [768 bytes total]
status           "okay"
ibm,phandle      fffffff3 (-13)
linux,phandle    00d287c0 (13797312)
name             "ibm,sym-encryption-v1"
ibm,shared-interrupt-pool
		 00d26c88 (13790344)

/proc/device-tree/openprom:
relative-addressing
	=09
ibm,fw-vernum_encoded
		 "FW860.00 (TV860_016)"
model            "IBM,FW860.00 (TV860_016)"
ibm,phandle      fffffffe (-2)
linux,phandle    00d25650 (13784656)
ibm,fw-next-bank "T"
name             "openprom"

/proc/device-tree/packages:
linux,phandle    00c9dfc8 (13230024)
name             "packages"

/proc/device-tree/packages/obp-tftp:
network          "bootp"
		 "iscsi"
		 "ipv6"
		 "dhcp"
		 "vtag"
		 "csarch"
iscsi            "iscsi"
		 "ipv6"
		 "dhcp"
linux,phandle    00d5d120 (14012704)
name             "obp-tftp"

/proc/device-tree/packages/lpevents:
linux,phandle    00cf4390 (13583248)
name             "lpevents"

/proc/device-tree/packages/fat-files:
linux,phandle    00dcce70 (14470768)
name             "fat-files"

/proc/device-tree/packages/deblocker:
linux,phandle    00d56a98 (13986456)
name             "deblocker"

/proc/device-tree/packages/gui:
linux,phandle    00e47f28 (14974760)
name             "gui"

/proc/device-tree/packages/gui/iscsi:
linux,phandle    00e668b0 (15100080)
name             "iscsi"

/proc/device-tree/packages/post:
linux,phandle    00e79878 (15177848)
name             "post"

/proc/device-tree/packages/gscsi:
#address-cells   00000001
linux,phandle    00dbd100 (14405888)
name             "gscsi"

/proc/device-tree/packages/gscsi/disk:
device_type      "block"
linux,phandle    00dc2d98 (14429592)
name             "disk"

/proc/device-tree/packages/gscsi/tape:
device_type      "byte"
linux,phandle    00dc4be8 (14437352)
name             "tape"

/proc/device-tree/packages/boot-mgr:
linux,phandle    00dee418 (14607384)
name             "boot-mgr"

/proc/device-tree/packages/elf-loader:
linux,phandle    00de2ee0 (14560992)
name             "elf-loader"

/proc/device-tree/packages/iso-9660-files:
linux,phandle    00de1910 (14555408)
name             "iso-9660-files"

/proc/device-tree/packages/iptest:
linux,phandle    00dc68e0 (14444768)
name             "iptest"

/proc/device-tree/packages/udp:
linux,phandle    00d7f010 (14151696)
name             "udp"

/proc/device-tree/packages/tape-label:
linux,phandle    00d5c3b8 (14009272)
name             "tape-label"

/proc/device-tree/packages/cas:
linux,phandle    00dff6e8 (14677736)
name             "cas"

/proc/device-tree/packages/net:
linux,phandle    00de71a8 (14578088)
name             "net"

/proc/device-tree/packages/ping:
linux,phandle    00d8d678 (14210680)
name             "ping"

/proc/device-tree/packages/bootp:
linux,phandle    00d95620 (14243360)
name             "bootp"

/proc/device-tree/packages/utilities:
linux,phandle    00d28e00 (13798912)
name             "utilities"

/proc/device-tree/packages/utilities/trace:
linux,phandle    00d40900 (13895936)
name             "trace"

/proc/device-tree/packages/disk-label:
linux,phandle    00d57fd8 (13991896)
name             "disk-label"

/proc/device-tree/packages/prep-boot:
linux,phandle    00dcc5e0 (14468576)
name             "prep-boot"

/proc/device-tree/packages/ipv6:
linux,phandle    00d77550 (14120272)
name             "ipv6"

/proc/device-tree/packages/terminal-emulator:
iso6429-1983-colors
	=09
linux,phandle    00e02070 (14688368)
name             "terminal-emulator"

/proc/device-tree/packages/gen-iso-13346-files:
linux,phandle    00dd8a40 (14518848)
name             "gen-iso-13346-files"

/proc/device-tree/packages/dev-tree:
linux,phandle    00cf2928 (13576488)
name             "dev-tree"

/proc/device-tree/packages/tcp:
linux,phandle    00d86048 (14180424)
name             "tcp"

/proc/device-tree/packages/iso-13346-files:
linux,phandle    00dcf198 (14479768)
name             "iso-13346-files"

/proc/device-tree/packages/ipv4:
linux,phandle    00d70270 (14090864)
name             "ipv4"

/proc/device-tree/packages/tftp:
linux,phandle    00dab1e8 (14332392)
name             "tftp"

/proc/device-tree/packages/iscsi:
linux,phandle    00db5760 (14374752)
name             "iscsi"

/proc/device-tree/packages/nls-support:
linux,phandle    00dfe8f0 (14674160)
name             "nls-support"

/proc/device-tree/packages/dhcp:
linux,phandle    00d9ef28 (14282536)
name             "dhcp"

/proc/device-tree/packages/chrp-loader:
linux,phandle    00de2d38 (14560568)
name             "chrp-loader"

/proc/device-tree/packages/dynamic-reconfig:
linux,phandle    00e02168 (14688616)
name             "dynamic-reconfig"

/proc/device-tree/cpus:
ibm,drc-names    00000020 43505520 31004350 55203900
		 43505520 31370043 50552032 35004350
		 55203333 00435055 20343100 43505520
		 34390043 50552035 37004350 55203635
		 00435055 20373300 43505520 38310043
		 50552038 39004350 55203937 00435055
		 20313035 00435055 20313133 00435055
		 20313231 00435055 20313239 00435055
		 [245 bytes total]
ibm,drc-types    00000020 43505500 43505500 43505500
		 43505500 43505500 43505500 43505500
		 43505500 43505500 43505500 43505500
		 43505500 43505500 43505500 43505500
		 43505500 43505500 43505500 43505500
		 43505500 43505500 43505500 43505500
		 43505500 43505500 43505500 43505500
		 43505500 43505500 43505500 43505500
		 [132 bytes total]
ibm,drc-indexes  00000020 10000000 10000008 10000010
		 10000018 10000020 10000028 10000030
		 10000038 10000040 10000048 10000050
		 10000058 10000060 10000068 10000070
		 10000078 10000080 10000088 10000090
		 10000098 100000a0 100000a8 100000b0
		 100000b8 100000c0 100000c8 100000d0
		 100000d8 100000e0 100000e8 100000f0
		 [132 bytes total]
smp-enabled    =20
#address-cells   00000001
#size-cells      00000000
ibm,drc-power-domains
		 00000020 ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffffffff
		 [132 bytes total]
ibm,phandle      fffffff8 (-8)
linux,phandle    00ca0558 (13239640)
name             "cpus"

/proc/device-tree/cpus/PowerPC,POWER8@8:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000008 (268435464)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000008 00000009 0000000a 0000000b
		 0000000c 0000000d 0000000e 0000000f
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000008 0000ffff 00000009 0000ffff
		 0000000a 0000ffff 0000000b 0000ffff
		 0000000c 0000ffff 0000000d 0000ffff
		 0000000e 0000ffff 0000000f 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000008
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000008 (268435464)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00ca7a50 (13269584)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

/proc/device-tree/cpus/PowerPC,POWER8@30:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000030 (268435504)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000030 00000031 00000032 00000033
		 00000034 00000035 00000036 00000037
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000030 0000ffff 00000031 0000ffff
		 00000032 0000ffff 00000033 0000ffff
		 00000034 0000ffff 00000035 0000ffff
		 00000036 0000ffff 00000037 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000030 (48)
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000030 (268435504)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00cac9b0 (13289904)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

/proc/device-tree/cpus/PowerPC,POWER8@20:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000020 (268435488)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000020 00000021 00000022 00000023
		 00000024 00000025 00000026 00000027
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000020 0000ffff 00000021 0000ffff
		 00000022 0000ffff 00000023 0000ffff
		 00000024 0000ffff 00000025 0000ffff
		 00000026 0000ffff 00000027 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000020 (32)
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000020 (268435488)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00caa9f0 (13281776)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

/proc/device-tree/cpus/PowerPC,POWER8@10:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000010 (268435472)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000010 00000011 00000012 00000013
		 00000014 00000015 00000016 00000017
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000010 0000ffff 00000011 0000ffff
		 00000012 0000ffff 00000013 0000ffff
		 00000014 0000ffff 00000015 0000ffff
		 00000016 0000ffff 00000017 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000010 (16)
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000010 (268435472)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00ca8a30 (13273648)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

/proc/device-tree/cpus/PowerPC,POWER8@0:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000000 (268435456)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000000 00000001 00000002 00000003
		 00000004 00000005 00000006 00000007
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000000 0000ffff 00000001 0000ffff
		 00000002 0000ffff 00000003 0000ffff
		 00000004 0000ffff 00000005 0000ffff
		 00000006 0000ffff 00000007 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000000
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000000 (268435456)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00ca67d0 (13264848)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

/proc/device-tree/cpus/PowerPC,POWER8@38:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000038 (268435512)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000038 00000039 0000003a 0000003b
		 0000003c 0000003d 0000003e 0000003f
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000038 0000ffff 00000039 0000ffff
		 0000003a 0000ffff 0000003b 0000ffff
		 0000003c 0000ffff 0000003d 0000ffff
		 0000003e 0000ffff 0000003f 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000038 (56)
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000038 (268435512)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00cad990 (13293968)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

/proc/device-tree/cpus/PowerPC,POWER8@28:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000028 (268435496)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000028 00000029 0000002a 0000002b
		 0000002c 0000002d 0000002e 0000002f
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000028 0000ffff 00000029 0000ffff
		 0000002a 0000ffff 0000002b 0000ffff
		 0000002c 0000ffff 0000002d 0000ffff
		 0000002e 0000ffff 0000002f 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000028 (40)
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000028 (268435496)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00cab9d0 (13285840)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

/proc/device-tree/cpus/PowerPC,POWER8@18:
bus-frequency    00000000
performance-monitor
		 00000000 00000001
ibm,pft-size     00000000 00000020
ibm,vmx          00000003
ibm,spurr        00000001
d-tlb-sets       00000004
ibm,nominal-tbf  1e848000 (512000000)
64-bit         =20
timebase-frequency
		 1e848000 (512000000)
ibm,extended-clock-frequency
		 00000000 b45d1880
ibm,estimate-precision
		 66 72 65 00 00 00 00 0e 66 72 65 73 00 00 00 00fre.....fres....
		 0e 66 72 73 71 72 74 65 00 00 00 00 0e 66 72 73.frsqrte.....frs
		 71 72 74 65 73 00 00 00 00 0e                  qrtes.....
tlb-size         00000800 (2048)
ibm,pa-features  18 00 f6 3f c7 c0 80 f0 80 00 00 00 00 00 00 00...?.....=
=2E......
		 00 00 80 00 80 00 80 00 80 00                  ..........
graphics       =20
ibm,slb-size     00000020 (32)
device_type      "cpu"
tlb-sets         00000004
ibm,my-drc-index 10000018 (268435480)
reservation-granule-size
		 00000080 (128)
ibm,processor-storage-keys
		 0000001f 00000000
ibm,processor-vadd-size
		 00000044 (68)
slb-size         00000020 (32)
ibm,dfp          00000002
ibm,ppc-interrupt-server#s
		 00000018 00000019 0000001a 0000001b
		 0000001c 0000001d 0000001e 0000001f
ibm,vrma-page-sizes
		 00000018 00000010 0000000c 00000000
		 00000010 00000011 00000022 00000013
ibm,segment-page-sizes
		 0000000c 00000000 00000003 0000000c
		 00000000 00000010 00000007 00000018
		 00000038 00000010 00000110 00000002
		 00000010 00000001 00000018 00000008
		 00000018 00000100 00000001 00000018
		 00000000 00000022 00000120 00000001
		 00000022 00000003
i-cache-line-size
		 00000080 (128)
i-tlb-size       00000000
ibm,pa-optimizations
		 02001004 (33558532)
status           "okay"
cpu-version      0f000004 (251658244)
ibm,purr         00000001
ibm,ppc-interrupt-gserver#s
		 00000018 0000ffff 00000019 0000ffff
		 0000001a 0000ffff 0000001b 0000ffff
		 0000001c 0000ffff 0000001d 0000ffff
		 0000001e 0000ffff 0000001f 0000ffff
i-tlb-sets       00000000
ibm,tbu40-offset ffffb452 a7000000
ibm,pi-features  01 00 a0                                       ...
ibm,negotiated-pa-features
		 01 00 00                                       ...
i-cache-block-size
		 00000080 (128)
32-64-bridge   =20
ibm,extended-bus-frequency
		 00000000 00000000
reg              00000018 (24)
d-cache-block-size
		 00000080 (128)
clock-frequency  b45d1880
ibm,phandle      10000018 (268435480)
ibm,processor-segment-sizes
		 0000001c 00000028 ffffffff ffffffff
linux,phandle    00ca9a10 (13277712)
d-cache-size     00010000 (65536)
i-cache-size     00008000 (32768)
general-purpose=20
ibm,raw-pi-features
		 01 00 00                                       ...
d-tlb-size       00000800 (2048)
name             "PowerPC,POWER8"
ibm,processor-page-sizes
		 0000000c 00000010 00000018 00000022
d-cache-sets     00000008
i-cache-sets     00000004
d-cache-line-size
		 00000080 (128)

--------------6B63FE12B3F1A5388F30DE40--

Return-Path: <srs0=sjbb=3u=gmail.com=ianjiang.cn@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2y7l5CJKzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:41:23 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w2y7l4Yd9z8tQr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:41:23 +1000 (AEST)
Received: from mbob.nabble.com (mbob.nabble.com [162.253.133.15])
 by ozlabs.org (Postfix) with ESMTP id 3w2y7l1DMHz9s7q
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 18:41:23 +1000 (AEST)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mbob.nabble.com (Postfix) with ESMTP id 6347940FD99A
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 01:40:39 -0700 (PDT)
Date: Wed, 12 Apr 2017 01:42:18 -0700 (MST)
From: IanJiang <ianjiang.cn@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <CAFE2VE+pm=bBVBx3Ws08kcKGhZO+BaxJcmskjg4DFjNKHQj-9w@mail.gmail.com>
In-Reply-To: <1491903331.4166.240.camel@kernel.crashing.org>
References: <1491826953201-121121.post@n7.nabble.com>
 <20170410222442.GA11610@gwshan> <1491876268752-121154.post@n7.nabble.com>
 <1491876910.4166.219.camel@au1.ibm.com> <20170411044238.GA8157@gwshan>
 <1491902810921-121181.post@n7.nabble.com>
 <1491903331.4166.240.camel@kernel.crashing.org>
Subject: Re: EEH error in doing DMA with PEX 8619
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_Part_153721_188854092.1491986538427"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_153721_188854092.1491986538427
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, Apr 11, 2017 at 5:37 PM, Benjamin Herrenschmidt [via linuxppc]
<ml-node+s10917n121182h95@n7.nabble.com> wrote:
>
> Another possibility would be if the requests from the PLX have a
> different initiator ID on the bus than the device you are setting up
> the DMA for.
>

Here is the problem, I think.
There are three PEX 8619 devices given in lspci, and there are
supported by two different modules:

[root@localhost PlxSdk]# lspci -nnn | grep 8619
0001:01:00.0 PCI bridge [0604]: PLX Technology, Inc. PEX 8619 16-lane,
16-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA [10b5:8619] (rev
ba)
0001:01:00.1 System peripheral [0880]: PLX Technology, Inc. PEX 8619
16-lane, 16-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA
[10b5:8619] (rev ba)
0001:02:01.0 Bridge [0680]: PLX Technology, Inc. PEX 8619 16-lane,
16-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA [10b5:8619] (rev
ba)

[root@localhost PlxSdk]# lsmod | grep 8000
Plx8000_DMA            69021  0
Plx8000_NT             73848  0


[root@localhost ~]# dmesg | grep Probe
[ 1875.493576] Plx8000_NT: Probe: 8619 10B5 [D1 01:00.1]
[ 1875.493584] Plx8000_NT: Probe: -- Unsupported Device --
...
[ 1875.493867] Plx8000_NT: Probe: 8619 10B5 [D1 02:01.0]
[ 1876.973489] Plx8000_DMA: Probe: 8619 10B5 [D1 01:00.1]

In my test, DMA buffers are allocated with  (bus 2, device 1, function
0) in module Plx8000_NT, but DMA is issued by (bus 1 device 0 function
1) in module Plx8000_DMA. And error of (bus 1 device 0 function 1) is
reported by EEH.


[ 1908.426579] Plx8000_DMA: Ch 0 - DMA 00000000_60600000 -->
00000000_60800000 (65536 bytes)

[root@localhost ~]# dmesg | grep Bus\ Phy
[ 1875.495524] Plx8000_NT:     Bus Phys Addr: 605f0000
[ 1878.096744] Plx8000_DMA:     Bus Phys Addr: 60010000
[ 1892.745698] Plx8000_NT:     Bus Phys Addr: 60600000
[ 1892.746348] Plx8000_NT:     Bus Phys Addr: 60800000


[root@localhost ~]# dmesg | grep bus
[ 1875.495463] Debug Plx_dma_buffer_alloc: bus 2, device 1, function 0
[ 1876.973699] Debug AddDevice: Device bus 1 device 0 function 1
[ 1876.975155] Debug AddDevice: Device bus 1 device 0 function 1
[ 1876.976641] Debug AddDevice: Device bus 1 device 0 function 2
[ 1877.360606] Debug AddDevice: Device bus 1 device 0 function 3
[ 1877.763869] Debug AddDevice: Device bus 1 device 0 function 4
[ 1878.069865] Debug Plx_dma_buffer_alloc: bus 1, device 0, function 1
[ 1892.745446] Debug Plx_dma_buffer_alloc: bus 2, device 1, function 0
[ 1892.746109] Debug Plx_dma_buffer_alloc: bus 2, device 1, function 0
[ 1908.426649] Debug PlxDmaTransferBlock: DMA device bus 1 device 0 function 1
[ 1908.428483] Debug plx_err_detected: Device bus 1 device 0 function 1
[ 1917.490481] Debug plx_slot_reset: Device bus 1 device 0 function 1
[ 1917.490625] Debug plx_resume: Device bus 1 device 0 function 1




--
View this message in context: http://linuxppc.10917.n7.nabble.com/EEH-error-in-doing-DMA-with-PEX-8619-tp121121p121259.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
------=_Part_153721_188854092.1491986538427
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, Apr 11, 2017 at 5:37 PM, Benjamin Herrenschmidt [via linuxppc]
<br/>&lt;<a href="/user/SendEmail.jtp?type=node&node=121259&i=0" target="_top" rel="nofollow" link="external">[hidden email]</a>&gt; wrote:
<br/>&gt;
<br/>&gt; Another possibility would be if the requests from the PLX have a
<br/>&gt; different initiator ID on the bus than the device you are setting up
<br/>&gt; the DMA for.
<br/>&gt;
<br/><br/>Here is the problem, I think.
<br/>There are three PEX 8619 devices given in lspci, and there are
<br/>supported by two different modules:
<br/><br/>[root@localhost PlxSdk]# lspci -nnn | grep 8619
<br/>0001:01:00.0 PCI bridge [0604]: PLX Technology, Inc. PEX 8619 16-lane,
<br/>16-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA [10b5:8619] (rev
<br/>ba)
<br/>0001:01:00.1 System peripheral [0880]: PLX Technology, Inc. PEX 8619
<br/>16-lane, 16-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA
<br/>[10b5:8619] (rev ba)
<br/>0001:02:01.0 Bridge [0680]: PLX Technology, Inc. PEX 8619 16-lane,
<br/>16-Port PCI Express Gen 2 (5.0 GT/s) Switch with DMA [10b5:8619] (rev
<br/>ba)
<br/><br/>[root@localhost PlxSdk]# lsmod | grep 8000
<br/>Plx8000_DMA &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;69021 &nbsp;0
<br/>Plx8000_NT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 73848 &nbsp;0
<br/><br/><br/>[root@localhost ~]# dmesg | grep Probe
<br/>[ 1875.493576] Plx8000_NT: Probe: 8619 10B5 [D1 01:00.1]
<br/>[ 1875.493584] Plx8000_NT: Probe: -- Unsupported Device --
<br/>...
<br/>[ 1875.493867] Plx8000_NT: Probe: 8619 10B5 [D1 02:01.0]
<br/>[ 1876.973489] Plx8000_DMA: Probe: 8619 10B5 [D1 01:00.1]
<br/><br/>In my test, DMA buffers are allocated with &nbsp;(bus 2, device 1, function
<br/>0) in module Plx8000_NT, but DMA is issued by (bus 1 device 0 function
<br/>1) in module Plx8000_DMA. And error of (bus 1 device 0 function 1) is
<br/>reported by EEH.
<br/><br/><br/>[ 1908.426579] Plx8000_DMA: Ch 0 - DMA 00000000_60600000 --&gt;
<br/>00000000_60800000 (65536 bytes)
<br/><br/>[root@localhost ~]# dmesg | grep Bus\ Phy
<br/>[ 1875.495524] Plx8000_NT: &nbsp; &nbsp; Bus Phys Addr: 605f0000
<br/>[ 1878.096744] Plx8000_DMA: &nbsp; &nbsp; Bus Phys Addr: 60010000
<br/>[ 1892.745698] Plx8000_NT: &nbsp; &nbsp; Bus Phys Addr: 60600000
<br/>[ 1892.746348] Plx8000_NT: &nbsp; &nbsp; Bus Phys Addr: 60800000
<br/><br/><br/>[root@localhost ~]# dmesg | grep bus
<br/>[ 1875.495463] Debug Plx_dma_buffer_alloc: bus 2, device 1, function 0
<br/>[ 1876.973699] Debug AddDevice: Device bus 1 device 0 function 1
<br/>[ 1876.975155] Debug AddDevice: Device bus 1 device 0 function 1
<br/>[ 1876.976641] Debug AddDevice: Device bus 1 device 0 function 2
<br/>[ 1877.360606] Debug AddDevice: Device bus 1 device 0 function 3
<br/>[ 1877.763869] Debug AddDevice: Device bus 1 device 0 function 4
<br/>[ 1878.069865] Debug Plx_dma_buffer_alloc: bus 1, device 0, function 1
<br/>[ 1892.745446] Debug Plx_dma_buffer_alloc: bus 2, device 1, function 0
<br/>[ 1892.746109] Debug Plx_dma_buffer_alloc: bus 2, device 1, function 0
<br/>[ 1908.426649] Debug PlxDmaTransferBlock: DMA device bus 1 device 0 function 1
<br/>[ 1908.428483] Debug plx_err_detected: Device bus 1 device 0 function 1
<br/>[ 1917.490481] Debug plx_slot_reset: Device bus 1 device 0 function 1
<br/>[ 1917.490625] Debug plx_resume: Device bus 1 device 0 function 1
<br/>

	
	
	
<br/><hr align="left" width="300" />
View this message in context: <a href="http://linuxppc.10917.n7.nabble.com/EEH-error-in-doing-DMA-with-PEX-8619-tp121121p121259.html">Re: EEH error in doing DMA with PEX 8619</a><br/>
Sent from the <a href="http://linuxppc.10917.n7.nabble.com/linuxppc-dev-f3.html">linuxppc-dev mailing list archive</a> at Nabble.com.<br/>
------=_Part_153721_188854092.1491986538427--

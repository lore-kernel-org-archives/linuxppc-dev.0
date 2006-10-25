Return-Path: <luong.ngo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id D34FF67B5B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 16:44:36 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id f25so49356pyf
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 23:44:02 -0700 (PDT)
Message-ID: <1b2aacd80610242246n20075a33pcc76ab5be71fb87e@mail.gmail.com>
Date: Tue, 24 Oct 2006 22:46:12 -0700
From: "Luong Ngo" <luong.ngo@gmail.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: MPC8343: PCI resource allocation questions
In-Reply-To: <E2847437-6C75-4963-B9DB-BAC050015C88@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_104533_6573733.1161755172001"
References: <1b2aacd80610242049j23917f61x1e277b4c6a581f9a@mail.gmail.com>
	<E2847437-6C75-4963-B9DB-BAC050015C88@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_104533_6573733.1161755172001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Kumar, thanks a lot for your prompt and clear answers. But I still have a
couple questions about the BARs.


> The PCI resources are used for any PCI devices that need memory
> mapped space allocated to them.  What devices are you connecting over
> PCI?


I am connecting Broadcom BCM56502 controllers over PCI.

The region was large since the reference board has general purpose
PCI slots for any number of various cards.  We provide a large space
to allow for those cards to be allocated into.  Depending on your
application you can adjust this as you need.

I'm a bit confused here. If the host bridge is ignored/excluded, then the
region size in BARs will not be allocated corresponding resource by the PCI
subsystem, then how would other PCI devices in the slots could be allocated
in the BAR's range? If I understand correctly, the PCI devices's resources
are allocated based on the bridge resource, which is assigned statically by
PCI subsystem using hose->mem_space and hose->io_space instead of reading it
from the BARs. Maybe you are saying in the case the CPU is in agent mode and
its PCI host bridge is functioning as a PCI-PCI bridge?

You are not leaving any memory space for any of the onchip devices,
the error messages are because the regions of memory that the devices
are expected to be at are already occupied by the PCI space.

Isn't it the PCI IO and PCI MEM space are separated from local memory space?
I believe I see the global io_resource and mem_resource have the range of
0x0 - 0xFFFFFFFF.

I appreciate your help,

Thanks,
Luong Ngo

------=_Part_104533_6573733.1161755172001
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Kumar, thanks a lot for your prompt and clear&nbsp;answers. But I still have a couple questions about the BARs.<br>&nbsp;</div>
<div><span class="gmail_quote"></span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">The PCI resources are used for any PCI devices that need memory<br>mapped space allocated to them.&nbsp;&nbsp;What devices are you connecting over
<br>PCI?</blockquote>
<div>&nbsp;</div>
<div><font color="#996633">I am connecting Broadcom BCM56502 controllers over PCI.</font></div><br>
<div>The region was large since the reference board has general purpose<br>PCI slots for any number of various cards.&nbsp;&nbsp;We provide a large space<br>to allow for those cards to be allocated into.&nbsp;&nbsp;Depending on your<br>application you can adjust this as you need.
</div>
<div>&nbsp;</div>
<div><font color="#996633">I'm a bit confused here. If the host bridge is ignored/excluded, then the region size in BARs will not be allocated&nbsp;corresponding resource by the PCI subsystem, then how would other PCI devices in the slots could be allocated in the BAR's range? If I understand correctly, the PCI devices's resources are allocated based on the bridge resource, which is assigned statically by PCI subsystem using hose-&gt;mem_space and hose-&gt;io_space instead of reading it from the BARs. Maybe you are saying in the case the CPU is in agent mode and its&nbsp;PCI host bridge is functioning as a PCI-PCI bridge?
</font><br>&nbsp;</div>
<div>You are not leaving any memory space for any of the onchip devices,<br>the error messages are because the regions of memory that the devices<br>are expected to be at are already occupied by the PCI space.<br>&nbsp;</div>

<div>Isn't it the PCI IO and PCI MEM space are separated from local memory space? I believe I see the global io_resource and mem_resource have the range of 0x0 - 0xFFFFFFFF. </div>
<div><br>I appreciate your help,</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Luong Ngo<br><br>&nbsp;</div></div><br>

------=_Part_104533_6573733.1161755172001--

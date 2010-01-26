Return-Path: <kaneshige.kenji@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 5B497B7C06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 15:37:12 +1100 (EST)
Received: from m1.gw.fujitsu.co.jp ([10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o0Q4bAfX028195 for <linuxppc-dev@lists.ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Tue, 26 Jan 2010 13:37:10 +0900
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 86A3045DE50
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:37:10 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5CAA645DE55
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:37:10 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3A9B11DB8045
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:37:10 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.249.87.107])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D8F8C1DB8040
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jan 2010 13:37:09 +0900 (JST)
Message-ID: <4B5E715C.3000006@jp.fujitsu.com>
Date: Tue, 26 Jan 2010 13:36:44 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>	<20100125123849.111fa2d1@jbarnes-piketon>
	<20100125175025.4c74f412@jbarnes-piketon>
In-Reply-To: <20100125175025.4c74f412@jbarnes-piketon>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>,
	Ron Mercer <ron.mercer@qlogic.com>, linuxppc-dev@lists.ozlabs.org,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jesse Barnes wrote:
> On Mon, 25 Jan 2010 12:38:49 -0800
> Jesse Barnes <jbarnes@virtuousgeek.org> wrote:
> 
>> On Mon, 25 Jan 2010 11:42:29 -0200
>> Breno Leitao <leitao@linux.vnet.ibm.com> wrote:
>>
>>> Hello, 
>>>
>>> I found that qlge is broken on PPC, and it got broken after commit 
>>> 06a1cbafb253c4c60d6a54a994887f5fbceabcc0. It happens because
>>> dev->pcie is not set on PPC, because the function
>>> set_pcie_port_type(), who sets dev->pcie, is not being called on PPC
>>> PCI code.
>> You mean dev->is_pcie?
>>
>> Why isn't pci_scan_device calling pci_setup_device for you?  That
>> should do the proper PCIe init depending on the device, along with
>> extracting other device info...
> 
> Cc'ing Ben for PPC.  Ben, should PPC use pci_scan_device when probing
> its root busses?  Sounds like it just uses pci_device_add for each one
> it finds instead?
> 
> If you don't actually need scanning (though what about hotplug?) we can
> move the call to device_add instead...
> 

As I mentioned in the other e-mail, I think the set_pcie_port_type() needs
to be called before pci_fixup_device() call in the pci_setup_device()
because some fixup handler might refer the dev->is_pcie, dev->pcie_cap,
or dev->pcie_type.

Thanks,
Kenji Kaneshige

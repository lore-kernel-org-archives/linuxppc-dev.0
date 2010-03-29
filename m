Return-Path: <kaneshige.kenji@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by ozlabs.org (Postfix) with ESMTP id 7CE8DB7C09
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 18:01:35 +1100 (EST)
Received: from m6.gw.fujitsu.co.jp ([10.0.50.76])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o2T71XTw029979 for <linuxppc-dev@ozlabs.org> (envelope-from
	kaneshige.kenji@jp.fujitsu.com); Mon, 29 Mar 2010 16:01:34 +0900
Received: from smail (m6 [127.0.0.1])
	by outgoing.m6.gw.fujitsu.co.jp (Postfix) with ESMTP id A886D45DE52
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 16:01:33 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (s6.gw.fujitsu.co.jp [10.0.50.96])
	by m6.gw.fujitsu.co.jp (Postfix) with ESMTP id 7BFCA45DD70
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 16:01:33 +0900 (JST)
Received: from s6.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 614161DB801C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 16:01:33 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s6.gw.fujitsu.co.jp (Postfix) with ESMTP id 0E4461DB8015
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 16:01:33 +0900 (JST)
Message-ID: <4BB0503D.5000700@jp.fujitsu.com>
Date: Mon, 29 Mar 2010 16:01:17 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>, Felix Radensky <felix@embedded-sol.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	
	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>	
	<4B9DCF01.4050709@embedded-sol.com>
	<4B9DF72F.3040105@jp.fujitsu.com>	
	<4B9E18A7.2080605@embedded-sol.com>
	<4B9F19E2.2090709@jp.fujitsu.com>	
	<4B9FFAD1.8030309@embedded-sol.com>
	<4BA02A49.9050101@jp.fujitsu.com>	
	<4BAF1DC2.2080600@embedded-sol.com>
	<86802c441003281705v7d911553q4ee6f385c856644d@mail.gmail.com>
In-Reply-To: <86802c441003281705v7d911553q4ee6f385c856644d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yinghai Lu wrote:
> On Sun, Mar 28, 2010 at 2:13 AM, Felix Radensky <felix@embedded-sol.com> wrote:
>> Hello, Kenji-san
>>
>> I've tried Jesse's tree with Yinghai's patches, but they don't seem to help.
>> Memory for bridge is not allocated after insertion of hotplug device and
>> bus rescan. Attached dmesg output in case of success and failure.
>>
> that patches only take care of pcie hotplug path...
> 
> and it calls
> pci_assign_unassigned_bridge_resources(bridge)
> instead of
> pci_bus_assign_resources(bus)
> 
> so it doesn't check pci_is_enabled()
> 
> maybe  We can update rescan path to check if it is safe to skip the
> pci_is_enabled() too.
>   - no driver for those devices under that bridge are loaded.

Yinghai, Felix,

Thank you very much for the explanation, Yinghai.
The pci_assign_unassigned_bridge_resources() is what I wanted to suggest
to Felix.

Felix, I think assigning hpXXsize at boot time is the simpler solution,
if it is acceptable workaround for you. And as Yinghai suggested in the
another email, removing slot's parent bridge first should be one of the
workaround. But the problem is whether it is acceptable for you, because
your hotplug problem seems a regression.

Thanks,
Kenji Kaneshige


> 
> YH
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

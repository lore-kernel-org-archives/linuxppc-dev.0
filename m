Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 297F7B7D7E
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 22:23:14 +1100 (EST)
Message-ID: <4B9E18A7.2080605@embedded-sol.com>
Date: Mon, 15 Mar 2010 13:23:19 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>
	<4B9DCF01.4050709@embedded-sol.com>
	<4B9DF72F.3040105@jp.fujitsu.com>
In-Reply-To: <4B9DF72F.3040105@jp.fujitsu.com>
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

Hello, Kenji-san
>
> I think the device is expected to be ready to work if pci_enable_device()
> returns without error. So I think pci_enable_device() should return an
> error if it fails to enable the device (device is not ready to work). In
> this case, detecting your bridge's failure seems PPC specific to me. So I
> thought pcibios_enable_device() was the right to return an error. If
> pcibios_enable_device() returned an error, pci_dev->enable_cnt would
> decremented by pci_enable_device() (like pci_disable_device() does) and
> this problem would not happen.
>   

As far as I can see on 460EX pcibios_enable_device() just calls 
pci_enable_resources()
which does not return any error for my bridge, although it doesn't find 
any memory or
I/O resource it can enable. Do you think it is correct behavior ?

Another question is whether by bridge behaves correctly when no device 
is connected
to it. As you can see in dmesg output I've sent earlier

pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff]
pci 0000:00:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]

and later PCI code disables these memory windows

pci 0000:00:02.0: disabling bridge window [mem 0xd00000000-0xd000fffff 
pref] to [bus 01-01] (unused)
pci 0000:00:02.0: disabling bridge window [mem 0xd00000000-0xd000fffff] 
to [bus 01-01] (unused)

BTW, there's no problem accessing PCI_COMMAND register, as bus mastering 
is enabled in the bridge.

>
> On the other hand, as Ben suggested, handling this by specific hot-plug
> driver would be one of the other candidate to fix the problem.
>
>

I'm not opposed to this idea, it's just that this bridge worked in an older
system based on linux-2.6.22 and patched fakephp driver was used for 
hotplug.
There's existing userspace software that I don't really want to modify 
heavily.
But I'll do that if generic PCI rescan cannot be fixed.

Thanks a lot for your help.

Felix.

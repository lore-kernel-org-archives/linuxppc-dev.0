Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtDjK0kKDzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 20:07:16 +1000 (AEST)
Message-ID: <1505383610.12628.193.camel@kernel.crashing.org>
Subject: Re: [PATCH kernel] powerpc/powernv: Update comment about shifting
 IOV BAR
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
Cc: Alistair Popple <alistair@popple.id.au>, Bjorn Helgaas
 <helgaas@kernel.org>, "shan.gavin@gmail.com" <shan.gavin@gmail.com>, Paul
 Mackerras <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 14 Sep 2017 20:06:50 +1000
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD0076B19@AcuExch.aculab.com>
References: <20170831033412.1971-1-aik@ozlabs.ru>
 <0d7068aa-7331-0ce0-145d-8afe1e83a8ec@ozlabs.ru>
 <1505358454.12628.185.camel@kernel.crashing.org>
 <18f3462e-09ee-ce02-f9c6-eafad68cb9c6@ozlabs.ru>
 <1505360385.12628.187.camel@kernel.crashing.org>
 <063D6719AE5E284EB5DD2968C1650D6DD0076B19@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-14 at 09:27 +0000, David Laight wrote:
> You can logically 'hotplug' PCI(e) on any system [1].
> 
> The 'problem' is that whatever enumerates the PCI(e) at system
> powerup doesn't normally assign extra resources to bridges to allow
> for devices that aren't present at boot time.
> So you can normally only replace cards with ones that use the same
> (or less) resources, or that are not behind any bridges.
> This is problematic if you have a docking station connected via
> a bridge.

There's also the problem of Max Payload Size. If you can hotplug behind
a bridge then the standard algorithm of finding the max of all devices
behind a host bridge doesn't work anymore and you have to clamp
everybody to 128 bytes.

> [1] Apart from some annoying x86 Dell servers we have which generate
> an NMI when the PCIe link goes down (when we reprogram the fpga).
> They also fail to boot if a link doesn't come up...
> 
>         David

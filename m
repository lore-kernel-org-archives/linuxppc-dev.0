Return-Path: <matsumoto.hiroo@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 677FCB70AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 10:02:24 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E96DE3EE0AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 09:02:20 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CFBDE45DE4E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 09:02:20 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id BAA1945DE4D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 09:02:20 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id AEEA11DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 09:02:20 +0900 (JST)
Received: from m005.s.css.fujitsu.com (m005.s.css.fujitsu.com [10.23.4.35])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6EE031DB803A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 09:02:20 +0900 (JST)
Received: from m005.css.fujitsu.com (m005 [127.0.0.1])
 by m005.s.css.fujitsu.com (Postfix) with ESMTP id 4CBA550EC41
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 09:02:20 +0900 (JST)
Received: from [127.0.0.1] (ubi135.utsfd.cs.fujitsu.co.jp [10.24.19.135])
 by m005.s.css.fujitsu.com (Postfix) with ESMTP id 1C22650EC42
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 09:02:20 +0900 (JST)
Message-ID: <4F876D63.4060103@jp.fujitsu.com>
Date: Fri, 13 Apr 2012 09:03:47 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] powerpc: set_dma_ops for pci hotplug
References: <4F867083.2090200@jp.fujitsu.com>
In-Reply-To: <4F867083.2090200@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi


I'm so sorry, but there is a better way than this way with
pcibios_enable_device() for issue.
I will write another code soon, so please wait.


Regards.

Hiroo MATSUMOTO

> Hi
> 
> 
> I'm trying to use PCI Express Hot Plug on powerpc platform.
> But PCI driver returns error when hotplug.
> Error log is as below.
> http://www.spinics.net/lists/linux-pci/msg14534.html
> 
> Some of PCI driver needs dma_ops.
> On x86 platform, dma_ops is getting from external variable.
> On powerpc platform, dma_ops is getting from archdata.dma_ops in struct
> device.
> There is a problem that archdata.dma_ops is set only when boot with
> pcibios_setup_bus_devices but not set when hotplug.
> So when hotplug, PCI driver's probe will return error.
> 
> I add code of checking and setting dma_ops in pcibios_enable_device.
> It is called from pci_enable_device_xxx in PCI driver's probe before
> checking dma_ops.
> And PCI driver works good when hotplug.
> 
> 
> Regards.
> 
> Hiroo MATSUMOTO
> 

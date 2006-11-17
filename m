Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D072E679E9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 21:14:31 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kAHAEScf012648
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:14:28 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kAHAESIQ005828
	for linuxppc-dev@ozlabs.org; Fri, 17 Nov 2006 19:14:28 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kAHAEPnR018772
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 19:14:25 +0900 (JST)
Date: Fri, 17 Nov 2006 19:14:24 +0900 (JST)
Message-Id: <200611171014.kAHAEPKA011876@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 14/16] Resource assignments for PCI devices on Celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben-san,

>On Wed, 2006-11-15 at 18:58 +0900, Ishizaki Kou wrote:
>> Celleb has multiple PCI buses. Devices on some of those PCI buses require to
>> assign resources by Linux. 
>> This patch is for such buses not to claim resources, because claimed resource
>> does not become a target for resource assign.
>
>I do not fully understand why you need that. You should be able to let
>the PCI code claim all resources wether they are on real PCI or not.


This is a temporary workaround for following problem.
   
On Celleb, values of PCI base addresses of PCI devices which are not
described in device tree are not initialized before linux starts. So
we use pci_bus_assign_resources() later to assign resources for them 
at ppc_md.pcibios_fixup(). But by original code, when
ppc_md.pcibios_fixup() is called, resources are already claimed and
pci_bus_assign_resource() does not work to assign resources.

It may not be a good idea to call pci_bus_assign_resources() at the
timing of ppc_md.pcibios_fixup(), but we did not find an alternative
idea.


Thank you,
Kou Ishizaki
Toshiba

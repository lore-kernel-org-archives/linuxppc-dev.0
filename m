Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 430B8DDEC9
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 04:05:02 +1000 (EST)
Date: Fri, 5 Oct 2007 22:05:53 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/7] [POWERPC] mpc8568mds.dts: fix PCI/PCIe nodes
Message-ID: <20071005180553.GA32405@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
	<20071005174642.GB32145@localhost.localdomain>
	<47067ADE.9060306@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47067ADE.9060306@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 09:56:46PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Anton Vorontsov wrote:
>
>> Commit 5bece127f0666996ca90772229e00332a34e516c tried to fix
>> PCI/PCIe nodes, but actually it broke them even harder. ;-)
>
>    Of course. But shouldn't those be the subnoses of the "soc" type node?

Nope. PCI's ranges = <>; isn't in the SOC address space.

Valentine Barshak posted a patch titled "[RFC] [PATCH] PowerPC: Add 64-bit
phys addr support to 32-bit pci" that started using of_translate_address()
for ranges, and of_translate_address() will not work if PCI placed in the
SOC node. Not sure if that patch applied or not, though.

Good luck,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

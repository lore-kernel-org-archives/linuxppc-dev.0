Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E679DDE50E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:53:15 +1000 (EST)
Message-Id: <C2C3AFC1-7527-4571-8E21-3EB5904695DE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18436.35348.316368.332336@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 12/12] [POWERPC] 85xx: Add support for relocatble kernel
	(and booting at non-zero)
Date: Tue, 15 Apr 2008 17:53:10 -0500
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-5-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-6-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-7-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-8-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-9-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-11-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-12-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-13-git-send-email-galak@kernel.crashing.org>
	<18436.35348.316368.332336@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> What happens if CONFIG_KERNEL_START != CONFIG_PAGE_OFFSET and the
> kernel is loaded at some address != CONFIG_PHYSICAL_START?

Assuming its not a CONFIG_RELOCATABLE kernel than bad things.  Is  
there some concern you have here?

> Are we sure that ARCH_PFN_OFFSET only gets applied to normal memory
> pages, not any I/O?

correct.  ioremap uses map_page which isn't effected by ARCH_PFN_OFFSET

>  What happens to /dev/mem when ARCH_PFN_OFFSET != 0?

it behaves the same.  You provide a physical address and it provides  
access to it.  (so you could access memory you aren't suppose to)

- k

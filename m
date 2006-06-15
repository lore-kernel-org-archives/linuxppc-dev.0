Return-Path: <shawnxjin@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by ozlabs.org (Postfix) with ESMTP id 4FE5567C60
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 07:20:49 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id m51so503218pye
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 14:20:48 -0700 (PDT)
Message-ID: <c3d0340b0606151414q6d218554j255fa74a68a5c9af@mail.gmail.com>
Date: Thu, 15 Jun 2006 14:14:17 -0700
From: "Shawn Jin" <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>, ppcdev <linuxppc-dev@ozlabs.org>
Subject: MSI support on Linux PCI implementation for Ocotea
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm looking at the linux PCI implementation, especially MSI support
for Ocotea. And I have some observations and questions about it. Maybe
somebody here can shed some light on them. Thanks.

1. Obviously MSI is supported in Linux 2.6.x, maybe even in 2.4.x. But
MSI implementation seems to support only IOxAPIC on x86 or IA64
architectures, though the implemenation is in generic drivers/pci
tree.

2. Why is the message data defined in a such way shown as follows? Or
does it just follow IOxAPIC's design? Further question is who defines
the format of the message data. The PCI/PCIe specs don't say anything
about the content of the message data register.

struct msg_data {
	__u32	vector		:  8;
	__u32	delivery_mode	:  3;	/* 000b: FIXED | 001b: lowest prior */
	__u32	reserved_1	:  3;
	__u32	level		:  1;	/* 0: deassert | 1: assert */
	__u32	trigger		:  1;	/* 0: edge | 1: level */
	__u32	reserved_2	: 16;
} __attribute__ ((packed));

3. How is the pci subsystem initialized on a PPC platform? Is there
any existing document discussing PCI subsystem? Of course I've been
doing a lot internet search and couldn't find too much useful infor.

Thanks a lot,
-Shawn.

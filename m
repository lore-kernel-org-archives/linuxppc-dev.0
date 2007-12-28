Return-Path: <vincitoreg@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id 03F57DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Dec 2007 00:59:42 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so2444877rvf.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Dec 2007 05:59:40 -0800 (PST)
Message-ID: <d3ef3b090712280559s121d9368nc7bc0edafe2d20f4@mail.gmail.com>
Date: Fri, 28 Dec 2007 05:59:40 -0800
From: Vincitore <vincitoreg@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: How can I support 2GB of memory in Linux kernel on 440SPe
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I need to support 2GB of memory on a custom 440SPe board.

I see to support 1GB of memory on the 440SPe yucca board the following
configuration changes were done.

#
# Advanced setup
#

CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE_BOOL=y
CONFIG_LOWMEM_SIZE=0x40000000
CONFIG_KERNEL_START_BOOL=y
CONFIG_KERNEL_START=0xa0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
# CONFIG_CONSISTENT_START_BOOL is not set CONFIG_CONSISTENT_START=0xff100000
# CONFIG_CONSISTENT_SIZE_BOOL is not set
CONFIG_CONSISTENT_SIZE=0x00200000 # CONFIG_BOOT_LOAD_BOOL is not set
CONFIG_BOOT_LOAD=0x01000000

It looks like the only thing I would need to do is modify the
following for 2GB support.

CONFIG_LOWMEM_SIZE=0x80000000
and
CONFIG_KERNEL_START=0x60000000

But this does not work. It almost does, but right after I get to the
Linux prompt, this system panics. If I scale back to one 1GB
everything works great.

Any ideas?

Thank You,

Vincitore

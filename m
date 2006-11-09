Return-Path: <Simon.Richter@hogyros.de>
Received: from kleinhenz.com (static.88-198-202-190.clients.your-server.de
	[88.198.202.190]) by ozlabs.org (Postfix) with ESMTP id 422B467C4D
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 01:34:58 +1100 (EST)
Message-ID: <45533C79.70404@hogyros.de>
Date: Thu, 09 Nov 2006 15:34:33 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: APUS and IOs question
References: <1162767333.28571.254.camel@localhost.localdomain>	
	<454F5259.3020107@hogyros.de> <454F5E44.4040301@genesi-usa.com>	
	<1162844529.28571.327.camel@localhost.localdomain>	
	<455081AC.3010301@hogyros.de>
	<1162931605.28571.491.camel@localhost.localdomain>
In-Reply-To: <1162931605.28571.491.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Benjamin Herrenschmidt schrieb:

> Can you give me a proper explanation of the whole memory map story on it
> so I get a better idea of how invasive handling it would be ?

On APUS systems, you have two (major) kinds of memory, that on the Amiga
board and that on the CPU board. The former is generally mapped at
address zero, but you don't want to use it except as DMA buffers when
talking to the internal hardware (because the internal hardware doesn't
see the memory on the CPU board).

The memory on the CPU board is the "main" memory for Linux (because
there is more of it, and the access is faster), but its location is
assigned dynamically during the boot process, and depends on the size of
the memory and on other boards installed.

My plan for moving APUS to arch/powerpc involves writing a new
bootloader (I'm currently hacking binutils to support AmigaOS binaries)
that builds a proper flattened device tree and calls the kernel, but I'm
not sure where the kernel virtual mapping that allows the kernel to run
from a fixed address should be set up -- if in the bootloader, the
kernel needs to be aware that changing the MMU settings will yield
interesting results, and if in the kernel, we need some platform
specific init code to handle that.

   Simon

Message-ID: <3BE17B78.79443EB1@cambridgebroadband.com>
Date: Thu, 01 Nov 2001 16:42:32 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: John Francis <johnfrancsis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is there no vmalloc() for PPC kernel?
References: <20011025093708.81325.qmail@web20107.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've written a resident driver which calls vmalloc.

If you're writing a module which calls vmalloc you'll need to make sure EXPORT_SYMBOL(vmalloc)
appears in

linux/arch/$(ARCH)/kernel/$(ARCH)_ksyms.c:

... otherwise insmod will fail.

Alex

John Francis wrote:
>
> I need to allocate more than page worth of memory in
> kernel. Some documentation that I looked at indicated
> I should be using vmalloc() , so I tried using it for
> PPC kernel and it couldn't find this symbol. Looked
> through the code ( 2.4.4 ) and I didn't see it.
>
> What is the best way to allocate "fairly" large memory
> pool for use within the kernel by the driver?
>
> John
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

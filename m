Message-ID: <3B674D96.5E7C480D@mvista.com>
Date: Tue, 31 Jul 2001 20:30:14 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Masahide Tomita <tomita@itl.nyc.co.jp>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where can I configure the base address?
References: <a04320401b78cf51b9c51@[192.168.10.144]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Masahide Tomita wrote:
>
> Hello,
>
> I'm struggling to get the kernel (zvmlinux) run on our custom board with
> 860T, but I think I get it loaded on wrong address.

The zImage is a relocating, "self extracting" file.  Remove the 64K
ELF header from the beginning of the file, load the resuling bag of
bits at or above 0x200000, and jump to that location.  The "bootloader"
will start, request kernel start options, uncompress the kernel to
address zero, and start it.

This has all been discussed many times, along with different booting
options.  Search the mailing list kernel for more information.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

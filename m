Date: Tue, 8 Apr 2003 09:20:18 -0700
From: Matt Porter <porter@cox.net>
To: invictus rm <invictus_rm@hotmail.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: insmod search_exception_table !!!
Message-ID: <20030408092018.A20846@home.com>
References: <F108HX2WK43S3Iouk4R0001e01b@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F108HX2WK43S3Iouk4R0001e01b@hotmail.com>; from invictus_rm@hotmail.com on Tue, Apr 08, 2003 at 09:40:37PM +0530
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 08, 2003 at 09:40:37PM +0530, invictus rm wrote:
>
> Hi ,
> I am working on a board which has 512MB RAM . The PCI space is from
> 0xe0000000 to 0xf8000000.
> 0xf8000000 -- 0xfc000000 device 1
> Remaining for other I/0(Flash/RTC..etc)
>
> When i try to load any module(insmod), the kernel crashes every time .

Sounds like you clobbered vmalloc space.  Did you use io_block_map()
calls and limit the amount of vmalloc space available?  How much
address space have you ioremapped before loading the module?

Assuming you aren't using any advanced options to change PAGE_OFFSET
and friends, your vmalloc space starts at 0xe1000000.  I sure hope
you haven't 1:1 mapped that PCI mem space into kernel virtual space.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Tue, 8 Apr 2003 14:56:45 -0700
From: Matt Porter <porter@cox.net>
To: invictus rm <invictus_rm@hotmail.com>
Cc: porter@cox.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: insmod search_exception_table !!!
Message-ID: <20030408145645.A21872@home.com>
References: <F49AKyxkM47Zs0B0fpn00027e69@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F49AKyxkM47Zs0B0fpn00027e69@hotmail.com>; from invictus_rm@hotmail.com on Tue, Apr 08, 2003 at 10:08:35PM +0530
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 08, 2003 at 10:08:35PM +0530, invictus rm wrote:
> Hi Matt,
> I am using io_block_mapping for early_console_prints
>     io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
>
> Is this a cause of the problem ??

Not on its own...you should have ~240MB of initial vmalloc space with
this configuration.

> How do i know how much addr i have ioremapped ??

You really want to know how much vmalloc space has been consumed
by all users.

Hard way:

Count all the ioremaps you do (plus 4KB offset between each
vmalloc offset).  If you are on a non-coherent platform you also
have to consider all consistent alloced memory.

Easy way:
ftp://source.mvista.com/pub/linuxppc/vmalloc_stats-2_4_devel.patch
/proc/meminfo contains vmalloc usage stats.

> My PAGE_OFFSET is at 0xc0000000
>
> Do i need to change the PCI MEM Map also if i am having a 1:1 mapping in the
> kernel virtual space ??

No, you just need to be aware that VMALLOC_END=ioremap_bot and this
value is set to whatever your lowest io_block_map virtual address is.
Any early ioremaps (pre-MM initialized) you do to place system devices
will further drop VMALLOC_END and constrain your vmalloc space.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

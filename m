Message-Id: <5.1.0.14.2.20030908150153.039d7288@mail.ebshome.net>
Date: Mon, 08 Sep 2003 15:08:12 -0700
To: Brian Kuschak <bkuschak@yahoo.com>
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: virt_to_phys() on 440
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030908213638.4000.qmail@web40910.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:36 PM 9/8/2003, Brian Kuschak wrote:

>I think the virt_to_phys() function is incorrect for
>PPC440.  It should call iopa for all 4xx, not only the
>405.  By chance, it happens to work currently if the
>address is in SDRAM, but is always incorrect for
>ioremapped addresses.  virt_to_bus() does the right
>thing.

No, it shouldn't call iopa even for 405. Look at 2.6 version for example.

virt_to_phys is used only for directly mapped addresses not for ioremaped
peripherals or vmalloc space.

>Also, to be correct, shouldn't this function return a
>phys_addr_t rather than an unsigned long, as the
>physical address is >32 bits on 44x?

440 cannot handle more than 2G of RAM, so physaddr_t is not needed.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

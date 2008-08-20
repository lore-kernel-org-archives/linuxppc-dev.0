Return-Path: <temerkhanov@yandex.ru>
Received: from smtp10.yandex.ru (smtp10.yandex.ru [213.180.223.92])
	by ozlabs.org (Postfix) with ESMTP id CCAC5DDF8D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 10:11:10 +1000 (EST)
Received: from ppp91-78-91-31.pppoe.mtu-net.ru ([91.78.91.31]:62836 "EHLO
	[10.0.0.10]" smtp-auth: "temerkhanov" TLS-CIPHER: <none> TLS-PEER-CN1:
	<none>) by mail.yandex.ru with ESMTP id S5865700AbYHTXrA (ORCPT
	<rfc822;linuxppc-embedded@ozlabs.org>);
	Thu, 21 Aug 2008 03:47:00 +0400
Message-ID: <48ACACF6.7040908@yandex.ru>
Date: Thu, 21 Aug 2008 03:47:02 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
MIME-Version: 1.0
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: facing problem with io_p2v() function
References: <18965524.post@talk.nabble.com>
In-Reply-To: <18965524.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Misbah khan wrote:
> Hi all,
>
> I am using io_p2v() function in my driver to get the virtual address mapping
> timer control registers
>
> i am passing address as 0x48304024 as base and after getting the virtual
> address of it i am reading and writing to it but my any attempt to read the
> location or write is giving segmentation fault
>
> If i use __pa() to read the corresponding location it returning as
> 0x98304024 insted of 0x48304024
>
> I dont know where the mapping is going wrong 
>
> Even when i tried using ioremap() i got the same kernel panic 
>
> Below is the error message 
>
>
> -------------------------------------------------------------------------------------------------------
>
> In init function
>  Read reg address virt 0xd8304024 and phy 0x98304024 are
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xd8304024
> Internal error: : 1028 [#1]
> Modules linked in: omap_timer
> CPU: 0    Not tainted  (2.6.22.1-omap3 #1)
> PC is at omap_timer_read_register+0x30/0x3c [omap_timer]
> LR is at release_console_sem+0x1c0/0x1d4
> pc : [<bf000160>]    lr : [<c005f650>]    psr: 60000013
> sp : c7f1bea0  ip : c7f1bdd8  fp : c7f1beb4
> r10: c8858000  r9 : 00000026  r8 : 00000027
> r7 : c06dfdf0  r6 : 00000000  r5 : bf001018  r4 : 00000024
> r3 : d8304000  r2 : 00000000  r1 : 60000013  r0 : 0000003d
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
> Control: 00c5387f  Table: 80694018  DAC: 00000015
> Process insmod (pid: 306, stack limit = 0xc7f1a2d0)
> Stack: (0xc7f1bea0 to 0xc7f1c000)
> bea0: 00000000 bf001018 c7f1bed4 c7f1beb8 bf0001c4 bf00013c 00000000
> bf001280
> bec0: bf001100 c06dfdf0 c7f1bef4 c7f1bed8 bf0030c4 bf0001b0 00000000
> c006b5c4
> bee0: c06dfdc4 c06dfc00 c7f1bfa4 c7f1bef8 c007f514 bf00300c 00000000
> c0024380
> bf00: 000ce008 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> bf20: 00000000 00000000 00000000 00000000 00000000 00000000 c886ca30
> c07fc200
> bf40: 00000000 c8867c88 c88678f0 00000000 00000054 00000054 0000000a
> c886758f
> bf60: c8867cd8 bf00110c c8867cb0 00000024 00000000 c035da98 c0030184
> 000a81fc
> bf80: bebf5d74 00014cdd 00000080 c0029f68 c7f1a000 00000000 00000000
> c7f1bfa8
> bfa0: c0029dc0 c007e1d8 000a81fc bebf5d74 000ce018 00014cdd 000ce008
> 00000001
> bfc0: 000a81fc bebf5d74 00014cdd 00000080 00000000 bebf5d74 bebf5e54
> 00000061
> bfe0: bebf5a20 bebf5a10 0001e1c0 401d2ec0 60000010 000ce018 00000017
> 0011b8d8
> Backtrace:
> [<bf000130>] (omap_timer_read_register+0x0/0x3c [omap_timer]) from
> [<bf0001c4>] (omap_dm_timer_set_l
> oad+0x20/0x5c [omap_timer])
>  r5:bf001018 r4:00000000
> [<bf0001a4>] (omap_dm_timer_set_load+0x0/0x5c [omap_timer]) from
> [<bf0030c4>] (omap_gp_timer_init_mo
> de+0xc4/0xf0 [omap_timer])
>  r7:c06dfdf0 r6:bf001100 r5:bf001280 r4:00000000
> [<bf003000>] (omap_gp_timer_init_mode+0x0/0xf0 [omap_timer]) from
> [<c007f514>] (sys_init_module+0x13
> 48/0x1400)
>  r5:c06dfc00 r4:c06dfdc4
> [<c007e1cc>] (sys_init_module+0x0/0x1400) from [<c0029dc0>]
> (ret_fast_syscall+0x0/0x2c)
> Code: e1a01003 e59f000c eb417e8b e5953010 (e7930004)
> Segmentation fault
>
> -----------------------------------------------------------------------------------------------------------
>
> Looking forward for the suggestion for the above problem
>
>
> ----- Misbah <><
>   
Did you try the ioremap() function for this?

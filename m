Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20030807154923.56073.qmail@web105.mail.yahoo.com>
Date: Thu, 7 Aug 2003 23:49:23 +0800 (CST)
From: =?gb2312?q?ZhongJun=20Zhou?= <zjzhou@newrocktech.com>
Subject: Re: kernel memory mapping problem
To: Peter Barada <pbarada@mail.wm.sps.mot.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200308071501.h77F1iL19883@hyper.wm.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks very much.

But my functions are serial running on PPC82xx, its
means that when I mapped the the address using __pa(
(void *)tmp) to bd_address, then reading the BD's
status and control registers, if OK, then return from
this function. Is it OK with this method? Next, if I
use "kmalloc" to get the buffer and map it to CPM with
__pa() function, that can be run, is right?  any other
functions can finish this mapping action ? or give me
any good documents for my reading?

thanks in advance!

--- Peter Barada <pbarada@mail.wm.sps.mot.com>
> >when run this module( lsmod mymodule.o ), kernel is always dead. Are
> >there any errors of this function ?
>
> What are you doing with the physical address of a varaible that is on
> the *stack*? If you let some hardware modify that value, then you can
> easily trash your stack if the hardware modifies this value *after*
> this function exits since tmp will go out of scope.
>
> I'd suggest that you move tmp outside of func for starters.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

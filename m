Date: Wed, 17 Nov 1999 11:53:40 -0800
From: "David N. Welton" <davidw@linuxcare.com>
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Cc: ajoshi@shell.unixbox.com
Subject: Re: again 2.3.28
Message-ID: <19991117115340.D4281@bassano.linuxcare.com>
References: <19991117110116.B4281@bassano.linuxcare.com> <Pine.LNX.4.10.9911171141110.5126-100000@shell.unixbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9911171141110.5126-100000@shell.unixbox.com>; from Ani Joshi on Wed, Nov 17, 1999 at 11:43:40AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 17, 1999 at 11:43:40AM -0800, Ani Joshi wrote:

> On Wed, 17 Nov 1999, David N. Welton wrote:

> > So, we can't use prom_print to print checkpoints and we can't use
> > printk yet.
 
> you can use prom_print to print until start_kernel, 

This is from arch/ppc/kernel/prom.c :

 * Because OF may have mapped I/O devices into the area starting at
 * KERNELBASE, particularly on CHRP machines, we can't safely call
 * OF once the kernel has been mapped to KERNELBASE.  Therefore all
 * OF calls should be done within prom_init(), and prom_init()
 * and all routines called within it must be careful to relocate
 * references as necessary.

This is indeed a CHRP machine, an RS6K F50, to be precise.

So, according to the people who wrote this code, you cannot do that.

> then you can use printk because console_init() is done very early
> (unless its dieing before that which would really suck), but i'm
> pretty sure you should be able to prom_print until then.  how are
> you calling your prints?

I was calling them with 'bl myfunc', which was defined as void myfunc
() and contained a call to prom_print.

Thanks,
-- 
David N. Welton, Developer, Linuxcare, Inc.
415.354.4878 x241 tel, 415.701.7457 fax
davidw@linuxcare.com, http://www.linuxcare.com/
Linuxcare. At the center of Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

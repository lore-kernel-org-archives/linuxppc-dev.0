Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8844A2C0081
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2012 19:16:43 +1000 (EST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glppe-linuxppc-embedded-2@m.gmane.org>)
 id 1StbEN-0003O7-ML
 for linuxppc-dev@ozlabs.org; Tue, 24 Jul 2012 11:16:39 +0200
Received: from 146.177.65.86.rev.sfr.net ([86.65.177.146])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2012 11:16:39 +0200
Received: from g.bugniot by 146.177.65.86.rev.sfr.net with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2012 11:16:39 +0200
To: linuxppc-dev@ozlabs.org
From: Geoffrey Bugniot <g.bugniot@gmail.com>
Subject: Re: Memory management problems on a custom PPC 8270 board
Date: Tue, 24 Jul 2012 09:16:25 +0000 (UTC)
Message-ID: <loom.20120724T102618-734@post.gmane.org>
References: <loom.20120723T170223-328@post.gmane.org>
 <500D8067.6070805@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood <at> freescale.com> writes:

> 
> On 07/23/2012 10:34 AM, Geoffrey Bugniot wrote:
> > I got something like that :
> > [  148.891584] Kernel panic - not syncing: Attempted to kill init!
> 
> Was there anything before this?
>

No, that's the complete dump.


> > [  148.897503] Call Trace:
> > [  148.899934] [c7829d10] [c0008fbc] show_stack+0x4c/0x138 (unreliable)
> > [  148.906470] [c7829d50] [c03be7d8] panic+0xa4/0x1e8
> > [  148.911401] [c7829db0] [c0025580] do_exit+0x94/0x630
> > [  148.916501] [c7829e00] [c0025bdc] do_group_exit+0x80/0xac
> > [  148.922071] [c7829e10] [c00340d8] get_signal_to_deliver+0x474/0x490
> > [  148.928515] [c7829e70] [c0009aa4] do_signal_pending.constprop.9+0x40/0x22c
> > [  148.935586] [c7829f30] [c0009d88] do_signal+0x24/0x50
> > [  148.940793] [c7829f40] [c000f76c] do_user_signal+0x74/0xc4
> > [  148.946419] --- Exception: 700 at 0xfec5394
> > [  148.946433]     LR = 0x1000410c
> > [  148.954009] Rebooting in 3 seconds..
> 
> This looks like your init process crashed.  You could try enabling
> show_unhandled_signals in arch/powerpc/signal.c.

With "show_unhandled_signals = 1", I get few lines more :

root@pLinesE_VMEb:~# tar cvf file.tar.gz file1 file2 file3 file4
file1
file2
file3
file4
tar[243]: unhandled signal 11 at bfaec004 nip 100064fc lr 100063dc code
30001
Segmentation fault
sh[233]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0febf0e0 code 30001
klogd[227]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code
30001
init[244]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code 30001
init[245]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code 30001
init[246]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code 30001
init[247]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code 30001
init[248]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code 30001
init[249]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code 30001
init[250]: unhandled signal 4 at 0febf184 nip 0febf184 lr 0ffabb8c code 30001
Kernel panic - not syncing: Attempted to kill init!
Call Trace:
[c7815d30] [c0007d1c] show_stack+0x4c/0x138 (unreliable)
[c7815d70] [c01e2004] panic+0xa4/0x1d8
[c7815dd0] [c001ddb0] do_exit+0xa0/0x5c0
[c7815e20] [c001e390] do_group_exit+0x80/0xac
[c7815e30] [c00285c0] get_signal_to_deliver+0x2e4/0x300
[c7815e70] [c00087f4] do_signal_pending.constprop.9+0x40/0x22c
[c7815f30] [c0008ad8] do_signal+0x24/0x50
[c7815f40] [c000deec] do_user_signal+0x74/0xc4
--- Exception: 700 at 0xfebf184
    LR = 0xffabb8c
Rebooting in 3 seconds..


> What are you running as your init process?  Do you have a normal
> init/login scheme, or are you running a shell (esp. busybox, which would
> have cp built in) directly as init?

I build the kernel with an initramfs. In this one, I have an init script for
mounting my flash device (which contains a JFF2 filesystem based on ELDK),
and to process the "switch_root". Indeed, I used BusyBox in my initramfs and in
the ELDK filesystem.


> > When I use netsniff-ng, with default parameters, kernel hangs too. But If I
> > specify a small ring buffer size with option "netsniff-ng -S 3MB" all is
> > running fine. Here, is the dump when netsniff-ng causes a crash:
> > 
> > root <at> pLinesE_VMEb:~# netsniff-ng
> > netsniff-ng 0.5.5.0 -- pid (245)
> > [   36.065574] device eth0 entered promiscuous mode
> > nice (0), scheduler (0 prio 0)
> > 1 of 1 CPUs online, affinity bitstring (1)
> > No device specified, using `eth0`.
> > No filter applied. Switching to `all traffic`.
> > 
> > [   36.159714] BUG: Bad page state in process netsniff-ng  pfn:05401
> > [   36.165759] page:c0401020 count:0 mapcount:1 mapping:  (null)
> > index:0x0
> > [   36.172548] page flags: 0x0()
> 
> Could you have bad memory timings (or bad memory)?  Usually when I see
> things like this, it's because memory is getting corrupted.

After more investigation, with gdb, the panic occurs when the the function
"setsockopt" is called with the famous buffer (specify with -S xxMB) as a
parameter. And it's the first use of the buffer in the code.

I noticed that too : when I run tcpdump, It works, but if I run two tcpdump at
the same time, segmentation faults or illegal instructions appears.

It seems link to the usage of my memory. How can I investigate further to
identify eventuals memory timing problems?

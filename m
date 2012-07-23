Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACD512C0382
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2012 02:48:49 +1000 (EST)
Message-ID: <500D8067.6070805@freescale.com>
Date: Mon, 23 Jul 2012 11:48:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Geoffrey Bugniot <g.bugniot@gmail.com>
Subject: Re: Memory management problems on a custom PPC 8270 board
References: <loom.20120723T170223-328@post.gmane.org>
In-Reply-To: <loom.20120723T170223-328@post.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2012 10:34 AM, Geoffrey Bugniot wrote:
> Hi,
> 
> I've ported on a custom board U-Boot and Linux 2.6.39.4. It seems to work
> well until the kernel is begin to manipulate "data/file" with a size larger
> than about 5 Mo. I suppose that's a VM management problem, but I'm not
> sure.
> 
> In fact, when I use "cp file1 file2" with file1 >= 5/6 Mo, the kernel panics.
> Same behaviour with a command like "tar cvf file.tar.gz file1 file2...".
>
> I got something like that :
> 
> [  148.891584] Kernel panic - not syncing: Attempted to kill init!

Was there anything before this?

> [  148.897503] Call Trace:
> [  148.899934] [c7829d10] [c0008fbc] show_stack+0x4c/0x138 (unreliable)
> [  148.906470] [c7829d50] [c03be7d8] panic+0xa4/0x1e8
> [  148.911401] [c7829db0] [c0025580] do_exit+0x94/0x630
> [  148.916501] [c7829e00] [c0025bdc] do_group_exit+0x80/0xac
> [  148.922071] [c7829e10] [c00340d8] get_signal_to_deliver+0x474/0x490
> [  148.928515] [c7829e70] [c0009aa4] do_signal_pending.constprop.9+0x40/0x22c
> [  148.935586] [c7829f30] [c0009d88] do_signal+0x24/0x50
> [  148.940793] [c7829f40] [c000f76c] do_user_signal+0x74/0xc4
> [  148.946419] --- Exception: 700 at 0xfec5394
> [  148.946433]     LR = 0x1000410c
> [  148.954009] Rebooting in 3 seconds..

This looks like your init process crashed.  You could try enabling
show_unhandled_signals in arch/powerpc/signal.c.

What are you running as your init process?  Do you have a normal
init/login scheme, or are you running a shell (esp. busybox, which would
have cp built in) directly as init?

> When I use netsniff-ng, with default parameters, kernel hangs too. But If I
> specify a small ring buffer size with option "netsniff-ng -S 3MB" all is
> running fine. Here, is the dump when netsniff-ng causes a crash:
> 
> root@pLinesE_VMEb:~# netsniff-ng
> netsniff-ng 0.5.5.0 -- pid (245)
> [   36.065574] device eth0 entered promiscuous mode
> nice (0), scheduler (0 prio 0)
> 1 of 1 CPUs online, affinity bitstring (1)
> No device specified, using `eth0`.
> No filter applied. Switching to `all traffic`.
> 
> [   36.159714] BUG: Bad page state in process netsniff-ng  pfn:05401
> [   36.165759] page:c0401020 count:0 mapcount:1 mapping:  (null) index:0x0
> [   36.172548] page flags: 0x0()

Could you have bad memory timings (or bad memory)?  Usually when I see
things like this, it's because memory is getting corrupted.

-Scott

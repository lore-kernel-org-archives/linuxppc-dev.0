Date: Sat, 26 Apr 2003 22:22:28 +0200
Subject: Re: ibook2r2 & strange freeze.
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: "Linuxppc-Dev@Lists.        " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Brice Figureau <brice@tincell.com>
In-Reply-To: <1051353230.10342.31.camel@gaston>
Message-Id: <CCF033C0-7824-11D7-9243-0003939D5F18@tincell.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Saturday, April 26, 2003, at 12:33 PM, Benjamin Herrenschmidt wrote:
>
>> After several hours of kernel compiling (my ibook is not that fast
>> ;-)), I found that the latest working patch is -ben8.
>> The first non working is then -ben9.
>
> Great, many thanks. That will help.
>
> Can you try now to put drivers/video/radeonfb.c from -ben8 into
> -ben9 (and then -ben10 if it works) and tell me if that helps ?
Here is the results:
  -ben9 with -ben8 radeon crashes exactly at the same place
  -ben10 with -ben8 radeon crashes exacctly like -ben9

Just to remind you:
  -ben9 crashes always at the same place (and triggers xmon, have a look
at the backtrace)
  -ben10 freezes randomly, usually in the boot process. It freezes often
right after the font uploading to the console layer, but sometimes
farther (I once could go until the network started). When it freezes
the last line at the bottom of the screen is printed *twice* (which
might confirm the -ben9 backtrace).

All the tested kernels were configured with CONFIG_PPC_RTC enabled (and
CONFIG_RTC disabled), and CONFIG_CPU_FREQ disabled too.

noaccel parameters didn't seem to change anything. I might have to
check again.

>> I can crash ben9 almost reproductibly and xmon is triggered if that
>> can
>> help you (I didn't understand how to use the System.map with xmon to
>> decipher the stack trace, but I might send xmon output and my
>> System.map).
>> Note this might not be the same crash as ben10, because xmon is not
>> fired with this kernel, although it seems to crash at the early
>> beginning of rc.sysinit (I'm almost sure this is something about the
>> fonts).
>
> With this, xmon will know about symbols. Then, you can use the "t"
> command in xmon to get a backtrace.
Here is the -ben9 crash stack trace (hand copied from the screen)
Vector:200 at pc=.... (t fbcon_radeon_bmove+0x1c8) lr=..... (t
fbcon_scroll+0x7b4)
...
backtrace:

T do_page_faults+0x298
t fbcon_scroll+0xac
t scrup+0x11c
t lf+0x98
t do_con_trol+0xda0
t do_con_write_0x480
t con_put_char+0x50
t opost+0xbc
t write_char+0x1c4
t do_tty_write+0x90
t tty_write+0x12c
t sys_write+0xbc
t ret_from_syscall_1+0x0

As far as I can see, the crash occurs while scrolling the screen.
Since the line is printed twice in the ben10 freeze, it might be the
same problem as ben9.
If only I could crash ben10 and end up into xmon...

I hope this will help you. If you need more information, let me know.


Thanks,
Regards,
Brice


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

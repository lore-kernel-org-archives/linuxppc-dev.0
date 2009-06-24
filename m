Return-Path: <Timothy.Bird@am.sony.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15])
	by bilbo.ozlabs.org (Postfix) with ESMTP id CE4C3B70BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 15:19:22 +1000 (EST)
Message-ID: <4A41B3A5.9010807@am.sony.com>
Date: Tue, 23 Jun 2009 22:03:33 -0700
From: Tim Bird <tim.bird@am.sony.com>
MIME-Version: 1.0
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: How the kernel printk works before do console_setup.
References: <cb9ecdfa0906232050n6fcfee31ubeee4bcd9b8c0dfe@mail.gmail.com>
In-Reply-To: <cb9ecdfa0906232050n6fcfee31ubeee4bcd9b8c0dfe@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Johnny Hung wrote:
> Hi All:
>     I have a powerpc arch platform. The default console is ttyS1 not
> ttyS0 in the platform. My question is how the kernel print debug
> message
> like DBG before parse kernel command line and do console_setup
> function. The command line passed to kernel about console info is
> console=ttyS1.
> So kernel can not print anything before parse cmd line and initial
> console but the result is against. Anyone point me or give me a clue
> is appreciate.

Before the console is set up, the printk data is formatted
and put into the kernel log buffer, but not sent to any console.
Any messages printk'ed before that are buffered but do not
appear.  When the console is initialized, then all buffered
messages are sent to the console, and subsequent printks cause
the message to go to the log buffer, but then immediately
get sent from there to the console.

Under certain conditions you can examine the log buffer of
a kernel that failed to initialize it's console, after a
warm reset of the machine, using the firmware memory dump
command.

See http://elinux.org/Kernel_Debugging_Tips#Accessing_the_printk_buffer_after_a_silent_hang_on_boot
for some tips on accessing the log buffer of a previous boot.

Note also, that if the serial console does not come up,
but the kernel successfully boots, and you can get a network
login on the machine, you can always print out the kernel log
buffer messages using 'dmesg' at a user-space shell prompt.

Hope this helps!
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Corporation of America
=============================

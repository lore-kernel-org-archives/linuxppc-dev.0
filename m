Return-Path: <johnny.hacking@gmail.com>
Received: from mail-gx0-f208.google.com (mail-gx0-f208.google.com
	[209.85.217.208])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 1C6F5B7091
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 16:27:57 +1000 (EST)
Received: by gxk4 with SMTP id 4so2125337gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 23:27:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1245884203.21200.18.camel@pasglop>
References: <cb9ecdfa0906232050n6fcfee31ubeee4bcd9b8c0dfe@mail.gmail.com>
	<4A41B3A5.9010807@am.sony.com> <1245884203.21200.18.camel@pasglop>
Date: Thu, 25 Jun 2009 14:27:54 +0800
Message-ID: <cb9ecdfa0906242327j76d1e4fbib13bc7d9753aeacf@mail.gmail.com>
Subject: Re: How the kernel printk works before do console_setup.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/6/25 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
>
>> Before the console is set up, the printk data is formatted
>> and put into the kernel log buffer, but not sent to any console.
>> Any messages printk'ed before that are buffered but do not
>> appear. =A0When the console is initialized, then all buffered
>> messages are sent to the console, and subsequent printks cause
>> the message to go to the log buffer, but then immediately
>> get sent from there to the console.
>>
>> Under certain conditions you can examine the log buffer of
>> a kernel that failed to initialize it's console, after a
>> warm reset of the machine, using the firmware memory dump
>> command.
>
> On ppc, we have tricks to display things earlier :-)
>
> We can initialize the serial ports way before console_setup() (and we do
> in most cases) and we use what we call the "udbg" console until the real
> one takes over. The "udbg" console is a very small layer which outputs
> via a provided "putc" routine. Platforms can provide their own here, we
> have a collection of standard ones for legacy UARTs (it should be
> automatically setup in that case by the code in legacy_serial), Apple
> ESCCs, etc... We even have compile time options that allow that stuff to
> be initialized before start_kernel...

Thank you. This is what I described and want to understand. The
arch/powerpc/kernel/legacy_serial.c
do find_legacy_serial_ports then take a default serial port by using
open firmware device tree
information. The find_legacy_serial_ports() called form setup_arch but
I don't know who call
setup_arch (setup_32.c)function. Can you give me a hint ? Thanks in advance=
d.

BRs, H. Johnny

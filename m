Return-Path: <benh@kernel.crashing.org>
Subject: Re: port gnome
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bai Shuwei <baishuwei@gmail.com>
In-Reply-To: <f3566d60710110122q23a0c49bkf0b8e8fd4f66b1e9@mail.gmail.com>
References: <f3566d60710110122q23a0c49bkf0b8e8fd4f66b1e9@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 11 Oct 2007 18:32:08 +1000
Message-Id: <1192091528.8476.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-10-11 at 16:22 +0800, Bai Shuwei wrote:
> 
> all, hi
>   I want to port the GNOME or KDE to AMCC PowerPC 440EP board. I want
> to know whether it will run and whether the monitor work if I use PCI
> to connect the monitor card? Thank you very much!

Gnome and KDE themselves should just work...

The problem is to get a video card working. The main issue is to
soft-boot it with some kind of x86 emulator such as x86emu. Once
that's done, the second main problem is that 440 tend to have
PCI memory space above 32bits, which totally defeats broken X
hacks through /dev/mem.

There's a way to work around the later by doing a kernel tweak to
create a "window" in /dev/mem that gets remapped to the appropriate
PCI space, but you still need to fake the card base address for
X ... pretty hard overall (doable though).

Ben.
 

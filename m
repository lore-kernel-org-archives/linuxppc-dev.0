Return-Path: <Sylvain.Lamontagne@novariant.com>
Received: from sm1.novariant.com (sm1.novariant.com [76.238.142.74])
	by ozlabs.org (Postfix) with ESMTP id 1BF6DB7D19
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 05:08:47 +1000 (EST)
Subject: Boot hang when setting console=none with MPC5200B custom board
From: Sylvain Lamontagne <sylvain.lamontagne@novariant.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Apr 2010 14:58:41 -0400
Message-ID: <1271962721.12334.34.camel@slamon-laptop.novariant.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi everybody,

I'm trying to remove the console from a custom board based on a
MPC5200B. During development we used console=3DttyS1,115200 in our bootcmd
for the kernel, but now that the product is ready to be shipped we want
to use ttyS1 for something else and would like to deactivate completely
the console. So the unit would be accessible only by ssh if needed.

(I'm not really confortable with this since a network problem would
prevent us of even debugging the platform... but I've been ask to do
it.)

Anyway, whenever I try to change console=3D to null or to tty1 or anything
else, the boot is hanging somewhere ( I know that, because some leds are
not flashing like they should on a normal boot and I can't login in with
ssh).

I've tried to use tty1, none, null, zero and I've tried to completely
remove the console=3D arguments... but nothing work, its hanging there
without any flashing leds.

I've tried redirecting another "real" serial port and it worked, so
console=3DttyPSC2,115200 work... but we need it also... so it can't do.

I've also tried the U-Boot's silent variable trick ... but it did not
work and I had to erase the environment of U-Boot with a JTAG to recover
back my default setting of ttyS1.

I'm now at a point where I think I have try everything that I know, and
since I have no way of "seeing" what is going on ... it's pretty hard to
debug.=20

The kernel is 2.6.29.2 and can't really be changed... (but it may be
patch)
This board doesn't have a framebuffer or a graphic chipset, everything
was done with a serial connection and now we want to remove this serial
connection (console) before sending it to a customer.

1. Is it possible ?
2. Do you have any idea how it can be achieve ?
3. Do you know a bug in 2.6.29.2 that could prevent this to work ?
4. The 'chosen' node is empty in my dts, does it require something to be
set ?

Thank you for your help ( I hope ;) )

Sylvain Lamontagne

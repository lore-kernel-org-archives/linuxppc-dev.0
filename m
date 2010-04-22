Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id A58CFB6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 05:11:29 +1000 (EST)
Received: by gwb11 with SMTP id 11so3051366gwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 12:11:28 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1271962721.12334.34.camel@slamon-laptop.novariant.com>
References: <1271962721.12334.34.camel@slamon-laptop.novariant.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 22 Apr 2010 13:11:05 -0600
Message-ID: <h2ofa686aa41004221211w227bfcc4l3c7a6cc26a81e7dc@mail.gmail.com>
Subject: Re: Boot hang when setting console=none with MPC5200B custom board
To: Sylvain Lamontagne <sylvain.lamontagne@novariant.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 22, 2010 at 12:58 PM, Sylvain Lamontagne
<sylvain.lamontagne@novariant.com> wrote:
> Hi everybody,
>
> I'm trying to remove the console from a custom board based on a
> MPC5200B. During development we used console=ttyS1,115200 in our bootcmd
> for the kernel, but now that the product is ready to be shipped we want
> to use ttyS1 for something else and would like to deactivate completely
> the console. So the unit would be accessible only by ssh if needed.
>
> (I'm not really confortable with this since a network problem would
> prevent us of even debugging the platform... but I've been ask to do
> it.)
>
> Anyway, whenever I try to change console= to null or to tty1 or anything
> else, the boot is hanging somewhere ( I know that, because some leds are
> not flashing like they should on a normal boot and I can't login in with
> ssh).
>
> I've tried to use tty1, none, null, zero and I've tried to completely
> remove the console= arguments... but nothing work, its hanging there
> without any flashing leds.
>
> I've tried redirecting another "real" serial port and it worked, so
> console=ttyPSC2,115200 work... but we need it also... so it can't do.
>
> I've also tried the U-Boot's silent variable trick ... but it did not
> work and I had to erase the environment of U-Boot with a JTAG to recover
> back my default setting of ttyS1.
>
> I'm now at a point where I think I have try everything that I know, and
> since I have no way of "seeing" what is going on ... it's pretty hard to
> debug.

Can you halt the processor with JTAG and look at the contents of __log_buf?

> The kernel is 2.6.29.2 and can't really be changed... (but it may be
> patch)
> This board doesn't have a framebuffer or a graphic chipset, everything
> was done with a serial connection and now we want to remove this serial
> connection (console) before sending it to a customer.
>
> 1. Is it possible ?

Yes, I believe so, but I haven't tried.

> 2. Do you have any idea how it can be achieve ?

You should be doing the right thing.  Are your userspace init scripts
trying to start a getty on the non-existent console device?

> 3. Do you know a bug in 2.6.29.2 that could prevent this to work ?

no

> 4. The 'chosen' node is empty in my dts, does it require something to be
> set ?

no

I think your best bet is to figure out some way to get at __log_buf to
retrieve the kernel output after the failed boot.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

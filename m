Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 9E906DE117
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 00:00:44 +1000 (EST)
Message-ID: <48A19788.6050502@harris.com>
Date: Tue, 12 Aug 2008 10:00:40 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
References: <48A05152.7020508@harris.com>	
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<48A0676E.5020308@harris.com>	
	<20080811170756.GA29827@oksana.dev.rtsoft.ru>
	<1218492032.8041.11.camel@pasglop>
In-Reply-To: <1218492032.8041.11.camel@pasglop>
Content-Type: multipart/alternative;
	boundary="------------070707030306030709020406"
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks,
	Sam" <SSparks@aclaratech.com>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070707030306030709020406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:
>   
>> 1. IDE status read does not work. (But am I understand correctly
>>    that IDE works well if IRQ is unspecified? Then this is hardly
>>    an issue.)
>> 2. IDE interrupt comes when it should not. I'd recommend to use
>>    oscilloscope to find out what is happening there, that is, if
>>    the drive actually deasserts its irq line after status read.
>>    If so, than this could be a PIC problem.
>>
>> What is the platform on which you're observing the issue, btw?
>>     
>
> Another possibility is that you got the wrong interrupt number
> in the device-tree...
>
> Ben.
>   

The platform is the AMCC Sequoia board.  We've built a little adapter to
connect a compact flash card to the processor bus.  I believe the
interrupt selection in the device tree is correct, and I've checked over
the u-boot settings for the IRQ line (active high, level sensitive). 
I've also tried edge-sensitive but it doesn't make a difference.

When u-boot queries the CF card, we see the IRQ pulse as expected, but
when the kernel runs, we see the IRQ go high and stay there, which the
kernel naturally treats as a stuck interrupt.  The other oddity is that
we see a single diagnostic failure on startup:

    ata1.00: Drive reports diagnostics failure. This may indicate a drive
    ata1.00: fault or invalid emulation. Contact drive vendor for
    information.


That is strange, because if we manually do the soft reset from u-boot,
we see the ATA "feature byte" return 0x01, which means success.  When
the kernel does the soft reset, we see a 0x00, which means failure.  You
would think it is timing related, but a logic analyzer trace shows
reasonable timing.  We need to wire up a better test rig, so I don't
want folks on this list to waste any time on it.  I'll report back if I
learn anything of general interest.

With the interrupt disabled in the device tree, and ignoring the
diagnostics failure, the drive actually works.  I'm able to mount a
filesystem, read files from it, etc.  So, the drive is fully functional,
just without using interrupts.  Therefore, I believe most everything is
correct - byte lanes, read/write signaling, timing, etc.  Curious.

    Steve


--------------070707030306030709020406
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Benjamin Herrenschmidt wrote:
<blockquote cite="mid:1218492032.8041.11.camel@pasglop" type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">1. IDE status read does not work. (But am I understand correctly
   that IDE works well if IRQ is unspecified? Then this is hardly
   an issue.)
2. IDE interrupt comes when it should not. I'd recommend to use
   oscilloscope to find out what is happening there, that is, if
   the drive actually deasserts its irq line after status read.
   If so, than this could be a PIC problem.

What is the platform on which you're observing the issue, btw?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Another possibility is that you got the wrong interrupt number
in the device-tree...

Ben.
  </pre>
</blockquote>
<br>
<tt>The platform is the AMCC Sequoia board.  We've built a little
adapter to connect a compact flash card to the processor bus.  I
believe the interrupt selection in the device tree is correct, and I've
checked over the u-boot settings for the IRQ line (active high, level
sensitive).  I've also tried edge-sensitive but it doesn't make a
difference.<br>
<br>
When u-boot queries the CF card, we see the IRQ pulse as expected, but
when the kernel runs, we see the IRQ go high and stay there, which the
kernel naturally treats as a stuck interrupt.  The other oddity is that
we see a single diagnostic failure on startup:<br>
<br>
</tt>
<blockquote><tt>ata1.00: Drive reports diagnostics failure. This may
indicate a drive</tt><br>
  <tt>ata1.00: fault or invalid emulation. Contact drive vendor for
information.</tt><br>
</blockquote>
<tt><br>
That is strange, because if we manually do the soft reset from u-boot,
we see the ATA "feature byte" return 0x01, which means success.  When
the kernel does the soft reset, we see a 0x00, which means failure. 
You would think it is timing related, but a logic analyzer trace shows
reasonable timing.  We need to wire up a better test rig, so I don't
want folks on this list to waste any time on it.  I'll report back if I
learn anything of general interest.<br>
<br>
With the interrupt disabled in the device tree, and ignoring the
diagnostics failure, the drive actually works.  I'm able to mount a
filesystem, read files from it, etc.  So, the drive is fully
functional, just without using interrupts.  Therefore, I believe most
everything is correct - byte lanes, read/write signaling, timing, etc. 
Curious.<br>
<br>
    Steve<br>
<br>
</tt>
</body>
</html>

--------------070707030306030709020406--

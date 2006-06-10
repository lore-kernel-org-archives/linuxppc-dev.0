Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 0E06767C89
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 11 Jun 2006 09:38:44 +1000 (EST)
Date: Sun, 11 Jun 2006 01:38:42 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: sleep / wake-up
In-Reply-To: <1149980531.14253.92.camel@mindpipe>
Message-ID: <Pine.LNX.4.60.0606110120270.16586@poirot.grange>
References: <Pine.LNX.4.60.0606102034230.3305@poirot.grange>
	<53107f6e0606101503x4f84cbc0j6f92c601fa464c36@mail.gmail.com>
	<Pine.LNX.4.60.0606110027010.16586@poirot.grange>
	<1149980531.14253.92.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 10 Jun 2006, Lee Revell wrote:

> On Sun, 2006-06-11 at 00:41 +0200, Guennadi Liakhovetski wrote:
> > On Sat, 10 Jun 2006, Jon Scully wrote:
> > 
> > > Also, here's an article (just about 4 days old):
> > > http://www.linux.com/article.pl?sid=06/05/24/1716222
> > > (I thought the subject sounded familiar ;-)
> > 
> > Ok, thanks for both replies. That's a good start already! But this is all 
> > about __software__ suspend. But aren't some other "hardware" suspend-modes 
> > also available on ppc, like suspend-to-RAM? For example, on my system I 
> > could say quite a bit of power by stopping the HD, switching off 
> > USB-ports, eth, and then putting the CPU to sleep? Would all this be 
> > doable by just performing those steps and then clocking the CPU down?
> > 
> 
> Did you read the article?
> 
> "ACPI state S3 -- also know as Suspend-to-RAM -- is the state where
> everything in the system enters a low-power state except for RAM, which
> consumes a small amount of power in order to retain its contents, so
> that upon resuming, everything is loaded back from the memory and all
> running applications are restored immediately."

Yes: "ACPI" - we are talking about a (embedded) PPC... But I thought you 
could "simulate" that without ACPI too. AFAIU, ACPI is the way hardware 
(motherboard / laptop) manufacturers tell you about system's 
configuration, including how to enter S3. In its absence suspending every 
(e.g., embedded) system you have to _know_ the hardware. E.g., what do 
they do on Apple ppc laptops? You don't have ACPI there. Is there any 
generic system there or did they just study every new ppc-mac and handled 
it specially?

> > I must admit, I don't understand the whole idea behind suspending at all. 
> > What happens to all applications that went to sleep for 1 second and wake 
> > up 2 days later? What about all network connections? timeouts? I have to 
> > read some basics...
> 
> It's insanely difficult and complicated.  Every single driver and kernel
> subsystem has to be changed.  Zillions of man-hours have gone into
> getting suspend to work on Linux and it's still not there...

I guess, I really wanted to ask about IO operations in the fly... 
probably, you only use automatic suspend if you know your system is not 
supposed to do any long IO-operations, and "short" ones will be completed? 
Even if you monitor loadavg - it might stay quite low during a long 
transfer. And if you do long IOs you have to decide when it is safe to 
suspend yourself... So that the kernel just has to flush current IO 
queues... Yeah, doesn't sound very easy.

Thanks
Guennadi
---
Guennadi Liakhovetski

Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f18.google.com (mail-gx0-f18.google.com
	[209.85.217.18]) by ozlabs.org (Postfix) with ESMTP id E17CADDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Nov 2008 08:53:48 +1100 (EST)
Received: by gxk11 with SMTP id 11so360617gxk.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 07 Nov 2008 13:53:47 -0800 (PST)
Message-ID: <ed82fe3e0811071346u291fa477s2147affcc0f8ef42@mail.gmail.com>
Date: Fri, 7 Nov 2008 15:46:42 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
In-Reply-To: <OFDAB4AD6D.6B393411-ON882574FA.007560E7-882574FA.007634F1@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ed82fe3e0811070743l1e0f7430o6bbb2b3d5e5a446f@mail.gmail.com>
	<OFDAB4AD6D.6B393411-ON882574FA.007560E7-882574FA.007634F1@selinc.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Nov 7, 2008 at 3:31 PM,  <Bruce_Leonard@selinc.com> wrote:

> I'm not sure if I need something as complicated as sound/soc/fsl/fsl_dma.c
> or not.  Maybe you can offer an opinion.  The NAND flash in our product is
> our backing storage, i.e., our hard drive.  We know that we're going to be
> storing away system status at about a 1 second rate and in the future
> we'll probably end up storing collected data at a very high rate, so we're
> potentially going to be doing a LOT of data movement to the NAND.  I'm
> still not clear on the adma stuff, so I'm not sure if a "single-shot
> one-way transfer" is appropriate or not.  Seems like I'd waste a lot of
> time setting up and tearing down the DMA channel.
>
> So, do I need something complicated?

The Async DMA code is very much like an "offload memcpy".  The Elo
control will handle the memcpy while the host CPU can do something
else.  Keep in mind that while the Elo is transferring data, the
memory bus will be saturated.

Whether or not using async dma is worth the effort can only be
determined by profiling the code.  Either it's better, or it's not.
There's no real way to tell in advance.

The advantage of using async DMA over memcpy is that you don't have to
worry about large memcpy operations blocking the CPU and causing apps
the kernel and apps to stall while your driver is copying data.  So
even if overall performance drops, latency will improve and
the system will appear to be faster.  The drawback is that async dma
is more complicated than plain old memcpy.  Since the dma is
asynchronous, you'll need to register a callback function which gets
notified when the Elo has completed the DMA transfer.  That's a very
different design than memcpy.

-- 
Timur Tabi
Linux kernel developer at Freescale

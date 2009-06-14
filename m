Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82161B715A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 05:37:02 +1000 (EST)
Message-ID: <4A355155.4020500@grandegger.com>
Date: Sun, 14 Jun 2009 21:36:53 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: "Hans J. Koch" <hjk@linutronix.de>
Subject: Re: [PATCH 2/2] uio: add an of_genirq driver
References: <1244765062-14144-1-git-send-email-w.sang@pengutronix.de>	<1244765062-14144-3-git-send-email-w.sang@pengutronix.de>	<20090614122136.GD3639@local>	<20090614171406.GA1010@pengutronix.de>	<20090614183357.GE3639@local>	<20090614190533.GA7387@pengutronix.de>
	<20090614192359.GG3639@local>
In-Reply-To: <20090614192359.GG3639@local>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss@ozlabs.org, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hans J. Koch wrote:
> On Sun, Jun 14, 2009 at 09:05:33PM +0200, Wolfram Sang wrote:
>>> Anyway, 0 is a valid IRQ number, so it cannot be used as "no irq".
>> May I point you to this thread?
>>
>> http://lkml.org/lkml/2005/11/21/221
> 
> Linus is just plain wrong in this 4 year old mail.

See also this related thread.

http://groups.google.com/group/rtc-linux/browse_thread/thread/9816648d5a8a1c9e/9968968188b5ab5a?lnk=gst&q=rx8025#9968968188b5ab5a

> 
>> (The issue comes up once in a while as some archs still use NO_IRQ, some with
>> 0 some with -1)
>>
>>>> 	if (uioinfo->irq == NO_IRQ)
>>>> 		uioinfo->irq = UIO_IRQ_NONE;
>>> Sorry for my ignorance, but what is NO_IRQ? If I do

It's 0 on PowerPC but ARM seems still to use -1.

http://lxr.linux.no/linux+v2.6.30/arch/powerpc/include/asm/irq.h#L29

For x86 it's not defined at all. But as this code is for the PowerPC,
where using NO_IRQ seems still to be OK.

Wolfgang.

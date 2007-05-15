Return-Path: <tnt@246tNt.com>
Received: from outmx028.isp.belgacom.be (outmx028.isp.belgacom.be
	[195.238.5.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 590BBDDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 17:09:52 +1000 (EST)
Received: from outmx028.isp.belgacom.be (localhost [127.0.0.1])
	by outmx028.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4F79hpv003044
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 May 2007 09:09:43 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <46495CB4.8050809@246tNt.com>
Date: Tue, 15 May 2007 09:09:40 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Lorenz Kolb <linuxppcemb@lkmail.de>
Subject: Re: [Fwd: [alsa-devel] embedded sound architecture question]
References: <000101c795e5$0af92ce0$9602a8c0@lorenzulm>
In-Reply-To: <000101c795e5$0af92ce0$9602a8c0@lorenzulm>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi,

>> If I were you, I would chose one of sound cards which have ALSA
>> drivers implemented (the list can be found on ALSA site) and
>> mimicked their behavior in your VHDL.
>>     
>
> Actually a bunch of theses drivers rely on PCI or ISA.
> The few left do all require DMA, what is only an option, if it is some sort
> of faked DMA, so the CPU writes directly into the controller's memory as we
> intend to stay as independent as possible from Xilinx' IP Cores.
> The question was: is that a good (and practicable) idea?
>   

If you can spare the BRAM, that sounds good to me.

I'm not an alsa expert but I'm working on a driver right now. And alsa
provide you a hook so you can allocate your memory buffer your self.
So as long as your control maps it's memory somewhere in the
cpu address space you should be fine.

What you need is :
 - Be able to ask the hardware where is is "read pointer".
 - Be able to ask the hardware to generate an interrupt every 'n' samples.

And that should do it.

You also need to make the controller build the AC97 frames itself
(e.g. for the control slots, a separate set of registers), and also
preferrably
supporting multiple sample format so the CPU needs to do a minimum of
conversion.


        Sylvain

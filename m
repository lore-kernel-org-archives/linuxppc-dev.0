Return-Path: <tnt@246tNt.com>
Received: from mailgate104.isp.belgacom.be (mailgate104.isp.belgacom.be
	[195.238.6.85]) by ozlabs.org (Postfix) with ESMTP id 68C2EDDEFE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 17:10:40 +1000 (EST)
Message-ID: <464AAE9C.9040707@246tNt.com>
Date: Wed, 16 May 2007 09:11:24 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Joachim_F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: [Fwd: [alsa-devel] embedded sound architecture question]
References: <000101c795e5$0af92ce0$9602a8c0@lorenzulm>	<46495CB4.8050809@246tNt.com>
	<1179246479.3587.2.camel@localhost>
In-Reply-To: <1179246479.3587.2.camel@localhost>
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

Joachim Förster wrote:
> Hi Sylvain,
>
> thank you very much for your mail,
>
> On Tue, 2007-05-15 at 09:09 +0200, Sylvain Munaut wrote:
>   
>> I'm not an alsa expert but I'm working on a driver right now. And alsa
>> provide you a hook so you can allocate your memory buffer your self.
>> So as long as your control maps it's memory somewhere in the
>> cpu address space you should be fine.
>>     
>
> By "hook", do you mean the prepare()/hw_params() callbacks?
>   
hw_params and hw_free yes.

I personally use snd_pcm_lib_malloc_pages to allocate the buffer, but
you'll have to write your own, and in the same call back configure the
period rate for you hw to generate interrupt.

> I noticed that there is an (undocumented?) mmap() callback, too, so I
> think, I have to implement that one and call something like
> io_remap_pfn_range() to "connect" the device's memory to the VMA
> (virtual memory area) which is provided as an argument to the mmap()
> callback, right?
>   
Sorry, no idea ... but it's likely that you need to handle the mapping
of this
zone in userspace by yourself ...
> In our case, we are not going to allocate any memory like a typical ALSA
> driver does (with DMA) (in prepare()/hw_params() callback), because the
> device's IO memory will "be there" - we just have to "announce"/map it
> into kernel space, right? Or is this interpretation wrong?
>   
No I think that should work.

You need a quite a few BRAMs though ... buffers are often 128k at the
minimum, so that's 64 brams ....

Sylvain

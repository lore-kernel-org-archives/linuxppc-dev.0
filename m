Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F0A2DDF1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 May 2007 02:35:13 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HnzzK-00045a-DS
	for linuxppc-embedded@ozlabs.org; Tue, 15 May 2007 18:35:02 +0200
Received: from dslb-084-056-171-103.pools.arcor-ip.net ([84.56.171.103])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 May 2007 18:35:02 +0200
Received: from mls.JOFT by dslb-084-056-171-103.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 15 May 2007 18:35:02 +0200
To: linuxppc-embedded@ozlabs.org
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: [Fwd: [alsa-devel] embedded sound architecture question]
Date: Tue, 15 May 2007 18:28:00 +0200
Message-ID: <1179246479.3587.2.camel@localhost>
References: <000101c795e5$0af92ce0$9602a8c0@lorenzulm>
	<46495CB4.8050809@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain
In-Reply-To: <46495CB4.8050809@246tNt.com>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain,

thank you very much for your mail,

On Tue, 2007-05-15 at 09:09 +0200, Sylvain Munaut wrote:
> I'm not an alsa expert but I'm working on a driver right now. And alsa
> provide you a hook so you can allocate your memory buffer your self.
> So as long as your control maps it's memory somewhere in the
> cpu address space you should be fine.

By "hook", do you mean the prepare()/hw_params() callbacks?

I noticed that there is an (undocumented?) mmap() callback, too, so I
think, I have to implement that one and call something like
io_remap_pfn_range() to "connect" the device's memory to the VMA
(virtual memory area) which is provided as an argument to the mmap()
callback, right?

In our case, we are not going to allocate any memory like a typical ALSA
driver does (with DMA) (in prepare()/hw_params() callback), because the
device's IO memory will "be there" - we just have to "announce"/map it
into kernel space, right? Or is this interpretation wrong?

 Joachim

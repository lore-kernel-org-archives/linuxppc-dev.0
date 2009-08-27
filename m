Return-Path: <wim@iguana.be>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3CB5EB7C49
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 06:27:13 +1000 (EST)
Received: from mailrelay004.isp.belgacom.be (mailrelay004.isp.belgacom.be
	[195.238.6.170]) by ozlabs.org (Postfix) with ESMTP id 81E8EDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 06:27:12 +1000 (EST)
Date: Thu, 27 Aug 2009 22:27:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] fix book E watchdog to take WDIOC_SETTIMEOUT arg in
	seconds
Message-ID: <20090827202709.GK29382@infomag.iguana.be>
References: <4A8303C6.7070705@nortel.com>
	<20090827111458.GB29382@infomag.iguana.be>
	<20090827120841.GA25303@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090827120841.GA25303@zod.rchland.ibm.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Josh,

> >Now we only need someone that can look at the CONFIG_4xx cases still :-)
> 
> It seems the FSL watchdog is much more flexible than the one found in 4xx
> cores.  On 4xx, you basically have 4 static choices that represent specific
> times determined by the clock frequency.  I'm concerned that the lack of
> granularity here will result in less than desirable behavior.
> 
> For example, with a 400MHz clock you would get choices of roughly:
> 
> 5.2 ms
> 83.9 ms
> 1.34 s
> 21.47 s
> 
> Personally, I consider the first two options basically unusable.  Considering
> the second two, if a user were to say "Set the timeout for 2 seconds" they
> would then get a timeout of 21 seconds with the framework Chris' patch has
> set up.  That doesn't really seem to be ideal to me.

Hmm, my opinion: in that case we should use a timer that triggers the watchdog until userspaces times out (like we do for other watchdogs allready). Maybe we should split this driver. I have the same issue with the Freescale i.mx driver that is under review also.

Kind regards,
Wim.

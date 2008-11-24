Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C59BDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 07:16:26 +1100 (EST)
Message-ID: <492B0B96.5050009@freescale.com>
Date: Mon, 24 Nov 2008 14:16:22 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Async DMA question regarding dma_async_memcpy_buf_to_buf
References: <OFDA95F0F0.C47AEAA0-ON8825750B.006E5AC8-8825750B.006EC783@selinc.com>
In-Reply-To: <OFDA95F0F0.C47AEAA0-ON8825750B.006E5AC8-8825750B.006EC783@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Bruce_Leonard@selinc.com wrote:
> Yes, I understand the directions and what they apply to, that's obvious 
> from the macros themselves.  What I don't understand is if it's safe, from 
> a kernel/cache standpoint, to pass to the function a src pointer coming 
> _from_ the device and a dest pointer that's going _to_ the device?  In 
> other words, can I use this function to _write_ to a DMA slave?  If not, 
> there's a functionality missing from the async DMA engine.

What exactly do you mean by "the device"?  if it's the DMA engine, then 
that's a meaningless request, by the definition of "source" and 
"destination".  If you mean some other device that happens to be 
providing a buffer for you to DMA into or out of, that's irrelevant to 
the DMA API; it's just memory that happens to live somewhere else (and 
possibly not be cached).

-Scott

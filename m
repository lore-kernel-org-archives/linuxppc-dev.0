Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52]) by ozlabs.org (Postfix) with ESMTP id 5684167A73
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 06:11:09 +1100 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j23JAtjm015211
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Mar 2005 20:10:56 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <42276154.7030109@246tNt.com>
Date: Thu, 03 Mar 2005 20:11:16 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Babarovic Ivica <ivica@asist-traffic.com>
References: <42270DCE.8060703@asist-traffic.com> <20050303165955.GA20533@xyzzy>
	<42275320.6000302@asist-traffic.com>
In-Reply-To: <42275320.6000302@asist-traffic.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: FEC_IEVENT_RFIFO_ERROR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

>
> I tried the patch you've sent and It's still the same.
> FEC_IEVENT_RFIFO_ERROR is still here.
> Can you/anyone think of something that I could do to make
> analyzing this problem easier?
>
Resetting the FEC early is a good thing so that patch should be there 
anyway, so we don't setup irq handlers for a hardware in unknow state.

However looking at fec code, there is another problem with it : The FEC 
is enabled in probe, once for all but the DMA tasks that should empty
the buffers are only enabled when the interface is up, so during it's 
down time, any received packed ends up in filling the FIFO ...

This problem goes away when the interface is up tough, so you should not 
experience 'crash' ... Do you nfs boot ? Try with a static image, just
to see, maybe having the error at boot screw something. If it doesn't 
boot with a static image then there is still another problem.


    Sylvain

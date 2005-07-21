Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6B5B367CB9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jul 2005 23:18:12 +1000 (EST)
Date: Thu, 21 Jul 2005 06:18:09 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Nick Hennenfent <nhennenfent@egtinc.com>
Message-ID: <20050721131809.GA13216@gate.ebshome.net>
References: <A3008858EC44C34382A7E3935C24615E01074D3B@egtf001.egt.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A3008858EC44C34382A7E3935C24615E01074D3B@egtf001.egt.intra>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: I need help with L2 cache on 440GX rev C
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 21, 2005 at 08:44:46AM -0400, Nick Hennenfent wrote:
> 
> I have an embedded 440GX rev C runnng at about 500Mhz.
> I am using a 2.4.20 linux kernel.
> I borrowed Matt Porter's code from the 2.6 kernels in
> order to enable the L2 cache. The code compiles and
> runs ok, but the cache does not seem to be enabled!!!
> I ran some tests with/without the L2 cache code and 
> there is no difference.
> (A qsort of 1 million random integers takes 2 seconds).
> Is there some other magic trick to enable that cache????

No, there is no magic involved. 2.6 code (ibm440gx_l2c_enable()) 
works just fine.

Make sure your firmware doesn't enable L2C itself, in this case kernel 
enable code isn't needed at all, and you won't see any difference if 
you remove it.

2.6 has /proc/cpuinfo has a 440GX-specific handler 
(ibm440gx_show_cpuinfo()), you can put something similar into your 2.4 
kernel to see actual L2C state.

-- 
Eugene

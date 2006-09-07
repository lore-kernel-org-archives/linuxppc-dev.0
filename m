Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B36567B6E
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 10:53:55 +1000 (EST)
Subject: Re: [Fwd: Re: ohci1394: steps to implement suspend/resume]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <44FEDF5D.9060707@s5r6.in-berlin.de>
References: <44FEDF5D.9060707@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 10:53:36 +1000
Message-Id: <1157590416.22705.269.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux1394-devel@lists.sourceforge.net,
	Bernhard Kaindl <bk@fsfe.org>, Pavel Machek <pavel@ucw.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-09-06 at 16:46 +0200, Stefan Richter wrote:
> Hello LinuxPPC-dev,
> 
> we have now patches coming in to fix up the lack of generic suspend +
> resume support in drivers/ieee1394/ohci1394. Attached is the latest and
> by far most functional one by Bernhard Kaindl. A big question is how
> this relates to the already existing PPC-PMAC platform code in
> ohci1394's suspend and resume hooks.
> 
>  - Which functionalities does the existing platform code provide in
>    detail?
> 
>  - Do we have to keep platform code and generic code separate? I.e.
> #ifdef CONFIG_PPC_PMAC
> 	...pmac_call_feature...
> #else
> 	...new generic code...
> #endif
> 
>  - Or are parts of the until now missing, new generic code necessary
>    for PMacs too? If yes, is the platform code treated to be the lowest
>    level as far as the oreder of code is concerned?
> 
>  - Or would the platform code be obsolete?
> 
> We already broke your platform code once by what was meant as a bugfix
> for non-PMacs. It'd be good to know enough to not repeat such mistakes...

The PowerMac code will stop the chip clocks. It should be used as the
last step of the suspend sequence and first step of the return sequence,
in _addition_ to your new code. Note also that the code you posted lacks
calls to pci_set_power_state()...

Ben.

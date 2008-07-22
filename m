Return-Path: <gvb.linuxppc.dev@gmail.com>
Received: from QMTA04.westchester.pa.mail.comcast.net
	(qmta04.westchester.pa.mail.comcast.net [76.96.62.40])
	by ozlabs.org (Postfix) with ESMTP id 437EADDDF5
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 13:00:43 +1000 (EST)
Message-ID: <48854C02.7000307@gmail.com>
Date: Mon, 21 Jul 2008 22:54:58 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Mikrotik RouterBoard 333
References: <20080708042631.GB7328@yookeroo.seuss>
	<20080709040925.GA13810@secretlab.ca> <487AA17E.6000808@gmail.com>
	<20080721211344.GA13268@loki.buserror.net>
In-Reply-To: <20080721211344.GA13268@loki.buserror.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Sun, Jul 13, 2008 at 08:44:46PM -0400, Jerry Van Baren wrote:
>> I'm a half-ack.  ;-)  I'm partial to u-boot's implementation rather than  
>> using a bootwrapper for obvious reasons.  The u-boot implementation  
>> takes the blob as a boot parameter and passes it along to the kernel  
>> after doing appropriate (optional) fixups.
> 
> And if those fixups expect a malformed device tree?

Oops, very bad choice of terms on my part.  :-(  The fixups I referred 
to are mostly "fill in the blank" things like setting the various 
clocks, MAC information, PCI information, etc. to the correct values 
based on hardware probing or a priori knowledge.  U-boot does not 
(should not / will not!) fix broken device trees.  A broken tree w/ the 
u-boot methodology is fixed by loading a corrected one, not requiring a 
full rebuild and reload of the firmware.

Note that the blobs are (should be) made from the *.dts files that are 
part of the linux kernel source, so having correct ones has not been a 
problem.  Since replacement ones are easily loaded, broken blobs are 
fixed by replacement, not by contorted fixups a'la the start of this 
thread.  Since blobs are well defined, even if some boneheaded company 
didn't release their blob source, it is trivial to dump it (e.g. "fdt 
print /"), fixed, and then replaced.

>> Other than that quibble, I agree that burning the blob into the firmware  
>> so that the firmware must be recompiled and reburned to change the blob  
>> is very undesirable.
> 
> I thought the device tree was *supposed* to be an interface between the
> firmware and the kernel?  What if the firmware produces the tree
> dynamically?  What if the firmware itself depends on having the device tree
> in order to operate?
> 
> -Scott

Well, yes and no on dynamically generated blobs.  There isn't much point 
"dynamically" generating the static parts of the blob - if you have 
static code "dynamically" generating the static parts of the blob, is it 
dynamic or static?  That is probably exactly where Mikrotik has 
problems.  The truly dynamic parts are a small part of the blob.

If all else fails, u-boot is GPLed and the user is able to get the 
source and fix it (well, at least for 3 years after purchasing the 
hardware).

There are advantages and disadvantages to u-boot and boot-wrapper 
methods.  There are nothing but disadvantages to having the blob 
physically a part of the firmware (with a double whammy if the firmware 
source is not readily available).

Best regards,
gvb

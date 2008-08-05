Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25555DE21C
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 07:19:36 +1000 (EST)
Message-ID: <4898C3F0.8060305@freescale.com>
Date: Tue, 05 Aug 2008 16:19:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH add immr alias 2/4] powerpc: 5121: Add immr alias to
	MPC5121 ADS device tree.
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>	
	<1217967220-30557-2-git-send-email-jrigby@freescale.com>	
	<fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>	
	<4898C15E.3000900@freescale.com>
	<fa686aa40808051412od699a57x59079bc59fb7150@mail.gmail.com>
In-Reply-To: <fa686aa40808051412od699a57x59079bc59fb7150@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> But finding nodes that meet a criteria *is* what compatible is for and
> there is precedence for it.  All u-boot platforms are finding the node
> by path right now, and so all of them need to be changed.  Changing
> them to find by compatible that is set per-board or per-SoC makes
> complete sense to me.

It is ridiculous to have to duplicate code (or create a table, or 
whatever) just so it can search for mpc8536-foo, mpc8544-foo, 
mpc8548-foo, etc -- and in the case of the SoC, it's *not* fully 
compatible, so we *can't* pick one as the "default" -- but it's 
compatible for the purposes of the code in question.

I figured an alias would attract fewer flames than a compatible of 
"fsl,immr" (though I'm fine with it -- it's specifying compatibility of 
device tree binding, not of the hardware).

And no, they're not all finding it by path now -- there's a lot of use 
of device_type "soc", which is what we're trying to avoid by introducing 
this alias.  The bootwrapper is also affected.

-Scott

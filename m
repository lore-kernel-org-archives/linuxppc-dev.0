Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0AFF67BD2
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 07:52:39 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0612081718380.14619@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0612081718380.14619@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BD193285-AC82-4DDA-B37D-F82E003D3DEC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.20] Changed gianfar device tree definition to make it
	more flexible
Date: Tue, 12 Dec 2006 14:52:23 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2006, at 5:20 PM, Andy Fleming wrote:

> The old gianfar node definition used a concept of "models" to
> determine the feature bits and interrupt settings to pass to the
> driver.  This won't scale well when the hardware designers come
> up with new and (hopefully) interesting variants of the eTSEC.
> So one goal of this patch is to prepare for that eventuality by
> listing the features, rather than inferring them.
>
> And then, incidentally, some of the code was cleaned up so that
> initialization functions will skip devices which encounter
> errors, rather than bailing.  The CPM devices were not modified
> in this way, as they are more complex.
>
> Finally, all the dts files with gianfar nodes were updated to use
> the new feature bits and the new interface field, and the various
> MAC address conventions were all accommodated by preserving the
> currently-used field, while adding local-mac-address, which will
> be used in the future (once u-boot changes have been made).  The
> parsing code was also changed so that it will find a mac address
> that has actually been set to something, rather than defaulting
> to the first, possibly zeroed, mac address.

Nack, in its current form.  You are breaking people who can't modify  
their dts/dtb.  I'd suggest removing model all together since that is  
the effect you want to have and make the parsing code such that if  
model is set it does the old style, and if its not you do the new style.

Also, how does these feature bits effect arch/ppc platform support?

- k

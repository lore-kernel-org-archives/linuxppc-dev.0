Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B093DDF43
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 02:10:28 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A184@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A184@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6DBBC73A-F5BD-4FB8-BD90-9D9C4E9FC703@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Endianness versus too many byte swaps??
Date: Mon, 5 Mar 2007 09:09:30 -0600
To: "Charles Krinke" <ckrinke@istor.com>
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


On Mar 5, 2007, at 9:02 AM, Charles Krinke wrote:

>
>
> You do understand that readl is in fact a call to in_le32() on ppc
> (cf. include/asm-ppc/io.h).
>
> The question now is, what endianness you would like in that register?
>
> Regards
> --  
> Stephane
>
> Dear Stephane:
>
> Your point is well made. I can see that readl is in fact a call to
> in_le32. Maybe there is a more basic problem here.
>
> If I change the call to readl to a call to in_be32, things make sense
> again. So, maybe I don't quite understand the endianness setup of this
> Linux project.

readl/writel are for PCI bus accesses.  PCI is inherently little endian.

> I am told that we are running this ppc in big endian, so would this  
> mean
> that readl & writel should actually be resolving to in_be32/out_be32
> respectively? Is there some other setup that may be wrong?

Nope, readl/writel are doing the write thing, they will ALWAYS be  
little endian.

You truly want in_be*/out_be* when accessing 85xx CCSR registers  
since all of them are big endian.

- k

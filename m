Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C4FBDDD02
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 03:10:05 +1100 (EST)
In-Reply-To: <20070314155900.GA10075@ld0162-tx32.am.freescale.net>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<17911.31029.598986.827186@cargo.ozlabs.ibm.com>
	<20070314155900.GA10075@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D951C3CB-F606-455B-B048-6C03D06BDD7D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Date: Wed, 14 Mar 2007 11:08:57 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 14, 2007, at 10:59 AM, Scott Wood wrote:

> On Wed, Mar 14, 2007 at 03:25:25PM +1100, Paul Mackerras wrote:
>> Hmmm... is ppcboot.h a direct copy of a file from somewhere else
>> (e.g. uboot), or did you construct it?  It has an *awful* lot of
>> ifdefs.  If it is a direct copy from uboot, I can see an argument for
>> keeping it as-is, but if not, I think we can come up with a better  
>> way
>> to structure things.
>
> It's copied from asm-ppc/ppcboot.h, which was presumably copied from
> u-boot/ppcboot at some point.  It's certainly ugly, but changing it  
> would
> break compatibility (thus negating the point of cuImage).

I think David's idea about having a <board>.c file that does stuff  
and knows about what the bd_t should look like for that board makes  
sense.

For example, the majority of 83xx boards don't need cuImage support  
(at least I don't think they do) since they only ever existed in arch/ 
powerpc.

- k

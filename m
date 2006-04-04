Return-Path: <michaelellerman@internode.on.net>
Received: from mail.internode.on.net (bld-mail01.adl2.internode.on.net
	[203.16.214.65]) by ozlabs.org (Postfix) with ESMTP id F26DD67B16
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 15:41:13 +1000 (EST)
Subject: Re: _machine removal breaks kexec?
From: Michael Ellerman <michaelellerman@internode.on.net>
To: Haren Myneni <haren@us.ibm.com>
In-Reply-To: <44316705.1040202@us.ibm.com>
References: <20060403014044.GA4704@krispykreme>
	<1144080994.4449.10.camel@localhost.localdomain>
	<1078253E-4B9E-4432-86E3-82B01A4B68D1@kernel.crashing.org>
	<44316705.1040202@us.ibm.com>
Content-Type: text/plain
Date: Tue, 04 Apr 2006 07:40:48 +0200
Message-Id: <1144129248.29756.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-04-03 at 11:18 -0700, Haren Myneni wrote:
> Basically, kexec-tools looks the platform property to determine whether 
> to read tce-base, tce-size and htab-* properties. The attached patch 
> find out the platform info based on /proc/device-tree/chosen/htab-base 
> property. Not tested yet.

Why don't we get rid of the platform variable entirely in kexec-ppc64.c,
if the tce-* and htab-* properties are there, then we read them, if not
we don't.

There's also:

if (platform == PLATFORM_PSERIES) {
        if (rmo_top > 0x30000000UL)
                rmo_top = 0x30000000UL;
}

I'm not sure where that number comes from, perhaps we need to export the
RMO value like we do for the htab?

While we're there that code could use a function to read
a /proc/device-tree file and do error handling, there's a lot of
duplicate code at the moment.

cheers

-- 
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

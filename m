Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 628AD2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 07:28:31 +1000 (EST)
Message-ID: <5011B673.4030802@freescale.com>
Date: Thu, 26 Jul 2012 16:28:19 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [2/3][PATCH][upstream] TDM Framework
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
 <500EB47F.1040903@freescale.com> <1343173422.2218.2.camel@concordia>
 <500F5C99.6060704@freescale.com> <1343193511.2218.10.camel@concordia>
In-Reply-To: <1343193511.2218.10.camel@concordia>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Singh Sandeep-B37400 <B37400@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> And the bible, K & R, includes an example of an enum which explicitly
> specifies all its values. It goes on to say "enumeration variables offer
> the chance of [type] checking and so are often better than #defines".

I don't want to beat a dead horse here, but if the driver doesn't do enum
type checking, then it's hard to justify using an enum.  Now you said,
"Yes, if you're going to define an enum you should use it, which this
patch doesn't, but that's just a bug in this patch."  It could be argued
that there's no real place to incorporate enum type checking in this code.

IMHO, this is pointless:

enum mytype {
	VALUE1 = 0x10,
	VALUE2 = 0x20
};
	

int func(void)
{
	if (some-condition)
		return VALUE1;
	else
		return VALUE2;
}

> And the bible, K & R, includes an example of an enum which explicitly
> specifies all its values.

First, K&R is pretty old, and there are a lot of style issues in it that
are no longer in favor.  I don't think anyone would advocate this:

int func(x, y)
int x;
int y;
{
	...
}

Secondly, one of the benefits of an enum (which again, is not actually
being used in this patch), is to be able to specify multiple constants
that are given unique values, but you don't actually care what the values
are, like this:

enum radeon_family {
	CHIP_FAMILY_UNKNOW,
	CHIP_FAMILY_LEGACY,
	CHIP_FAMILY_RADEON,
	CHIP_FAMILY_RV100,
	CHIP_FAMILY_RS100,    /* U1 (IGP320M) or A3 (IGP320)*/
	CHIP_FAMILY_RV200,
	...
};

The code will still work if I swap CHIP_FAMILY_RV100 with
CHIP_FAMILY_RS100.  As long as each value is unique, everything works.

-- 
Timur Tabi
Linux kernel developer at Freescale

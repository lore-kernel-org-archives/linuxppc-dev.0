Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.131.36]) by ozlabs.org (Postfix) with ESMTP id B6A7D2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Jan 2005 01:04:32 +1100 (EST)
Message-ID: <003c01c4f19d$98a16510$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Sylvain Munaut" <tnt@246tNt.com>
References: <200412301246.48870.david.jander@protonic.nl>	<C6D7331E-5A77-11D9-AECD-003065F9B7DC@embeddededge.com>
	<061001c4eeaf$0b5e1860$0301a8c0@chuck2>
	<41D7269E.1070906@246tNt.com>
Date: Mon, 3 Jan 2005 09:07:39 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 PCI byte-swapping
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> Mark Chambers wrote:
> 
> >I've just realized that the 5200 does byte-lane swapping
> >on all PCI accesses.  That is, if you write a 32 bit word
> >0x12345678, 0x12 will go out on byte 0, 0x34 on byte 1,
> >etc.  Unfortunately, my target, a T.I. DM642, does not
> >do this, so I've got a big/little endian mismatch.  A couple
> >of questions if anybody knows:
> >
Sylvain wrote:

> I'm not sure of what you mean but look at the mapping
> aroung pdf page 337 of the user manual. It's not configurable
> as far as I can see.
> 

Thanks.  I had an older manual that didn't spell it out so
clearly.

I've been trying to interpret the PCI sections for some other
82xx family parts, and it appears that they do NOT do this
byte lane swapping, so this make the 5200 non-standard in
this regard, which is unfortunate.  If I'm understanding this
right, one would have to have different drivers for a PCI
device on a 5200 and an 8270, for instance.

Also, I note that when doing simple block reads from pre-
fetchable PCI space, it appears the 5200 does not prefetch,
but does each read individually.  This is using stock ELDK
u-boot and 2.4.24 so I haven't yet determined if it's a
configuration matter, (or ruled out target disconnects)
but I'm suspecting that you can't get burst mode from the 
5200 without using DMA.

Mark Chambers

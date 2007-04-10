Return-Path: <MBenedict@twacs.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1EAAFDDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 00:06:53 +1000 (EST)
Received: from outbound3-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound3-blu-R.bigfish.com (Postfix) with ESMTP id AD64DAA948E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 14:06:50 +0000 (UTC)
Received: from mail144-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound3-blu.bigfish.com (Postfix) with ESMTP id A213784004C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 14:06:50 +0000 (UTC)
Received: from mail144-blu (localhost.localdomain [127.0.0.1])
	by mail144-blu-R.bigfish.com (Postfix) with ESMTP id B87AC1A482BE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 14:06:49 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail144-blu.bigfish.com (Postfix) with ESMTP id 3CB84CB8084
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Apr 2007 14:06:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC 8349e-mITX and MTD/Flash
Date: Tue, 10 Apr 2007 09:06:28 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC2795D2@twx-exch01.twacs.local>
In-Reply-To: <572211.38645.qm@web306.biz.mail.mud.yahoo.com>
References: <CF7E46FCFF66AD478BB72724345289EC2795D1@twx-exch01.twacs.local>
	<572211.38645.qm@web306.biz.mail.mud.yahoo.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
To: "Ben Warren" <bwarren@qstreams.com>
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

Ben,
	I assume that you intended to CC the list but accidently hit
"reply" instead.  If not, I apologize.  Thank you for all your help so
far.

>-----Original Message-----
>From: Ben Warren [mailto:bwarren@qstreams.com]=20
>Sent: Monday, April 09, 2007 4:30 PM
>To: Benedict, Michael
>Subject: Re: MPC 8349e-mITX and MTD/Flash
>
>I suspect that MTD doesn't know anything about how
>your flash chip is organized.  Probably the easiest
>thing to use is CONFIG_MTD_PHYSMAP.  Using this, you
>can either pass the MTD partitioning info via kernel
>command line, via static physmap structures in your
>board code or, I believe, via device tree (I haven't
>tried the last one).

The following is from my .config
<snip>
#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=3Dy
CONFIG_MTD_PHYSMAP_START=3D0x8000000
CONFIG_MTD_PHYSMAP_LEN=3D0x0
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D2
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_PLATRAM=3Dy
<snip>

Is this what you are referring to?  Does something look obviously wrong
with it?  I have taken that configuration from Freescale's reference
.config that came with the platform.  I am using the latest kernel.org
flat device tree for my platform, but the flash is not configured there.

After reading a little more, I suppose I am not expecting any
partitions, but I would still think I should be able to `mtd_debug info`
the block and char devices.  When I try, I get "No such device or
address" errors.  Also, I would still expect something in my /proc/mtd,
correct?  Any ideas are greatly appreciated.
	Thank you again,
		Michael

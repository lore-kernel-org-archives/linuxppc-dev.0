Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id B3B7BDDF41
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 23:21:20 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ju63f-0002o3-8W
	for linuxppc-dev@ozlabs.org; Thu, 08 May 2008 13:21:15 +0000
Received: from p5497da3c.dip.t-dialin.net ([84.151.218.60])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 08 May 2008 13:21:15 +0000
Received: from dzu by p5497da3c.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 08 May 2008 13:21:15 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: jffs2 and unaligned access
Date: Thu, 08 May 2008 15:19:50 +0200
Message-ID: <m2tzh9rkzt.fsf@ohwell.denx.de>
References: <20080507102724.GE4326@pengutronix.de>
	<1210157630.25560.884.camel@pmac.infradead.org>
	<9146b2e7fde34e912d20e6ea954bb067@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Cc: linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

>>> memcpy_from/to_io() use word aligned accesses on the io side of
>>> memory.
>>> The MPC5200 local plus bus where our flashes are connected does not
>>> allow unaligned accesses, so we have to use the io versions of memcpy.
>>
>> But this region of flash is marked as suitable for execute-in-place,
>> otherwise the point() function wouldn't be working to give a direct
>> pointer to it. It sounds like we shouldn't be allowing that.
>>
>> Which in turn means that perhaps we should have a property in the
>> corresponding node in the device-tree which indicates that it's not
>> suitable for direct access?
>
> This isn't usually a property of the flash device, but of the various
> buses/controllers above the flash device.  

I wholeheartedly agree.  After all, its the Local+ bus playing games
here.  And fixing that for JFFS2 only ignores that other devices can
*and will* be connected on this bus.  Unaligned accesses to such devices
will also fail (likely from mtd unrelated code) - and fail silently,
taking quite a while to figure out what is going wrong where.

> The device tree should mimic reality (and it does, it just seems the
> kernel doesn't use this information yet?)

How is this exactly supposed to work?

Cheers
  Detlev

-- 
In the topologic hell the beer is packed in Klein's bottles.
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de

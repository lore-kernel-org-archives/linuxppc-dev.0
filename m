Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B958CB6EE9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2011 09:26:57 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0JMHof5019725
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 17:17:57 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E253C72805B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 17:26:53 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0JMQniK1552604
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 17:26:53 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0JMQmDP023144
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 20:26:49 -0200
Date: Wed, 19 Jan 2011 14:26:46 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.37-git17 virtual IO boot failure
Message-ID: <20110119222646.GB19903@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com>
	<20110119004824.GA20441@us.ibm.com>
	<1295417178.2148.131.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295417178.2148.131.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, sonnyrao@us.ibm.com,
	Anton Blanchard <anton@samba.org>, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.01.2011 [17:06:18 +1100], Benjamin Herrenschmidt wrote:
> On Tue, 2011-01-18 at 16:48 -0800, Nishanth Aravamudan wrote:
> > 
> > Ben, if you're ok with waiting to see if Milton or Sonny have any
> > ideas,
> > I'd like to hold off on asking for a revert. In the case they do, I'll
> > be able to test and send out any proposed fix rapidly. 
> 
> I don't believe this specific error is causing the lockup, I think we
> only hit a spurrious message on devices that don't have DMA
> capabilities in the first place. (But I may be wrong, I'll wait for
> you guys to dig more or I'll have a look myself tomorrow if I manage
> to get out of meetings).

Yes, this seems accurate. Like I mentioned elsewhere, this box came up
ok even with these messages and seemed ok (up until the disk locked up).

> So there's another problem with SCSI tho it -could- also be a DMA issue,
> hard to tell at this point.

Right, I'm not sure how to determine that. I did see the lockup, though,
with both my patches reverted (the patches for vio, I mean, after
2.6.37)

> BTW. I'm not too happy with those defaults set to 64-bit. Probably not
> an issue until your other patches go in, but some devices like veth
> cannot do 64-bit DMA. I think we should default to 32-bit in the VIO
> base code and explicitely enable 64-bit DMA from drivers that support it
> (in theory vscsi but I haven't verified the implementation).

Ok, so change the bit-mask to 32-bit? Or would it be appropriate to
attempt 64-bit, if it fails fallback to 32-bit? Seems to be a common
pattern throughout the DMA bit-setting callers.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center

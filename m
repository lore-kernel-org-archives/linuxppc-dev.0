Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E7B8B7088
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2011 17:06:28 +1100 (EST)
Subject: Re: 2.6.37-git17 virtual IO boot failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <20110119004824.GA20441@us.ibm.com>
References: <20110118123152.50f75a72@kryten>
	<20110118224718.GA19039@us.ibm.com> <20110119004824.GA20441@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Jan 2011 17:06:18 +1100
Message-ID: <1295417178.2148.131.camel@pasglop>
Mime-Version: 1.0
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

On Tue, 2011-01-18 at 16:48 -0800, Nishanth Aravamudan wrote:
> 
> Ben, if you're ok with waiting to see if Milton or Sonny have any
> ideas,
> I'd like to hold off on asking for a revert. In the case they do, I'll
> be able to test and send out any proposed fix rapidly. 

I don't believe this specific error is causing the lockup, I think we
only hit a spurrious message on devices that don't have DMA capabilities
in the first place. (But I may be wrong, I'll wait for you guys to dig
more or I'll have a look myself tomorrow if I manage to get out of
meetings).

So there's another problem with SCSI tho it -could- also be a DMA issue,
hard to tell at this point.

BTW. I'm not too happy with those defaults set to 64-bit. Probably not
an issue until your other patches go in, but some devices like veth
cannot do 64-bit DMA. I think we should default to 32-bit in the VIO
base code and explicitely enable 64-bit DMA from drivers that support it
(in theory vscsi but I haven't verified the implementation).

Cheers,
Ben.

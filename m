Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2430DDF8E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 06:52:19 +1000 (EST)
Message-ID: <4713D35A.9080200@genesi-usa.com>
Date: Mon, 15 Oct 2007 21:53:46 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>	
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>	
	<4713551B.9040103@genesi-usa.com>
	<fa686aa40710150704j15f3a511rf5924573282c966b@mail.gmail.com>
In-Reply-To: <fa686aa40710150704j15f3a511rf5924573282c966b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On 10/15/07, Matt Sealey <matt@genesi-usa.com> wrote:
>> My nits:
>>
>> Grant Likely wrote:
>>> From: Sylvain Munaut <tnt@246tNt.com>
>>> +static int __devinit
>>> +bcom_engine_init(void)
>> Why "bcom" and not "bestcomm"?
> 
> I can type 'bcom' twice as fast.  :-)  bcom is a suitable shortening;
> I'm not concerned about it.

I hate acronyms and shortening for the sake of it.

My IDE highlights known symbols from includes and lets me tab complete them :D

After all once all these APIs are fixed and most of the drivers are implemented
(most of them are, already, anyway, and have been from TaskSomething to sdma_
to bcom_ changes and major API reworks), I wonder why we have to constantly
cut every function definition down to 4 characters rhp_bjz_ywh_moo_purr()

I'd level the same thing at bcom_eng (what's an Eng when it's at home? English?
Engraved? Surely Engine but.. come on :)

There's no real good need to shorten the names of things except when those
shortenings are also used in the documentation - after all, PSC is what Freescale
call a PSC, we wouldn't be making structures called mpc52xx_programmable_serial_controller,
that's redundant, I don't think calling it "bestcomm" (which is it's name) over
"bcom" (which isn't) works to anyone's advantage here.

>>> +     /* Disable COMM Bus Prefetch, apparently it's not reliable yet */
>>> +     /* FIXME: This should be done on 5200 and not 5200B ... */
>>> +     out_be16(&bcom_eng->regs->PtdCntrl, in_be16(&bcom_eng->regs->PtdCntrl) | 1);
>> This really, really shouldn't even be here, could it be moved to a platform
>> init, or switched on a PVR/SVR here?
> 
> I think I'd like to leave it here for getting this series merged; it
> may not be good to have it here; but it's not dangerous either.  I'm
> trying to keep churn on this series down to a minimum.

Why not just accept the churn, and remove those two lines, and someone will
submit a patch to make it work on the 5200 in the appropriate place later?

I don't think "mainlining it" is a good excuse to leave FIXME comments
and little device-specific hacks in drivers.

> Please submit a patch to make this change once it's merged.

I'd rather submit a patch containing this fix somewhere else, without having
to touch this driver ever again.

My opinion is that this is a firmware thing, u-boot or openfirmware should
be configuring the system on boot so that they do not do crazy things like
enable the BTIC on a 7447, or leave comm bus prefetch turned on with a 5200 -
in the absense of good firmware, platform support should be used.

This is what Segher tells me we should be doing, but I see you guys "breaking
the rules" all the time.. it makes it hard to justify doing any Linux platform
support if we are beaten with the stick while you guys munch on the carrots..

So, I don't think "reducing churn" justifies leaving it in. Users of 5200
devices who need that fix, can patch their kernels.. users of 5200B and
5121E who do not need that fix, shouldn't be forced to.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Return-Path: <tnt@blacksnow.net>
Received: from leia.blacksnow.net (leia.blacksnow.net [213.251.174.139])
	by ozlabs.org (Postfix) with ESMTP id D9ED0DDEBF
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 00:22:17 +1000 (EST)
Message-ID: <57482.81.241.253.231.1192540877.squirrel@www.opensources.be>
In-Reply-To: <fa686aa40710150704j15f3a511rf5924573282c966b@mail.gmail.com>
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
	<4713551B.9040103@genesi-usa.com>
	<fa686aa40710150704j15f3a511rf5924573282c966b@mail.gmail.com>
Date: Tue, 16 Oct 2007 15:21:17 +0200 (CEST)
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
From: tnt@blacksnow.net
To: "Grant Likely" <grant.likely@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On 10/15/07, Matt Sealey <matt@genesi-usa.com> wrote:
>>
>> My nits:
>>
>> Grant Likely wrote:
>> > From: Sylvain Munaut <tnt@246tNt.com>
>> > +static int __devinit
>> > +bcom_engine_init(void)
>>
>> Why "bcom" and not "bestcomm"?
>
> I can type 'bcom' twice as fast.  :-)  bcom is a suitable shortening;
> I'm not concerned about it.

I prefer bcom as well. Much shorter and there is no ambiguity.
If you use theses, you are writing a 5200 driver. In that context you
should be able to figure out what 'bcom' stands for ... (and if not, maybe
you shouldn't be using them ;)


>> > +     /* Disable COMM Bus Prefetch, apparently it's not reliable yet
>> */
>> > +     /* FIXME: This should be done on 5200 and not 5200B ... */
>> > +     out_be16(&bcom_eng->regs->PtdCntrl,
>> in_be16(&bcom_eng->regs->PtdCntrl) | 1);
>>
>> This really, really shouldn't even be here, could it be moved to a
>> platform
>> init, or switched on a PVR/SVR here?
>
> I think I'd like to leave it here for getting this series merged; it
> may not be good to have it here; but it's not dangerous either.  I'm
> trying to keep churn on this series down to a minimum.
>
> Please submit a patch to make this change once it's merged.

Mmmm.
I think it _does_ belong here. COMM bus prefetch _is_ a bestcomm engine
option.

But indeed as the comment says, it maybe should be enabled on 5200B.
Not a big concern for me at the moment tough.



   Sylvain

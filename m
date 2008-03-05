Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B6B14DE058
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 04:48:23 +1100 (EST)
Message-ID: <47CEDC6F.6060205@ru.mvista.com>
Date: Wed, 05 Mar 2008 20:46:23 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [RFC][PATCH] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock
	workaround
References: <1203634340.10422.203.camel@pasglop>	<20080222192817.GA26211@ru.mvista.com>	<20080222144919.3ded7c54@weaponx>	<47C40548.4080608@ru.mvista.com>
	<47C41DBE.7090505@harris.com>	<20080226090210.6816c130@zod.rchland.ibm.com>
	<1204185299.15052.381.camel@pasglop>
In-Reply-To: <1204185299.15052.381.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-02-26 at 09:02 -0600, Josh Boyer wrote:
>> Seems the code will do the right thing since everything is using
>> flags.  I suppose my question can be withdrawn.  It is slightly
>> confusing to do it that way though.  Perhaps a function to do
>> read-modify-writes on DCRs would be welcome.  dcr_modify anyone?
> 
> Yup, we probably want to expose a dcri_clrset(), though I would also
> expose then __mtdcri/__mfdcri (non locked version) and the spinlock in
> case somebody wants to do something fancy.

I've made a patch which adds dcri_clrset function, but I haven't exposed 
the unlocked versions though. I think that dcri_clrset is sufficient for 
working with indirect dcr (at least for now, since the most fancy stuff 
done with it atm is read/modify/write) and exposing the unlocked version 
may lead to its misuse.
I'll submit the patch shortly.

Thanks,
Valentine.
> 
> Cheers,
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

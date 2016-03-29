Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ55R2FVkzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 20:27:07 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 14:57:02 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2T9QE5g15991164
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 14:56:15 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2T9QqAQ023250
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 14:56:53 +0530
Date: Tue, 29 Mar 2016 20:26:34 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 1/2] pseries/eeh: Refactor the configure bridge RTAS
 tokens
Message-ID: <20160329092634.GA10585@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459219911-14110-1-git-send-email-ruscur@russell.cc>
 <20160329052608.GA2614@gwshan>
 <1459230799.21529.2.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1459230799.21529.2.camel@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 29, 2016 at 03:53:19PM +1000, Russell Currey wrote:
>On Tue, 2016-03-29 at 16:26 +1100, Gavin Shan wrote:
>> On Tue, Mar 29, 2016 at 12:51:50PM +1000, Russell Currey wrote:
><snip>
>> > 	/*
>> > 	 * Necessary sanity check. We needn't check "get-config-addr-info"
>> > @@ -93,8 +98,7 @@ static int pseries_eeh_init(void)
>> > 	=A0=A0=A0=A0(ibm_read_slot_reset_state2 =3D=3D RTAS_UNKNOWN_SERVICE=
 &&
>> > 	=A0=A0=A0=A0=A0ibm_read_slot_reset_state =3D=3D RTAS_UNKNOWN_SERVIC=
E)	||
>> > 	=A0=A0=A0=A0ibm_slot_error_detail =3D=3D RTAS_UNKNOWN_SERVICE	||
>> > -	=A0=A0=A0=A0(ibm_configure_pe =3D=3D RTAS_UNKNOWN_SERVICE		&
>> > &
>> > -	=A0=A0=A0=A0=A0ibm_configure_bridge =3D=3D RTAS_UNKNOWN_SERVICE)) =
{
>> > +	=A0=A0=A0=A0ibm_configure_pe =3D=3D RTAS_UNKNOWN_SERVICE) {
>> > 		pr_info("EEH functionality not supported\n");
>> > 		return -EINVAL;
>> > 	}
>> Since you're here, you can do similar thing to @ibm_read_slot_reset_st=
ate
>> and @ibm_read_slot_reset_state?
>
>Ah, didn't notice there was a similar thing going on there. =A0Will fix.

Ok.

>>=20
>> >=20
>> > @@ -621,18 +625,9 @@ static int pseries_eeh_configure_bridge(struct
>> > eeh_pe *pe)
>> > 	if (pe->addr)
>> > 		config_addr =3D pe->addr;
>> >=20
>> > -	/* Use new configure-pe function, if supported */
>> > -	if (ibm_configure_pe !=3D RTAS_UNKNOWN_SERVICE) {
>> > -		ret =3D rtas_call(ibm_configure_pe, 3, 1, NULL,
>> > -				config_addr, BUID_HI(pe->phb->buid),
>> > -				BUID_LO(pe->phb->buid));
>> > -	} else if (ibm_configure_bridge !=3D RTAS_UNKNOWN_SERVICE) {
>> > -		ret =3D rtas_call(ibm_configure_bridge, 3, 1, NULL,
>> > -				config_addr, BUID_HI(pe->phb->buid),
>> > -				BUID_LO(pe->phb->buid));
>> > -	} else {
>> > -		return -EFAULT;
>> > -	}
>> > +	ret =3D rtas_call(ibm_configure_pe, 3, 1, NULL,
>> > +			config_addr, BUID_HI(pe->phb->buid),
>> > +			BUID_LO(pe->phb->buid));
>> >=20
>> Russell, it seems not working if "ibm,configure-pe" and "ibm,configure=
-
>> bridge" are all
>> missed from "/rtas".
>
>If they're both missing, then the init should fail as=A0ibm_configure_pe=
 will
>be RTAS_UNKNOWN_SERVICE, so this code should never be called.
>

Yeah, I missed the point, thanks.

>>  Also, I don't think we need backport it to 3.10+ as it's not fixing
>> any bugs if I'm correct enough.
>
>This patch doesn't, but the second patch does.
>

Ok. In the commit log of this patch, you have something like below and th=
at
means it needs by stable kernels. I agree the next one is needed by stabl=
e
kernels, so the two patches would have inversed order if you agree. In th=
at
case, the next one (to be in stable kernels) won't depend on current on w=
hich
isn't required by stable kernels.

Cc: <stable@vger.kernel.org> # 3.10-   <<< The format would be 3.10+

Thanks,
Gavin

>> >=20
>> > 	if (ret)
>> > 		pr_warn("%s: Unable to configure bridge PHB#%d-PE#%x
>> > (%d)\n",
>

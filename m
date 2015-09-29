Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C5751A2B5F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:38:34 +1000 (AEST)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 29 Sep 2015 13:38:18 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C8AFE6E8096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 15:29:53 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TJcARr53805140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 19:38:10 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TJc5xN000759
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 15:38:10 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v4 17/32] cxlflash: Remove dual port online dependency
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <87a8s6und0.fsf@gamma.ozlabs.ibm.com>
Date: Tue, 29 Sep 2015 14:38:02 -0500
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <FD47E8E4-D768-401E-8A4C-31A3E37E359B@linux.vnet.ibm.com>
References: <1443222593-8828-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443223018-9577-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <87a8s6und0.fsf@gamma.ozlabs.ibm.com>
To: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 28, 2015, at 6:37 PM, Daniel Axtens <dja@axtens.net> wrote:
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
>=20
> Hi,
>=20
>> static int afu_set_wwpn(struct afu *afu, int port, u64 *fc_regs, u64 =
wwpn)
>> {
>> -	int ret =3D 0;
>> +	int rc =3D 0;
> I realise it's nice to have things consistent, but making this change
> now makes the rest of the patch quite difficult to follow.

Next time I will try to separate out a change like this.

>=20
>>=20
>> 	set_port_offline(fc_regs);
>>=20
>> @@ -1038,33 +1038,26 @@ static int afu_set_wwpn(struct afu *afu, int =
port, u64 *fc_regs, u64 wwpn)
>> 			       FC_PORT_STATUS_RETRY_CNT)) {
>> 		pr_debug("%s: wait on port %d to go offline timed =
out\n",
>> 			 __func__, port);
>> -		ret =3D -1; /* but continue on to leave the port back =
online */
>> +		rc =3D -1; /* but continue on to leave the port back =
online */
>> 	}
>>=20
>> -	if (ret =3D=3D 0)
>> +	if (rc =3D=3D 0)
>> 		writeq_be(wwpn, &fc_regs[FC_PNAME / 8]);
>>=20
>> +	/* Always return success after programming WWPN */
>> +	rc =3D 0;
>> +
>> 	set_port_online(fc_regs);
>>=20
>> 	if (!wait_port_online(fc_regs, FC_PORT_STATUS_RETRY_INTERVAL_US,
>> 			      FC_PORT_STATUS_RETRY_CNT)) {
>> 		pr_debug("%s: wait on port %d to go online timed out\n",
>> 			 __func__, port);
>> -		ret =3D -1;
>> -
>> -		/*
>> -		 * Override for internal lun!!!
>> -		 */
>> -		if (afu->internal_lun) {
>> -			pr_debug("%s: Overriding port %d online =
timeout!!!\n",
>> -				 __func__, port);
>> -			ret =3D 0;
>> -		}
>> 	}
>>=20
>> -	pr_debug("%s: returning rc=3D%d\n", __func__, ret);
>> +	pr_debug("%s: returning rc=3D%d\n", __func__, rc);
> I'm not sure I fully understand the flow of this function, but it =
looks
> like you set rc=3D0 regardless of how things actually go: is this ever
> going to print a return value other than zero?

Correct, this function behaves more like a void for the time being. The
overall goal of this is to allow a card to configure even when the link =
is
down. At some later point when the link is transitioned to 'up', a link =
state
change interrupt will trigger the port configuration. I left this with a =
return
code for right now in case we need to alter the behavior again (based
upon testing) and actually return a value other than 0.

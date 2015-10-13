Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF6151A09FC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:18:42 +1100 (AEDT)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 58083140FDB
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 16:18:41 +1100 (AEDT)
Received: by pabve7 with SMTP id ve7so9816906pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 22:18:38 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 3/8] powerpc/eeh: Force reset on fenced PHB
In-Reply-To: <20151013050151.GB28681@gwshan>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <871tcz4k78.fsf@gamma.ozlabs.ibm.com> <20151013050151.GB28681@gwshan>
Date: Tue, 13 Oct 2015 16:18:19 +1100
Message-ID: <87vbab2vok.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> On Tue, Oct 13, 2015 at 12:43:23PM +1100, Daniel Axtens wrote:
>>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>>
>>> +	 *
>>> +	 * When the PHB is fenced, we have to issue a reset to recover from
>>> +	 * the error. Override the result if necessary to have partially
>>> +	 * hotplug for this case.
>>>  	 */
>>>  	pr_info("EEH: Notify device drivers to shutdown\n");
>>>  	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
>>> +	if ((pe->type & EEH_PE_PHB) &&
>>> +	    result !=3D PCI_ERS_RESULT_NONE &&
>>> +	    result !=3D PCI_ERS_RESULT_NEED_RESET)
>>> +		result =3D PCI_ERS_RESULT_NEED_RESET;
>>I think we shouldn't discard the DISCONNECT state. A driver could ask
>>that the device be disconnected in the error_detected callback and we
>>should probably honour that.
>>
>
> Not exactly, the improvement is limited to fenced PHB, not frozen PE case.
> That's ok to discard DISCONNECT which forces all PHB's subordinate devices
> to offline permanently, which isn't so reasonable.

I see. That makes more sense now. It's still a bit hacky but I can see
why it should be the way it is.

Reviewed-by: Daniel Axtens <dja@axtens.net>

>
> This flag (DISCONNECT) has been there before the partial hotplug is
> added. I think the flag can die now with partial hotplug support.

OK. It looks like I need to put some more thought into partial hotplug.
I'm increasingly thinking it would be worth redesigning the state
machine and the enumerations/flags to better deal with how things have
evolved over the years.

Regards,
Daniel


>
> Thanks,
> Gavin
>
>>>=20=20
>>>  	/* Get the current PCI slot state. This can take a long time,
>>>  	 * sometimes over 300 seconds for certain systems.
>>> --=20
>>> 2.1.0
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWHJQcAAoJEPC3R3P2I92F4F4QAMiwwJj4/SGGtJToIwsNAIGE
qlvy51pWkhGO9zqNUR48QN686LJi3xMX+PZPOnq27EtkQAJ4TGqxqcOha3GfcmV3
w147Fi7u/vjtLkii2SFWdKQmQJqWTDdG+tPAWMl2d1oqCbq9GcPvCvvcQYFDe94R
vuAJv232vST7Z3TKgIhUk1JqU0uvIp6JnhhSSSY1Chd0KNl7RJlcRTH3WJ56iolN
HdE6hiewZ1+5luawi0YsRuD4cDq2AuYxvep1K6HHr0SPtyp7RRH+/EWPN1ANbZXs
O9iR054JfulHNqgtEAo8xJ92KVNRqAcW+6XhWD4PKaT/2kHaqq3FH/lQ96jhhXvb
Tan2HodBIm7U0o7Y0UdpZKtw88nTR+bs6mET/3rCnygOhFJoNuK4m8oreI1iRmxD
FP+AR3VDLKFRdT0xOJE+Ulvzj9lCGpjYPQRDIFFewS2LFd29UU9/7qCjP8Dg+Yfg
6+3kqXn59GE2t9HC5b8pTNce5PBs+wO4lbjPHDOi+/tI3r9r237ZHLjLzNU9EArr
LXtT8pO0CRaHI0K5biZyBc0hv7dshCZALx9z4OhBE/QBPgOvY2s6ik4oHeQI5TUy
ypKg+9gv7OIFEcbFrA7C/yFn3NhCxwz0TtdFXIukvutBMwS2PIWfG9gFVCuQ2eE3
ydLx6DTbDZFRdW9u2Nx6
=oXXg
-----END PGP SIGNATURE-----
--=-=-=--

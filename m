Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AECC91A01D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 10:48:33 +1100 (AEDT)
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E7DD140F99
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 10:48:31 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so35181308pab.0
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 16:48:29 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/8] powerpc/eeh: More relexed hotplug criterion
In-Reply-To: <20151013042828.GA28681@gwshan>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <87612b4rye.fsf@gamma.ozlabs.ibm.com> <20151012232510.GA14333@gwshan>
 <87y4f732ll.fsf@gamma.ozlabs.ibm.com> <20151013042828.GA28681@gwshan>
Date: Wed, 14 Oct 2015 10:48:15 +1100
Message-ID: <87si5e2uv4.fsf@gamma.ozlabs.ibm.com>
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


> I think you're talking about the situation reported from the bug. It's
> CAN_RECOVER instead of NONE returned from error_detected(). With the
> CAN_RECOVER, the driver hopes the EEH core to enable the IO path so that
> it can collect diag-data from IO space at late point.

Oh. That's an interesting decision from the driver's point of view.

I obviously need to re-read the patch and the surrounding code and try
again to make sense of it later. Thanks for your attempts to explain it!

Regards,
Daniel

>
>>Partial hotplug is pretty hacky to begin with, and a driver being able
>>to opt out of EEH selectively is a useful feature, so we probably want
>>to redesign the state machine to handle them both better. That would be
>>a long term project.
>>
>
> Thanks,
> Gavin
>
>>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>> ---
>>>>>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/e=
eh_driver.c
>>>>> index 3a626ed..32178a4 100644
>>>>> --- a/arch/powerpc/kernel/eeh_driver.c
>>>>> +++ b/arch/powerpc/kernel/eeh_driver.c
>>>>> @@ -416,7 +416,10 @@ static void *eeh_rmv_device(void *data, void *us=
erdata)
>>>>>  	driver =3D eeh_pcid_get(dev);
>>>>>  	if (driver) {
>>>>>  		eeh_pcid_put(dev);
>>>>> -		if (driver->err_handler)
>>>>> +		if (driver->err_handler &&
>>>>> +		    driver->err_handler->error_detected &&
>>>>> +		    driver->err_handler->slot_reset &&
>>>>> +		    driver->err_handler->resume)
>>>>>  			return NULL;
>>>>>  	}
>>>>>=20=20
>>>>> --=20
>>>>> 2.1.0
>>>>>
>>>>> _______________________________________________
>>>>> Linuxppc-dev mailing list
>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWHZg/AAoJEPC3R3P2I92F4YwP/iWgV5OXan5QhAjTWtrSgxbT
2K1YyGeyX16MHtkiDRE3QSFTM2kytS2IdAl1KK8CC9KqcxihbfQKhAUqwcm7Tyh2
5ub2Iac+oaLnKZJPAjSLtG8HRt+rk8A3VQmEJPSfY6vcdKktb43WHj5CGT3372ma
aZUvxz2D1DQVjcfsJbACJnz7wooUtlsA5Lhos+ZNw56Pd5Yvbo39Q7cKvsTAcl8/
ZIZcy7K0rCgbv4taCXtVO0/cZ6WohrppvgMKhMHcn+8193GIm9hc2g/0rYmOskW6
7JcCJBIp7Gc2HVihqSbCWjQrrc1pCjagWjNUyabC/1772EIjNaGL57g9wDuSAQE+
zMIXBGUOxLzSLJatpvTfmerbdZAFQnHm+nBNXhmNf4eIDXBhZP9i3Y4HonabUnYn
LW7JG0mr/ohjilLxr9WMD3dt3yT89hEmpAtxdz8/whL/mI+guuFDvW0t6RhJWQ8y
mQ64299TtAsWsvRc0i8wC0ONdd1f6EDFCbLd8Cj7z1Fv5hioA4+uv9I1GOE+FWvi
KvKCEZYvrT26xE+biPAdOeurQx62QbFojDf01q5TILTToWMT9MvA+ZXmvGLhxUaX
mAYvySHBvJFqEseUEIebYZT4QPNMXpQYhkRVwEs6DbApXMD5XYnSngX9SbOFAIqG
6SNVb6OB8aaalEpvWkTQ
=SGN2
-----END PGP SIGNATURE-----
--=-=-=--

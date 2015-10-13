Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 951B91A08F1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 13:49:21 +1100 (AEDT)
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 618B5140DA5
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 13:49:20 +1100 (AEDT)
Received: by pabve7 with SMTP id ve7so6032438pab.2
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2015 19:49:19 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/8] powerpc/eeh: More relexed hotplug criterion
In-Reply-To: <20151012232510.GA14333@gwshan>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <87612b4rye.fsf@gamma.ozlabs.ibm.com> <20151012232510.GA14333@gwshan>
Date: Tue, 13 Oct 2015 13:48:54 +1100
Message-ID: <87y4f732ll.fsf@gamma.ozlabs.ibm.com>
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

> Danienl, The issue is tracked by IBM's bugzilla 127612 reported from Nvida
> private GPU drivers. I tried to find the source code from upstream kernel,
> but failed.

OK. So I've read the internal bug, and I'm going to do my best to summarise
without including confidential info.

 1) A PHB with 2 devices is fenced via error injection.

 2) The error_detected() callback is run on both devices. One returns
    CAN_RECOVER, the other returns NONE.

We then fall through to partial-hotplug handling. (BTW this isn't
documented in Documentation/PCI/pci-error-recovery.txt, so at some point
this should be fixed!)

Partial hotplug is detected by the presence of an err_handler, not by
storing the result of error_detected. Would it be better to store the
result from eeh_report_error in the eeh_dev structure, rather than by
looking at more elements of the err_handler structure?

More generally, drivers using error_detect and then returning NONE as a
way to get data and then not participate in EEH is a hack, and it's not
surprising it's breaking in odd ways, especially with partial hotplug.

Partial hotplug is pretty hacky to begin with, and a driver being able
to opt out of EEH selectively is a useful feature, so we probably want
to redesign the state machine to handle them both better. That would be
a long term project.

Regards,
Daniel

> Thanks,
> Gavin
>
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh=
_driver.c
>>> index 3a626ed..32178a4 100644
>>> --- a/arch/powerpc/kernel/eeh_driver.c
>>> +++ b/arch/powerpc/kernel/eeh_driver.c
>>> @@ -416,7 +416,10 @@ static void *eeh_rmv_device(void *data, void *user=
data)
>>>  	driver =3D eeh_pcid_get(dev);
>>>  	if (driver) {
>>>  		eeh_pcid_put(dev);
>>> -		if (driver->err_handler)
>>> +		if (driver->err_handler &&
>>> +		    driver->err_handler->error_detected &&
>>> +		    driver->err_handler->slot_reset &&
>>> +		    driver->err_handler->resume)
>>>  			return NULL;
>>>  	}
>>>=20=20
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

iQIcBAEBCgAGBQJWHHEWAAoJEPC3R3P2I92FwqcP/R0N7UgJqf3q1o04F8oZKEAS
gE4MIGvRiJS9rheMkl4Kl2199Ia9YLMKnf/INolMzix+LXBY9OkAMCMojwjMfPCy
bUh7jQCZQnHIRsLTciQ00kbNMf6KEL5PqybWBJpT/kM8ji+M5Dk6Y7RFAP5yeQYW
S3F11NfqfQz9oM6wEItP/fARuQdCRzRup+/YUooYfANE6doOtcnNCQcwUhl0uJZs
XuFTg5j8E+MzdFU6bIIVqT1XNKXqpswMgr77KCoa9UTow70K0HBL+82uSX6flaQb
aY5Kb9orhXbNbzyEWnssQtWUcouo93cP6si5lcCs21JUyMrBHezvMWSfDdZLjpnS
/bLDroVq1sIImszcIPOW05jXI70qMA94TQU5iyXvzcAYoHnILt8SOiMURBvuzpZC
9DLiJr/I4QjoJdy8VBODhTagYvwF75CDkF/9gKMv51eAbaDQDwdtA5aIJZGjrW6V
IbbQ+s7SBsm5al6/gaXos4KAR4ALxO5zQDkFPB6d03Xrx59CcayCXqR0QoOEjZbf
nDUtnXY2f+2OiEoHHTxKljesAXd0c93uDBx0hsl7gsfzcdCbjXZ6hSWaG+jei/I2
k08gStvRHLfbnSO5MbHHmyYWjO3B3f/bvEtkfSh3+mxYuvekAx9M/4c5AnjbWVpC
GIIkwQ/HnqeWe1Bzxgc4
=AZ/l
-----END PGP SIGNATURE-----
--=-=-=--

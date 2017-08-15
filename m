Return-Path: <ldoktor@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWllb1CkSzDrDB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 18:20:11 +1000 (AEST)
Subject: Re: [PATCH] rtc: rtctest: Improve support detection
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it, john.stultz@linaro.org, tglx@linutronix.de,
 sboyd@codeaurora.org, shuah@kernel.org, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20170811091455.11041-1-ldoktor@redhat.com>
 <20170811091455.11041-2-ldoktor@redhat.com>
 <20170812202206.6phv7fesej42jhxr@piout.net>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <156f7ff1-d1e3-16ea-98a8-969625075c72@redhat.com>
Date: Tue, 15 Aug 2017 10:20:04 +0200
MIME-Version: 1.0
In-Reply-To: <20170812202206.6phv7fesej42jhxr@piout.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="752HUNtsh6CvCTdGseo5Lfk0j19BJsfaF"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--752HUNtsh6CvCTdGseo5Lfk0j19BJsfaF
Content-Type: multipart/mixed; boundary="AGiCwMtv507nr0X9pGW5fjAUUaF0LUeue";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: a.zummo@towertech.it, john.stultz@linaro.org, tglx@linutronix.de,
 sboyd@codeaurora.org, shuah@kernel.org, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <156f7ff1-d1e3-16ea-98a8-969625075c72@redhat.com>
Subject: Re: [PATCH] rtc: rtctest: Improve support detection
References: <20170811091455.11041-1-ldoktor@redhat.com>
 <20170811091455.11041-2-ldoktor@redhat.com>
 <20170812202206.6phv7fesej42jhxr@piout.net>
In-Reply-To: <20170812202206.6phv7fesej42jhxr@piout.net>

--AGiCwMtv507nr0X9pGW5fjAUUaF0LUeue
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 12.8.2017 v 22:22 Alexandre Belloni napsal(a):
> Hi,
>=20
> On 11/08/2017 at 11:14:55 +0200, Luk=C3=A1=C5=A1 Doktor wrote:
>> The rtc-generic and opal-rtc are failing to run this test as they do n=
ot
>> support all the features. Let's treat the error returns and skip to th=
e
>> following test.
>>
>> Theoretically the test_DATE should be also adjusted, but as it's enabl=
ed
>> on demand I think it makes sense to fail in such case.
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> ---
>>  tools/testing/selftests/timers/rtctest.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/=
selftests/timers/rtctest.c
>> index f61170f..6344842 100644
>> --- a/tools/testing/selftests/timers/rtctest.c
>> +++ b/tools/testing/selftests/timers/rtctest.c
>> @@ -125,7 +125,7 @@ int main(int argc, char **argv)
>>  	/* Turn on update interrupts (one per second) */
>>  	retval =3D ioctl(fd, RTC_UIE_ON, 0);
>>  	if (retval =3D=3D -1) {
>> -		if (errno =3D=3D EINVAL) {
>> +		if (errno =3D=3D EINVAL || errno =3D=3D EINVAL) {
>=20
> Well, this needs to be fixed.
>=20

Yes, this chunk is actually not needed anymore (it was based on outdated =
copy we use in Autotest which had ENOTTY which is probably not needed now=
adays). Let me send v2 without this.

Regards,
Luk=C3=A1=C5=A1

>>  			fprintf(stderr,
>>  				"\n...Update IRQs not supported.\n");
>>  			goto test_READ;
>> @@ -221,6 +221,11 @@ int main(int argc, char **argv)
>>  	/* Read the current alarm settings */
>>  	retval =3D ioctl(fd, RTC_ALM_READ, &rtc_tm);
>>  	if (retval =3D=3D -1) {
>> +		if (errno =3D=3D EINVAL) {
>> +			fprintf(stderr,
>> +					"\n...EINVAL reading current alarm setting.\n");
>> +			goto test_PIE;
>> +		}
>>  		perror("RTC_ALM_READ ioctl");
>>  		exit(errno);
>>  	}
>> @@ -231,7 +236,7 @@ int main(int argc, char **argv)
>>  	/* Enable alarm interrupts */
>>  	retval =3D ioctl(fd, RTC_AIE_ON, 0);
>>  	if (retval =3D=3D -1) {
>> -		if (errno =3D=3D EINVAL) {
>> +		if (errno =3D=3D EINVAL || errno =3D=3DEIO) {
>>  			fprintf(stderr,
>>  				"\n...Alarm IRQs not supported.\n");
>>  			goto test_PIE;
>> --=20
>> 2.9.4
>>
>=20



--AGiCwMtv507nr0X9pGW5fjAUUaF0LUeue--

--752HUNtsh6CvCTdGseo5Lfk0j19BJsfaF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZkq60ExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFk
7Qf/XjjlFgavyWFgnaQTi4b/mZOX/yDo1P/Z9SerwNtBfDntTVZVS42iBvSso+1w
/hDXWgjqdIMB5WKPtLqvF9SeS90k4bKYUAo1LhpYfrpk/dHeLe8hKr3sORTJaX30
EzJg33j43YchfTjRivhb6ggzsO6BRmRUF6knFyFEGX/vdSle9DwReer8x4YrxgK1
osQEImKFYDxXxokgQNia6d7hJoADdyvSbSyAyYfO3q5hwsPP8GzA64pxCfK5qBkM
5oXryVj53tp/YIzB1YpLyxRk7Hc491Ztc11DMDgiIG0V6VqwNF1KPTRn5j3RBa30
H/Zxon17bc7BtmOwbMobhz4twQ==
=NxCU
-----END PGP SIGNATURE-----

--752HUNtsh6CvCTdGseo5Lfk0j19BJsfaF--

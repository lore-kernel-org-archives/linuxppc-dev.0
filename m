Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C43E679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 20:26:50 +1000 (EST)
Subject: Re: problem with watchdog/reboot MPC5200
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: jgeissel@gmx.net
In-Reply-To: <200604201146.01342.jgeissel@gmx.net>
References: <200604201146.01342.jgeissel@gmx.net>
Content-Type: multipart/signed; micalg=sha1;
	protocol="application/x-pkcs7-signature";
	boundary="=-R9sXaaqSRdO3XFbZEvdJ"
Date: Thu, 20 Apr 2006 12:21:13 +0200
Message-Id: <1145528473.13114.6.camel@linpc041.aimsys.nl>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-R9sXaaqSRdO3XFbZEvdJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Arno,

I think your problem is related to Intel Strataflash specifics.
After a write to strataflash, it remains in status mode until another
read (or reset) command is issued. This means you don't get the flash
contents when reading it, but a status bit (e.g. 0x8080 at every spot).
So when the processor start executing after a reset, it's not reading
proper instructions.

You first need to e.g. write a reset cmd (0x5050) to it or connect
the processor's hardreset line to the flash device.

Jaap-Jan

On Thu, 2006-04-20 at 11:46 +0200, Arno Geissel wrote:
> Hello all,
>=20
> I have a custom board based on MPC5200 processor running
> the latest linuxppc_2_4_devel.
> Everything is working fine until a flash write access is performed
> using MTD. After this a (soft) reboot stucks in mpc5xxx_restart()
> where the watchdog timer is charged and linux waits with closed
> interrupts until the MPC performs the reset. Only power off helps
> in this situation.
> It seems to me like a hardware problem, because the freescale
> MPC5200lite reference board does not run into this.
> The main difference of the custom board to the reference board
> is, that it is using 16MB Intel Strada Flash instead of AMD flash,
> which has an erase block size of 128kB.
> Has anybody else experienced such behaviour?
>=20
> Arno Geissel
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20

--=-R9sXaaqSRdO3XFbZEvdJ
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIID/DCCA/gw
ggNhoAMCAQICAQwwDQYJKoZIhvcNAQEEBQAwgaMxCzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29y
ZCBIb2xsYW5kMRIwEAYDVQQHEwlIaWx2ZXJzdW0xFzAVBgNVBAoTDkFpbVZhbGxleSBCLlYuMRww
GgYDVQQLExNTZWN1cml0eSBEZXBhcnRtZW50MTEwLwYDVQQDEyhBaW1WYWxsZXkgUm9vdCBDZXJ0
aWZpY2F0aW9uIEF1dGhvcml0eSAxMB4XDTA1MDcwMzE5MTQ0NVoXDTA2MDcwMzE5MTQ0NVowgawx
CzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29yZCBIb2xsYW5kMRIwEAYDVQQHEwlIaWx2ZXJzdW0x
FzAVBgNVBAoTDkFpbVZhbGxleSBCLlYuMRwwGgYDVQQLExNTZWN1cml0eSBEZXBhcnRtZW50MRkw
FwYDVQQDFBBqamJvb3JAYWltc3lzLm5sMR8wHQYJKoZIhvcNAQkBFhBqamJvb3JAYWltc3lzLm5s
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSaQ+TlMoyr4eU0v+pTPEwdQVaOvZaVstPT4HO
Bs1ZpCudyz/d5uXbjWUqhVZXN9RmjUsYqOpTerOmdKLGQG+iF0V04G6HgkFGGwSNOYzIPggbjBCp
Od73z50VUaSEJIx7biCkii/HCEQtjMNHE43x7E6BQHsFlwxcZVxXpwTmjwIDAQABo4IBLzCCASsw
CQYDVR0TBAIwADAsBglghkgBhvhCAQ0EHxYdT3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUw
HQYDVR0OBBYEFNI9c+sPawUOChOJkpIcB4lloJAxMIHQBgNVHSMEgcgwgcWAFLQ7l4QR8t4pz5gw
b3NBgNlqWk7HoYGppIGmMIGjMQswCQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQgSG9sbGFuZDES
MBAGA1UEBxMJSGlsdmVyc3VtMRcwFQYDVQQKEw5BaW1WYWxsZXkgQi5WLjEcMBoGA1UECxMTU2Vj
dXJpdHkgRGVwYXJ0bWVudDExMC8GA1UEAxMoQWltVmFsbGV5IFJvb3QgQ2VydGlmaWNhdGlvbiBB
dXRob3JpdHkgMYIBADANBgkqhkiG9w0BAQQFAAOBgQA5e6p8IA8odS5Hjk8VJVLZgHABYpnUs/Ld
yFzTEpDtRFwINLUiViq72FwBYVKIQQJHaE5l+mYhw5y9TB1gXRLxyPUxyqExWh92VPVhSzKPN9Rk
IXZ65OIr+j5PXLfSEM6zm0Iv1yKcTjUNnh+P4Se9fln3yVUtxr1opZMsr0RCsjGCAa8wggGrAgEB
MIGpMIGjMQswCQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQgSG9sbGFuZDESMBAGA1UEBxMJSGls
dmVyc3VtMRcwFQYDVQQKEw5BaW1WYWxsZXkgQi5WLjEcMBoGA1UECxMTU2VjdXJpdHkgRGVwYXJ0
bWVudDExMC8GA1UEAxMoQWltVmFsbGV5IFJvb3QgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMQIB
DDAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MDYwNDIwMTAyMTEzWjAjBgkqhkiG9w0BCQQxFgQUd1kl9KEGY8Cf1vCn6TYGxyl34gIwDQYJKoZI
hvcNAQEBBQAEgYAc5fTccMTO6RvGW4MfzJS7tKJOIwZnLHtQCF4ErOFN+ii3uzKaNs/oEhafTzVM
zECydWIqeMtaAU+DmYylhl8LfVtdqcbr7UtuKxktvsJs76tWwsMpIwxT70UA6P8Tirs3ehEQC5jl
W0h4qcXDzb8GzQPgU+/LPKfeosW3lSUMKAAAAAAAAA==


--=-R9sXaaqSRdO3XFbZEvdJ--

Return-Path: <jimix@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 784B967B28
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 22:22:31 +1000 (EST)
In-Reply-To: <1147908963.7360.1.camel@localhost.localdomain>
References: <E1FgORv-0001dS-Hu@heater.watson.ibm.com>
	<1147908963.7360.1.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=pgp-sha1; boundary="Apple-Mail-7--3476992"
Message-Id: <34FAC3E5-F717-4640-B094-312C8773852E@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [PATCH][resend] udbg_printf() formatting attribute
Date: Thu, 18 May 2006 08:22:10 -0400
To: michael@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7--3476992
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed


On May 17, 2006, at 7:36 PM, Michael Ellerman wrote:

> On Wed, 2006-05-17 at 12:00 -0400, jimix@watson.ibm.com wrote:
>> -	pr_debug("%s: current_entitled = %lu, current_weight = %lu\n",
>> +	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
>>  		 __FUNCTION__, current_entitled, current_weight);
>>
>> -	pr_debug("%s: new_entitled = %lu, new_weight = %lu\n",
>> +	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
>>  		 __FUNCTION__, *new_entitled_ptr, *new_weight_ptr);
>
> But pr_debug() calls printk, not udbg_printf() ?

Now _thats_ funny!
Then I'm so happy to have found and fixed this compiler warning :)

>> -extern void udbg_printf(const char *fmt, ...);
>> +extern void udbg_printf(const char *fmt, ...)
>> +	__attribute__ ((format (printf, 1, 2)));

I believe this chunk is still goodness as it will catch format issues  
for developers.
-JX

--Apple-Mail-7--3476992
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Darwin)

iD8DBQFEbGb4d/h5j14PFR4RAqZZAKCvNEzUMSl0jkbZfDX7AkbltSPcMgCeI90D
WuONACQnXwPlSrl4ivETdMs=
=7i7B
-----END PGP SIGNATURE-----

--Apple-Mail-7--3476992--

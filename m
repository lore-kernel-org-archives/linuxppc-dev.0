Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 7FAF7B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 25 Jul 2010 08:00:45 +1000 (EST)
Received: by gya1 with SMTP id 1so581432gya.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Jul 2010 15:00:43 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279853150.1970.58.camel@pasglop>
References: <1279841330-28695-1-git-send-email-stuart.yoder@freescale.com>
	<1279853150.1970.58.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 24 Jul 2010 16:00:21 -0600
Message-ID: <AANLkTikD5n8Vo7BAE29qQBJpJi0qBMnSVUaWKVA9uK-3@mail.gmail.com>
Subject: Re: [PATCH] fix of_flat_dt_is_compatible to match the full compatible
	string
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 22, 2010 at 8:45 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2010-07-22 at 18:28 -0500, Stuart Yoder wrote:
>> From: Stuart Yoder <stuart.yoder@freescale.com>
>>
>> With the previous string comparison, a device tree
>> compatible of "foo-bar" would match as compatible
>> with a driver looking for "foo".
>>
>> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
>
> Beware you are doing two changes in one here and only documenting one...
>
> You also removed the case insenstivity.
>
> Now, those things are supposed to be case sensitive afaik, but we have
> enough legacy HW with more/less crap DTs and I'd be careful with
> changing that without a good reason (ie, it breaks not to do it ?).
>
> No objection with fixing the partial match tho.

On that note, for completeness, this code should be using the
of_compat_cmp() to match up with other code.  If SPARC ever uses this
code, which davem said he might tp support kexec, then this macro will
be important.  I'll change it when I pick up the patch.

g.

>
> Cheers,
> Ben.
>
>> ---
>> =A0drivers/of/fdt.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index dee4fb5..f5239c0 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -169,7 +169,7 @@ int __init of_flat_dt_is_compatible(unsigned long no=
de, const char *compat)
>> =A0 =A0 =A0 if (cp =3D=3D NULL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 while (cplen > 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (strncasecmp(cp, compat, strlen(compat)) =
=3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(cp, compat))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D strlen(cp) + 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cp +=3D l;
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

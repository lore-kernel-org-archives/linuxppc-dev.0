Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id E0975B7CED
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 07:07:05 +1100 (EST)
Received: by gwj20 with SMTP id 20so321327gwj.15
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Mar 2010 12:07:04 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
References: <14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 2 Mar 2010 13:06:44 -0700
Message-ID: <fa686aa41003021206v773b30d1vef6362704dca9e61@mail.gmail.com>
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high baud
	rates, better accuracy)
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 2, 2010 at 1:09 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
>> > + =A0 /* Check only once if we are running on a mpc5200b or not */
>> > + =A0 if (is_mpc5200b =3D=3D -1) {
>> > + =A0 =A0 =A0 =A0 =A0 struct device_node *np;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,=
mpc5200b-immr");
>>
>> This should be handled using a new compatible-entry
>> "fsl,mpc5200b-psc-uart".
>
> I agree that this would be a lot cleaner, but it's also a lot more intrus=
ive. =A0CC'ing the device tree discussion list here... comments, please!!

fsl,mpc5200b-psc-uart is already in the compatible list for all
MPC500b boards currently in the kernel tree.

>> > + =A0 =A0 =A0 =A0 =A0 if (np) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 is_mpc5200b =3D 1;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&op->dev, "mpc5200b: usi=
ng /4 prescaler\n");
>>
>> Does this message respect the fallback case?
>
> See comment above...
>
>> You could also have a set_divisor-function for 5200 and 5200B and set it
>> here
>> in the function struct (one reason less for the static ;))
>
> Hmmm, but then I would need a 'static struct psc_ops mpc5200b_psc_ops', w=
here only two functions differ from the generic 52xx struct as it is implem=
ented now. =A0Using the static int needs less space. =A0However, in combina=
tion with the new compatible entry, it would of course make sense.
>
> Again, any insight from the device tree gurus would be appreciated!

Wolfram is correct, you should set the correct divisor function in the
ops structure.  Much clearer code that way.

g.

Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 4F368DDE19
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 13:08:19 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so655195ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 07 May 2009 20:08:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4b73d43f0905071922x7b5ed328q86b14a35c0040270@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-7-git-send-email-wd@denx.de>
	<fa686aa40905061359p3ba2115fj57f4d9a79f01efda@mail.gmail.com>
	<4b73d43f0905071922x7b5ed328q86b14a35c0040270@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 7 May 2009 21:07:58 -0600
Message-ID: <fa686aa40905072007w5454591bh7b338d8a3b22a0c3@mail.gmail.com>
Subject: Re: [PATCH 06/12] mpc5121: Added NAND Flash Controller driver.
To: John Rigby <jcrigby@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Wolfgang Denk <wd@denx.de>, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 7, 2009 at 8:22 PM, John Rigby <jcrigby@gmail.com> wrote:
>
>
> On Wed, May 6, 2009 at 2:59 PM, Grant Likely <grant.likely@secretlab.ca>
> wrote:
>>
>>
>> > diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c
>> > b/arch/powerpc/platforms/512x/mpc512x_shared.c
>> > index d8cd579..7135d89 100644
>> > --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
>> > +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
>> > @@ -71,6 +71,7 @@ void __init mpc512x_init_IRQ(void)
>> > =A0static struct of_device_id __initdata of_bus_ids[] =3D {
>> > =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-immr", },
>> > =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-localbus", },
>> > + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-nfc", },
>>
>> This doesn't look right. =A0Shouldn't the NAND controller be hanging of
>> the IMMR node?
>
> I just wanted to confirm that NFC is in its own memory space. =A0 It has =
its
> own mapping and is not part of the IMMR space.

Hmmm... I wonder then if it might be better to have an IPB node, and
hang all the IPB connected nodes off of it.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f218.google.com (mail-gx0-f218.google.com
	[209.85.217.218]) by ozlabs.org (Postfix) with ESMTP id 2573AB7C44
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 17:47:42 +1100 (EST)
Received: by gxk10 with SMTP id 10so963969gxk.3
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 23:47:41 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1254771740.5503.2@antares>
References: <fa686aa40910051116l6439eef7xc9f75c6ac4368094@mail.gmail.com>
	<1254771740.5503.2@antares>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 1 Nov 2009 00:47:21 -0600
Message-ID: <fa686aa40910312347q1a8a3bc5t8edcc5a349479754@mail.gmail.com>
Subject: Re: [PATCH/v2] powerpc/5200: make BestComm gen_bd microcode
	exchangeable
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 5, 2009 at 1:42 PM, Albrecht Dre=DF <albrecht.dress@arcor.de> w=
rote:
> Am 05.10.09 20:16 schrieb(en) Grant Likely:
>>
>> Hmmm. =A0I've not been comfortable with this change, but it took me a wh=
ile
>> to put my finger on exactly why. =A0In principle, I think it is a good i=
dea.
>> =A0However, I don't want to merge it without any in-tree users.
>
> I could provide my modified microcode (which differs in two words only), =
for
> the "standard" task, just with byte swapping for the LPB, but I wonder if=
 it
> is of much use. =A0No progress with crc32 calculation in BestComm so far.=
..
> :-(
>
>> The other concern is that I don't like that the patch is only applicable
>> to gen_bd tasks.
>
> IMHO the big difference between gen_bd on one hand and ATA and FEC on the
> other is that (afaik) we have *no* other choice than using the implemente=
d
> tasks for the latter two, obviously using the Freescale's example microco=
de.
> =A0Gen_bd can apparently be used for a plenty of purposes, including LPB =
(as
> shown in your driver), maybe PCI (there are examples in Freescale's code)=
,
> PSC, etc. =A0Thus, the FEC and ATA drivers should not have an option as t=
o
> change the microcode, whereas it is just convenient for gen_bd.

agreed.

>> I've been thinking about this for a while, and I'm not exactly thrilled
>> with the bestcomm layout which keeps the bestcomm firmware separate from=
 the
>> only driver that actually uses it (ie FEC firmware & support code is
>> separate from the FEC driver. =A0Same for ATA). =A0I don't like the fact=
 that
>> code which is only ever used by the ATA driver is maintained completely
>> separate from it.
>
> That's a good point! =A0The separate microcode files for ATA and FEC are
> somewhat confusing. =A0I guess it's a result of simply copying the Freesc=
ale
> examples into separate files (and that might be a good reason for keeping
> the microcode separated). =A0Maybe create new sub-folders below
> arch/powerpc/sysdev/bestcomm for fec, ata, and gen_bd? =A0At least some
> documentation would be great.

No, that doesn't really help much.  The ATA and FEC microcode +
support functions really have no business living in the common
bestcomm directory at all.  I should look into moving that stuff right
into the FEC and ATA drivers.  The Bestcomm API is probably designed
to the wrong level, and the base API should expose the same task
loading interface to all uses, FEC, ATA, GenBD, and custom tasks.

>> But I may be splitting hairs here and maybe I shouldn't be too concerned
>> about it. =A0Regardless, I'd think I'd rather see something that isn't t=
otally
>> gen_bd specific. =A0Perhaps *microcode should be part of the bcom_task
>> structure?
>
> See above - I believe FEC and ATA are somewhat special as they need
> *exactly* the provided microcode. =A0And if something cannot be changed
> without breaking the functionality, there should not be a chance to do so=
...
> ;-)

Hence the FEC and ATA microcode should live in (*gasp*) the FEC and
ATA drivers.  ;-)

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

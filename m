Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 3B530DDFD2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 02:37:00 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so277895yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 09:36:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40905200925o763179c7r27c12f7659560807@mail.gmail.com>
References: <1242806865-2334-1-git-send-email-w.sang@pengutronix.de>
	<9e4733910905200817w20a812bcy14481255fefd011f@mail.gmail.com>
	<20090520155346.GG29102@pengutronix.de>
	<9e4733910905200910r5342c087pa4ebc579b37c8671@mail.gmail.com>
	<20090520161511.GH29102@pengutronix.de>
	<fa686aa40905200925o763179c7r27c12f7659560807@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 20 May 2009 10:36:39 -0600
Message-ID: <fa686aa40905200936o63f47937rda28126ce0f46aad@mail.gmail.com>
Subject: Re: [PATCH] powerpc/pcm030.dts: add i2c eeprom and delete cruft
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 10:25 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Wed, May 20, 2009 at 10:15 AM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
>> On Wed, May 20, 2009 at 12:10:59PM -0400, Jon Smirl wrote:
>>> On Wed, May 20, 2009 at 11:53 AM, Wolfram Sang <w.sang@pengutronix.de> =
wrote:
>>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: EEPROM */
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@52 {
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 comp=
atible =3D "at24,24c32";
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =
=3D <0x52>;
>>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>> >>
>>> >> Grant suggested this earlier...
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@52 {
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatib=
le =3D "atmel,24c32", "eeprom";
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D =
<0x52>;
>>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>>> >
>>> > Can you give me a pointer? I just found this thread
>>>
>>>
>>> Grant, what do you want here?
>>
>> I fear an answer like: "a properly working at24" ;)
>>
>
> BWAHAHAHAHA!

Now that I've got that out of the way...

As the other thread states, "eeprom" is far too vague, and it is
certainly not documented, and does not say anything meaningful about
the protocol used to talk to the eeprom.  Sure, most i2c eeproms use
the same protocol, but an assumption cannot be made that that will
always be the case.  Plus, the namespace will collide with non-i2c
eeproms.  "i2c-eeprom" is better, but not great.  Before a value like
"i2c-eeprom" can be acceptable, it must be documented and reviewed as
to exactly what it means, and even then I'm uncomfortable with it.

However, on the other point, Jon is correct.  The first value in the
list should be "atmel,24c32", not "at24,24c32".

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

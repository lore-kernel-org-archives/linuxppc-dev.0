Return-Path: <Haiying.Wang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 62088DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 04:14:55 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l11HEp9P026244
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Feb 2007 10:14:51 -0700 (MST)
Received: from az33exm23.fsl.freescale.net (az33exm23.am.freescale.net
	[10.64.32.8])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l11HEnmu011264
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Feb 2007 11:14:50 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Differentiate between two e500 core (in mult-core e500)
Date: Thu, 1 Feb 2007 10:14:48 -0700
Message-ID: <DDEDA444F5BF0E41AC8649FB40392C2901D857BD@az33exm23.fsl.freescale.net>
In-Reply-To: <902386.32469.qm@web8409.mail.in.yahoo.com>
From: "Wang Haiying-r54964" <Haiying.Wang@freescale.com>
To: "vinay hegde" <thisismevinay@yahoo.co.in>,
	"Kumar Gala" <galak@kernel.crashing.org>
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

As Kumar said, you can differentiate cores by reading PIR register.
Core0 always starts up after Poweron. you can write a code to kick off
core1 in your bootcode, and direct core1's output in another serial
port, thus the both cores are running simutaneously, showing output in
different console. Then you test both cores as you planed.

Haiying =20

>-----Original Message-----
>From:=20
>linuxppc-embedded-bounces+haiying.wang=3Dfreescale.com@ozlabs.org
>=20
>[mailto:linuxppc-embedded-bounces+haiying.wang=3Dfreescale.com@oz
>labs.org] On Behalf Of vinay hegde
>Sent: Wednesday, January 31, 2007 11:15 PM
>To: Kumar Gala
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: Differentiate between two e500 core (in mult-core e500)
>
>Hi Kumar,
>
>Thanks for the pointers. This POST will run from the
>bootcode.=20
>
>I looked into the block diagram for MPC8572, and it
>seems that apart from L1 caches other component are
>shared (foe ex, L2, table look-up unit, gigE, SDRAM).
>So, I was wondering whether we can do something like -
>run _all_ the POST from core 1 and run only L1 cache
>test from core 2.=20
>
>Actually I referred 'e500 core Family Ref Manual', but
>could not get answer to my below question.=20
>
>Thanks,
>Vinay.
>
>--- Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>=20
>> On Jan 31, 2007, at 2:02 AM, vinay hegde wrote:
>>=20
>> > Hi,
>> >
>> > Actually, what I mean is, there are two
>> independent L1
>> > caches (one in first e500 core and other in second
>> > e500 core) in mpc8572. Now, if I am running cache
>> > test(POST) on mpc8572, I must somehow make sure
>> that
>> > it tests both the L1 caches. Generally, earlier
>> there
>> > used to be one e500 core, one L1 cache and hence
>> cache
>> > test does not need to query whether it is testing
>> L1
>> > of first core or L1 of second.
>> >
>> > So, how to make sure that I am testing L1 caches
>> on
>> > _both_ the e500 cores?
>>=20
>> Ok, will it sounds like just want to run your tests
>> on both cores.  =20
>> It depends on how you are invoking your tests today.
>>  Is it from =20
>> bootcode? or a Linux app or driver?
>>=20
>> - k
>>=20
>> >> On Jan 30, 2007, at 10:58 PM, vinay hegde wrote:
>> >>
>> >>> Hi,
>> >>>
>> >>> Sorry for the repeat mail on this, I forgot to
>> ask
>> >> the
>> >>> question;-)
>> >>>
>> >>> If anybody knows how to differentiate one e500
>> >> core
>> >>> from another (in multi-core proc's), please post
>> a
>> >>> message.
>> >>
>> >> Do you mean some software ID to know which core
>> you
>> >> are running on?
>> >>
>> >> If so the PIR should be used for this purpose.
>> >>
>> >> - k
>> >>
>> >>> --- vinay hegde <thisismevinay@yahoo.co.in>
>> wrote:
>> >>>
>> >>>> Hi,
>> >>>>
>> >>>> I have a need to write a POST sort of a test to
>> >> test
>> >>>> L1 data/inst cache residing on each of the e500
>> >> v2
>> >>>> multi-core seperately (for a network hardware).
>> >> This
>> >>>> is because multicore e500 has seperate L1
>> caches
>> >> and
>> >>>> shared L2 cache.
>> >>>>
>> >>>> This is for mpc8572. I learnt from this list
>> that
>> >>>> mpc8572 isn't out yet, but thought that
>> >>>> differentiating between e500 mult-cores has
>> >> nothing
>> >>>> to
>> >>>> do with mpc8572.
>> >>>>
>> >>>> Please let me know if you have any inputs.
>> >>>>
>> >>>> Thanks,
>> >>>> Vinay.
>> >>>>
>> >>>>
>> >>>>
>> >>>>
>> >>>
>> >>
>> >
>>
>______________________________________________________________________
>> >>
>> >>> ______________
>> >>>> Expecting? Get great news right away with email
>> >>>> Auto-Check.
>> >>>> Try the Yahoo! Mail Beta.
>> >>>>
>> >>>
>> >>
>> >
>>
>http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html
>> >>>>
>> >>>> _______________________________________________
>> >>>> Linuxppc-embedded mailing list
>> >>>> Linuxppc-embedded@ozlabs.org
>> >>>>
>> >>>
>> >>
>> >
>>
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> >>>>
>> >>>
>> >>>
>> >>>
>> >>>
>> >>>
>> >>
>> >
>>
>______________________________________________________________________
>> >>
>> >>> ______________
>> >>> Don't get soaked.  Take a quick peak at the
>> >> forecast
>> >>> with the Yahoo! Search weather shortcut.
>> >>>
>> >>
>> http://tools.search.yahoo.com/shortcuts/#loc_weather
>> >>> _______________________________________________
>> >>> Linuxppc-embedded mailing list
>> >>> Linuxppc-embedded@ozlabs.org
>> >>>
>> >>
>> >
>>
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> >>
>> >>
>> >
>> >
>> >
>> >
>> >
>>
>______________________________________________________________________
>>=20
>> > ______________
>> > 8:00? 8:25? 8:40? Find a flick in no time
>> > with the Yahoo! Search movie showtime shortcut.
>> > http://tools.search.yahoo.com/shortcuts/#news
>>=20
>>=20
>
>
>
>=20
>_______________________________________________________________
>_____________________
>Expecting? Get great news right away with email Auto-Check.=20
>Try the Yahoo! Mail Beta.
>http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html=20
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

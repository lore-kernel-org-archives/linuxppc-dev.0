Return-Path: <phileas-fogg@mail.ru>
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [94.100.177.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 23F372C02F7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 07:09:10 +1100 (EST)
Message-ID: <5138F3AB.5040401@mail.ru>
Date: Thu, 07 Mar 2013 21:08:11 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
References: <51320F53.9040000@mail.ru>
 <20130302141352.GG22941@blackmetal.musicnaut.iki.fi>
 <5132198C.8050300__15885.293405927$1362234296$gmane$org@mail.ru>
 <m2txotzs8y.fsf@igel.home> <1362288663.2969.15.camel@pasglop>
 <CAHj3AVni2t1-Hrn-jAKjsqo=0oFkVjkQ0KApNQk52buNTruDqQ@mail.gmail.com>
 <1362303524.2969.16.camel@pasglop> <51333F1C.4080605@mail.ru>
 <1362337429.2969.17.camel@pasglop> <5133A180.2040908@mail.ru>
 <1362338657.2969.20.camel@pasglop>
In-Reply-To: <1362338657.2969.20.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andreas Schwab <schwab@linux-m68k.org>, Denis Kirjanov <kirjanov@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/2013 08:24 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2013-03-03 at 20:16 +0100, Phileas Fogg wrote:
>> Benjamin Herrenschmidt wrote:
>>> Thanks. It looks like a bisection might indeed be the way to go...
>>>
>>> Out of curiosity, have you tried without some of your additional drivers ?
>>> Maybe one of them is the culprit...
>>>
>>> Cheers,
>>> Ben.
>>>
>>
>> Not yet, will do.
>> But I tested the official Debian Wheezy RC netinstall CD with Linux 3.2,
>> it has the same problem and hangs at boot on my machine.
>
> Ok, so it's definitely something about your configuration. Maybe
> something in the 11,2 support code chokes on single-chip configs, I
> don't have one of them to test, both mines are dual chip (ie. quad
> core).
>
> But it does look like a regression that should be bisectable, so let me
> know went you're done there and what you get.
>
> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

Hi,

i'm completely confused now.
I did a bisect between the following 2 commits: 
61c4f2c81c61f73549928dfd9f3e8f26aa36a8cf (good) Linux 2.6.39
and
55922c9d1b84b89cb946c777fddccb3247e7df2c (bad)  Linux 3.0-rc1
Both commist were tested by me on my machine. And Linux 3.0-rc1 hangs
on my machine but Linux 2.6.39 works fine.

And the bisect couldn't find the commit which causes hangs on my machine.
All commits which were provided by the bisect were bad.
And the commit before tha last bad bisect commit was bad too.
I did bisect several times, and got the same results.

Fo testing i used linux-3.0.y branch of
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git.

Did i miss something or do something wrong here ?

Regards

Return-Path: <phileas-fogg@mail.ru>
Received: from smtp36.i.mail.ru (smtp36.i.mail.ru [94.100.177.96])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 545912C039D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 08:08:43 +1100 (EST)
Message-ID: <5139019B.1050209@mail.ru>
Date: Thu, 07 Mar 2013 22:07:39 +0100
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
 <1362338657.2969.20.camel@pasglop> <5138F3AB.5040401@mail.ru>
 <1362687724.6977.1.camel@pasglop>
In-Reply-To: <1362687724.6977.1.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 03/07/2013 09:22 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-03-07 at 21:08 +0100, Phileas Fogg wrote:
>> And the bisect couldn't find the commit which causes hangs on my
>> machine.
>> All commits which were provided by the bisect were bad.
>> And the commit before tha last bad bisect commit was bad too.
>> I did bisect several times, and got the same results.
>>
>> Fo testing i used linux-3.0.y branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git.
>>
>> Did i miss something or do something wrong here ?
>
> Did git bisect go down a merge commit ? It does for me if I try that and
> asks to test that merge first. If you get that wrong it can get very
> confused.
>
> That's all I can think of... do you have the bisection log just in
> case ?
>
> Also you can use gitk -- arch/powerpc to look at the changes to powerpc
> code and try manually random points before/after that if you think
> bisect isn't doing the right thing.
>
> Cheers,
> Ben.
>
>

Thanks. I'll try manually some commits then.

And here is the bisect log:

git bisect log
# bad: [55922c9d1b84b89cb946c777fddccb3247e7df2c] Linux 3.0-rc1
# good: [61c4f2c81c61f73549928dfd9f3e8f26aa36a8cf] Linux 2.6.39
git bisect start '55922c9d1b84b89cb946c777fddccb3247e7df2c' 
'61c4f2c81c61f73549928dfd9f3e8f26aa36a8cf'
# bad: [c44dead70a841d90ddc01968012f323c33217c9e] Merge branch 
'usb-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6
git bisect bad c44dead70a841d90ddc01968012f323c33217c9e
# bad: [d93515611bbc70c2fe4db232e5feb448ed8e4cc9] macvlan: fix panic if 
lowerdev in a bond
git bisect bad d93515611bbc70c2fe4db232e5feb448ed8e4cc9
# bad: [9c6a02f41d10dc9fbf5dd42058e8846f38dd2d9a] sctp: make sctp over 
IPv6 work with IPsec
git bisect bad 9c6a02f41d10dc9fbf5dd42058e8846f38dd2d9a
# bad: [d30ee670f25ea8f265a2804e2a0a53804cac5185] net-bonding: Fix minor 
sparse complaints
git bisect bad d30ee670f25ea8f265a2804e2a0a53804cac5185
# bad: [b37e3b6d64358604960b35e8ecbb7aed22e0926e] Merge branch 'master' 
of git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6
git bisect bad b37e3b6d64358604960b35e8ecbb7aed22e0926e
# bad: [6c74608bd479bbe02ce330f83df43c3f535ed200] ssb: pci: trivial: 
drop useless pointer
git bisect bad 6c74608bd479bbe02ce330f83df43c3f535ed200
# bad: [83860c594f65945b1a2c99e84338e1145cd34890] ath9k_hw: remove 
pCap->tx_triglevel_max
git bisect bad 83860c594f65945b1a2c99e84338e1145cd34890
# bad: [f171760c558946c7a2e0ee310dfb968f9d4853c6] ath9k_hw: enable a 
BlockAck related fixup specific to AR9100
git bisect bad f171760c558946c7a2e0ee310dfb968f9d4853c6
# bad: [e600707b021efdc109e7becd467798da339ec26d] mwl8k: differentiate 
between WMM queues and AMPDU queues
git bisect bad e600707b021efdc109e7becd467798da339ec26d
# bad: [e7fc63388def06d2d1bdb6916748c92c037a42c6] ath9k_hw: Speedup 
register ops for HTC driver
git bisect bad e7fc63388def06d2d1bdb6916748c92c037a42c6
# bad: [6d64ab7f9240e3201fde3fd16ce4227bd795d2ab] ath9k_htc: Fix LED pin 
for AR9287 HTC device
git bisect bad 6d64ab7f9240e3201fde3fd16ce4227bd795d2ab
# bad: [22dd2fd283ea96b4d45185d3e861ef46005082f4] iwlwifi: remove 
duplicate initialization in __iwl_down()
git bisect bad 22dd2fd283ea96b4d45185d3e861ef46005082f4



Regards

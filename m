Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 98A1AB7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 02:51:03 +1100 (EST)
Date: Mon, 01 Nov 2010 08:51:26 -0700 (PDT)
Message-Id: <20101101.085126.71102684.davem@davemloft.net>
To: jwboyer@gmail.com
Subject: Re: All Applied micro boards are failing with current mainline kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTin3nsb6FfNtXfqjZCuV66mwKVOsKgmZpTABFDUJ@mail.gmail.com>
References: <AANLkTikQuUcAMZKqZ3Rz5HVzOs+63-Y4VYUo5-3EM30H@mail.gmail.com>
	<20101102023650.bc553e74.sfr@canb.auug.org.au>
	<AANLkTin3nsb6FfNtXfqjZCuV66mwKVOsKgmZpTABFDUJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: sfr@canb.auug.org.au, eric.dumazet@gmail.com, rsarmah@apm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	therbert@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Josh Boyer <jwboyer@gmail.com>
Date: Mon, 1 Nov 2010 11:39:47 -0400

> On Mon, Nov 1, 2010 at 11:36 AM, Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>> Hi Josh,
>>
>> On Mon, 1 Nov 2010 11:05:53 -0400 Josh Boyer <jwboyer@gmail.com> wro=
te:
>>>
>>> A few hints would be appreciated.
>>
>> Remove the call to netif_stop_queue() from emac_probe(). =A0Apparent=
ly,
>> calling this before register_netdev() is now wrong (maybe always was=
).
> =

> Yeah, I just discovered that myself.  I'm wondering
> =

> 1) why we do that in that function?

Because likely it was blindly copied from some other driver.

> 2) If it needs to be removed entirely, or moved to after the
> register_netdev call

Removed entirely.

> 3) If the call to netif_carrier_off also needs similar attention.

Not really.

> I can whip up a patch to remove those calls or move them after the
> register, but I don't want to do that without knowing which one is
> "right".

I've already taken care of this.

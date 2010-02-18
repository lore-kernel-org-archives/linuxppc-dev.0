Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82CBFB7CC2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 14:33:14 +1100 (EST)
Subject: Re: [PATCH] perf_event: e500 support
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4B7436BC.10406@freescale.com>
Date: Wed, 17 Feb 2010 21:33:06 -0600
Message-Id: <2035B8E4-B957-4C66-938E-95C0312DABD3@kernel.crashing.org>
References: <20100115214351.GA2869@loki.buserror.net>
	<20100210222932.GA9844@brick.ozlabs.ibm.com>
	<4B7349F2.8030802@freescale.com>
	<20100211030143.GA11245@brick.ozlabs.ibm.com>
	<4B7436BC.10406@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 11, 2010, at 10:56 AM, Scott Wood wrote:

> Paul Mackerras wrote:
>> On Wed, Feb 10, 2010 at 06:06:10PM -0600, Scott Wood wrote:
>>> Paul Mackerras wrote:
>>>>> Some limitations:
>>>>> - No threshold support -- need to figure out how to represent it =
in
>>>>> the event struct from userspace.
>>>> What does "threshold support" mean in this context?  Does it mean
>>>> something different from getting an interrupt after N events have =
been
>>>> counted?  Or does it mean counting instances where something takes
>>>> longer than a specific number of cycles?
>>> The latter.
>> OK.  I handled that on classic by using some extra high bits in the
>> event config for the threshold value.=20
>=20
> OK.
>=20
>> If you have a single threshold
>> value in hardware but more than one event that uses that threshold
>> value, then you will need to add a constraint that all threshold
>> events have to specify the same threshold.
>=20
> There's a separate threshold for each counter.
>=20
>> So, it sounds like you have a class of events which are the
>> thresholding events, and two constraints:
>> * at most two events in the thresholding event class
>> * at most four events in total
>> Are there other constraints?  Apart from the thresholding events, can
>> any event go on any counter, or can some events only be counted on =
one
>> particular counter?
>=20
> No, those are the only constraints.
>=20
>> If your constraints are just the two listed above (<=3D 2 threshold
>> events, <=3D 4 events total), then doing it the obvious =
straightforward
>> way is fine.  If there are other constraints as well, such as certain
>> events only being available on one specific PMC, then you should
>> consider reusing the constraint checking machinery from ppc64.
>=20
> I'll stick with the straightforward approach then.  If future chips =
have more complicated constraints we can revisit using the more general =
scheme.

Paul,

Other than splitting the patch did you have any other changes you wanted =
to see before we'd get an Ack.  I'd like to see this go in for .34.

- k=

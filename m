Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdNGW38ZRzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 19:01:38 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Shreyas B Prabhu
 <shreyas@linux.vnet.ibm.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org"
 <daniel.lezcano@linaro.org>, "anton@samba.org" <anton@samba.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2] cpuidle: Fix last_residency division
Date: Mon, 27 Jun 2016 08:59:10 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4E4E87@AcuExch.aculab.com>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <14940457.SEYBmqcunj@wuerfel> <576D595F.9090001@linux.vnet.ibm.com>
 <3748080.8f21OXxXix@wuerfel>
In-Reply-To: <3748080.8f21OXxXix@wuerfel>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann
> Sent: 24 June 2016 20:43
> On Friday, June 24, 2016 9:31:35 PM CEST Shreyas B Prabhu wrote:
> > > If those functions are called less often than cpuidle_enter_state(),
> > > we could just move the division there. Since the divisor is constant,
> > > do_div() can convert it into a multiply and shift, or we could use
> > > your the code you suggest above, or use a 32-bit division most of
> > > the time:
> > >
> > >       if (diff <=3D UINT_MAX)
> > >               diff_32 =3D (u32)diff / NSECS_PER_USEC;
> > >       else
> > >               diff_32 =3D div_u64(diff, NSECS_PER_USEC;
> > >
> > > which gcc itself will turn into a multiplication or series of
> > > shifts on CPUs on which that is faster.
> > >
> > I'm not sure which division method of the three suggested here to use.
> > Does anyone have a strong preference?
> >
>=20
> It depends on how accurate we want it and how long we expect
> the times to be. The optimization for the 4.2 second cutoff
> for doing a 32-bit division only makes sense if the majority
> of the sleep times are below that.

It also depends if the code actually cares about the length of 'long' sleep=
s.
I'd guess that for cpu idle 4.2 seconds is 'a long time', so the div_u64()
result could be treated as 4.2 seconds without causing grief.

Actually the cost of a 64bit divide after a 4 second sleep will be noise.
OTOH a 64bit divide after a sleep that lasted a few ns will be significant.

	David

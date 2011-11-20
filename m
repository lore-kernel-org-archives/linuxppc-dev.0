Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B9D11B722B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2011 03:46:17 +1100 (EST)
Subject: Re: [PATCH v2 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20111118180114.GB28562@schlenkerla.am.freescale.net>
Date: Sun, 20 Nov 2011 10:46:17 -0600
Message-Id: <7664F579-7BFD-48B7-91E4-972FB2A424E8@kernel.crashing.org>
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <4EC40406.1030408@freescale.com>
 <54122A43-37D1-438B-A0DD-289B7AE2BA0B@kernel.crashing.org>
 <20111118180114.GB28562@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 18, 2011, at 12:01 PM, Scott Wood wrote:

> On Fri, Nov 18, 2011 at 08:35:02AM -0600, Kumar Gala wrote:
>>=20
>> On Nov 16, 2011, at 12:42 PM, Scott Wood wrote:
>>=20
>>> On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
>>>> From: Li Yang <leoli@freescale.com>
>>>>=20
>>>> The timebase sync is not only necessary when using KEXEC. It should =
also
>>>> be used by normal boot up and cpu hotplug. Remove the ifdef added =
by
>>>> the KEXEC patch.
>>>=20
>>> Again, no it should not be used by normal boot up (whether KEXEC =
support
>>> is enabled or not).  We should only do timebase sync when we =
actually
>>> need to (when we've actually just reset a core), and we should do it =
the
>>> way U-Boot does rather than with smp-tbsync.c.
>>=20
>>=20
>> How can we do u-boot bases timebase sync after the system us up and
>> running?  For example would we losing some ticks of time in the case
>> that one core is up and we bring a second core online?
>=20
> Yes, we'll lose a small handful of ticks relative to wall clock time =
--
> but it'll be the same loss on all cores.  It's better than possibly
> having the timebase be imperfectly synchronized, and should complete =
more
> quickly.

Hmm, I wondering how many ticks it really is.

> This is only during intrusive events such as kexec or deep sleep (we =
only
> need to reset the core for jog on mpc8536 which has only one core).=20
> During deep sleep all cores' timebases will be stopped.  Kexec is
> resetting the kernel; it's not going to care what the old timebase =
was,
> and should resync from RTC.
>=20
> Even if we end up using this for some future power management mode =
where
> we take down some CPUs to the point their timebase stops, but never =
take
> down others, the time loss should be negligible (for comparison, =
what's
> the error tolerance on the crystal frequency?) and acceptable for what =
is
> still a fairly intrusive and rare event.

I'm also concerned about how this ends up working for p4080 when we have =
to sync up to 8 cores or more in the future.

- k=

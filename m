Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 8D4E9B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:57:24 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 04962-05 for <linuxppc-dev@lists.ozlabs.org>;
 Tue,  6 Mar 2012 09:57:09 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/4] powerpc/mpc8548: Add workaround for erratum
 NMG_SRIO135
Date: Tue, 6 Mar 2012 09:56:20 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6E8F@saturn3.aculab.com>
In-Reply-To: <1331025056-15983-4-git-send-email-chenhui.zhao@freescale.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Zhao Chenhui" <chenhui.zhao@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Issue:
> Applications using lwarx/stwcx instructions in the core to
> compete for a software lock or semaphore with a device on
> RapidIO using read atomic set, clr, inc, or dec in a similar
> manner may falsely result in both masters seeing the lock
> as "available". This could result in data corruption as
> both masters try to modify the same piece of data protected
> by the lock.
>=20
> Workaround:
> Set bits 13 and 29 of CCSR offset 0x01010 (EEBPCR register
> of the ECM) during initialization and leave them set
> indefinitely. This may slightly degrade overall system
> performance.

Might be worth actually saying what these bits do, and
why/when overall performance is affected.

Is the problem trying to do locked read-write cycles
on a slow peripheral bus?
Might be a case for just 'not doing that'.

	David

Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 01115DDF5B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 06:41:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx performance
Date: Fri, 25 Jul 2008 15:41:00 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04BC5B2A@ismail.innsys.innovsys.com>
In-Reply-To: <200807172332.18030.arnd@arndb.de>
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807172143.57576.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34E18@ismail.innsys.innovsys.com>
	<200807172332.18030.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Arnd Bergmann [mailto:arnd@arndb.de]=20
> On Thursday 17 July 2008, Rune Torgersen wrote:
> > Arnd Bergmann wrote:
> > > So again, nothing conclusive. I'm running out of ideas.
> >=20
> > Is the syscall path different or the same on ppc and powerpc?
> > Any differences in the task switching, irq handling or page fault
> > handling?
> >=20
>=20
> It's all different in suble ways, but those changes should only
> show up in the system time accounting, not user time accounting.

I've been running the workload this board will see. On a 2.6.18 kernel
%idle is ~50% and %wa (waiting for IO) is less than 1% most of the time.
On 2.6.25, the idle% is lower (by about 10-15%) and the %wa is
consistently hovering around 20-30% sometimes spiking to 100%.

The workload involves quite a bit of socket IO (TCP, UDP, Unix Sockets
and TIPC) and disk IO.
Any easy way of finding what is causing the wait for IO?

(Ive been trying to get lttng to work, but not any good results so far).

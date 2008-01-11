Return-Path: <linasvepstas@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 57073DDFFA
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 03:57:52 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so275164anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 08:57:51 -0800 (PST)
Message-ID: <3ae3aa420801110857l5e43fd56s5bd1c24ffac939f3@mail.gmail.com>
Date: Fri, 11 Jan 2008 10:57:51 -0600
From: "Linas Vepstas" <linasvepstas@gmail.com>
To: "Nathan Lynch" <ntl@pobox.com>
Subject: Re: [PATCH 1/8] pseries: phyp dump: Docmentation
In-Reply-To: <20080111012641.GX14201@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4782C026.8080302@austin.ibm.com>
	<3ae3aa420801090731r2e25e42awcae385b448e20b16@mail.gmail.com>
	<20080109184437.GU14201@localdomain>
	<3ae3aa420801091833i6cf32616o2a060579be1f3191@mail.gmail.com>
	<20080110031723.GA22168@lixom.net>
	<3ae3aa420801092012m5e47cbd7lc7a5f91842074af7@mail.gmail.com>
	<20080110162120.GA4831@lixom.net>
	<3ae3aa420801100834r6bd2750eqa7c8d29877350463@mail.gmail.com>
	<4786923E.9090902@austin.ibm.com> <20080111012641.GX14201@localdomain>
Cc: linuxppc-dev@ozlabs.org, lkessler@us.ibm.com, mahuja@us.ibm.com,
	Olof Johansson <olof@lixom.net>, strosake@us.ibm.com
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/01/2008, Nathan Lynch <ntl@pobox.com> wrote:
> Mike Strosaker wrote:
> >
> > At the risk of repeating what others have already said, the PHYP-assistance
> > method provides some advantages that the kexec method cannot:
> >  - Availability of the system for production use before the dump data is
> > collected.  As was mentioned before, some production systems may choose not
> > to operate with the limited memory initially available after the reboot,
> > but it sure is nice to provide the option.
>
> I'm more concerned that this design encourages the user to resume a
> workload *which is almost certainly known to result in a system crash*
> before collection of crash data is complete.  Maybe the gamble will
> pay off most of the time, but I wouldn't want to be working support
> when it doesn't.

Workloads that cause crashes within hours of startup tend to be
weeded-out/discovered during pre-production test of the system
to be deployed. Since its pre-production test, dumps can be
taken in a leisurely manner. Heck, even a session at the
xmon prompt can be contemplated.

The problem is when the crash only reproduces after days or
weeks of uptime, on a production machine.  Since the machine
is in production, its got to be brought back up ASAP.  Since
its crashing only after days/weeks, the dump should have
plenty of time to complete.  (And if it crashes quickly after
that reboot ... well, support people always welcome ways
in which a bug can be reproduced more quickly/easily).

--linas

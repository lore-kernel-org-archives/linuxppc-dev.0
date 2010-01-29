Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler5.mail.xerox.com (wbmler5.mail.xerox.com [13.13.138.230])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler5.mail.xerox.com",
	Issuer "AAA Certificate Services" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B6D6B7D15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Jan 2010 22:54:04 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Proc/CpuInfo - Timebase
Date: Fri, 29 Jan 2010 11:35:41 -0000
Message-ID: <929D3CED81F34E43887A393170D66FB9024A4E1E@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <b92b327b1001290323g4e586804ta6aad8fba098dc2a@mail.gmail.com>
References: <b92b327b1001290323g4e586804ta6aad8fba098dc2a@mail.gmail.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Ajay Jain" <ajay050@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On a powerpc system running linux, when I see cat /proc/cpuinfo, I
> find the value of timebase. Can somebody suggest on what is that, and
> how is it used?

It is the frequency (in Hz) of the clock that increments the Time Base
Register (TBR).

After reading TBR (or calculating a difference between two TBR values)
you can use "timebase" to convert to real time units, such as
microseconds/nanoseconds/picoseconds.

For debugging I log events together with a TBR reading, which I can
later convert to a time from reset (or a time from the moment when the
kernel initialised TBR to zero, which happens in some kernels).

Clive

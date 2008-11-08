Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72995DDE06
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 21:46:40 +1100 (EST)
Subject: Re: pmac_zilog debugging ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18709.10545.737455.611934@cargo.ozlabs.ibm.com>
References: <4914B549.9010805@hypersurf.com>
	<18709.10545.737455.611934@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 08 Nov 2008 21:46:29 +1100
Message-Id: <1226141189.13603.88.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-11-08 at 16:52 +1100, Paul Mackerras wrote:
> Kevin Diggs writes:
> 
> > pppd ttyS0 1200 satellites: netmask 255.255.255.0 lock crtscts mru 1064 noauth debug kdebug 7 
> > logfile /tmp/pppd.log local
> > 
> > to connect an 8600 to a laptop via ppp the link will lock up in short
> > order from "payloaded" pings. Any advice on how to figure out where it
> > is locking up? This command works fine to connect two x86 laptops. At
> > 1200 it does take a while for an xterm to show up, though.
> 
> Try it without the crtscts (actually, use nocrtscts instead of
> crtscts).  That will tell us whether it is hardware flow control
> causing problems.  IIRC, those mac serial ports didn't have all of
> RTS, CTS, CD and DTR, but I don't recall which one(s) were missing.
> 
> Also make sure you don't have the xonxoff option.

iirc, RTS is missing and on MacOS we typically have an option to use DTR
instead. There's also some issues with CTS polarity which is different
between the actual serial ports, vs. some internal modems or something
around those lines.

Ben

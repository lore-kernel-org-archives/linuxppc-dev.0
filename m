Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18709.10545.737455.611934@cargo.ozlabs.ibm.com>
Date: Sat, 8 Nov 2008 16:52:49 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: pmac_zilog debugging ...
In-Reply-To: <4914B549.9010805@hypersurf.com>
References: <4914B549.9010805@hypersurf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs writes:

> pppd ttyS0 1200 satellites: netmask 255.255.255.0 lock crtscts mru 1064 noauth debug kdebug 7 
> logfile /tmp/pppd.log local
> 
> to connect an 8600 to a laptop via ppp the link will lock up in short
> order from "payloaded" pings. Any advice on how to figure out where it
> is locking up? This command works fine to connect two x86 laptops. At
> 1200 it does take a while for an xterm to show up, though.

Try it without the crtscts (actually, use nocrtscts instead of
crtscts).  That will tell us whether it is hardware flow control
causing problems.  IIRC, those mac serial ports didn't have all of
RTS, CTS, CD and DTR, but I don't recall which one(s) were missing.

Also make sure you don't have the xonxoff option.

Paul.

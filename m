Return-Path: <stern+4a593f06@rowland.harvard.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82FD0B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 02:01:31 +1000 (EST)
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 19C03DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 02:01:29 +1000 (EST)
Date: Fri, 26 Jun 2009 11:54:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: abhishekkumar <abhishekkumar@tataelxsi.co.in>
Subject: Re: [Bugme-new] [Bug 13304] New: ehci_hcd module causing problems
	in using usb head phone
In-Reply-To: <4A44CB89.8040802@tataelxsi.co.in>
Message-ID: <Pine.LNX.4.44L0.0906261140540.2965-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, USB list <linux-usb@vger.kernel.org>,
	bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 26 Jun 2009, abhishekkumar wrote:

> PFA I am attaching dmesg file taken from /var/log/ and also the lines 
> which I got from dmesg command in different file named dmesgafter.txt.

I still don't see any lines about the headphone device in the log.  
Was the headphone plugged in during boot, or did you plug it in later?

> Then , periodic and registers files and also the usbmon log.

Here's what your "registers" file says:

> bus ps3_system_bus, device sb_05 (driver 10 Dec 2004)
> PS3 EHCI Host Controller
> EHCI ff.ff, hcd state 1
> structural params 0xffffffff
> capability params 0xffffffff
> status ffffffff Async Periodic Recl Halt IAA FATAL FLR PCD ERR INT
> command ffffffff park=3 ithresh=63 LReset IAAD Async Periodic period=?? Reset R
> intrenable ffffffff IAA FATAL FLR PCD ERR INT
> uframe ffffffff
> port 1 status ffffffff POWER OWNER sig=? RESET SUSPEND RESUME OCC OC PEC PE CSC
> port 2 status ffffffff POWER OWNER sig=? RESET SUSPEND RESUME OCC OC PEC PE CSC
> irq normal 30832 err 30 reclaim 84 (lost 1)
> complete 31221 unlink 10

This is very bad.  It indicates that the CPU was unable to communicate
with the EHCI controller at all!  All the memory-mapped I/O reads
returned 0xffffffff.  No wonder the keyboard and mouse stopped working.

I have no idea what could have caused this to happen.  Even if the 
controller had suffered a fatal error, you wouldn't see this.  It looks 
like the bus's connection to the controller was turned off.

I'm CC-ing the PS3 maintainer and mailing list.  Maybe people there can 
help.

> I am even not able to kill the application because it's not showing when 
> I use top command.
> 
> I addition to that I get some messages during boot up . they are
> Unable to  accept address for port 1 (error -62)
> usb cable may be bad
> Unable to  accept address for port 2 (error -62)

Those are normal.  They occur because your system loads ohci-hcd before 
ehci-hcd.  It should load ehci-hcd first.

Alan Stern

Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 73484B7081
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 03:15:02 +1000 (EST)
Received: from SG2EHSOBE006.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 0158CDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 03:15:01 +1000 (EST)
Message-ID: <4A450207.5000502@am.sony.com>
Date: Fri, 26 Jun 2009 10:14:47 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Bugme-new] [Bug 13304] New: ehci_hcd module causing problems
	in using usb head phone
References: <Pine.LNX.4.44L0.0906261140540.2965-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0906261140540.2965-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, USB list <linux-usb@vger.kernel.org>,
	abhishekkumar <abhishekkumar@tataelxsi.co.in>,
	bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 06/26/2009 08:54 AM, Alan Stern wrote:
> On Fri, 26 Jun 2009, abhishekkumar wrote:
>>
>> bus ps3_system_bus, device sb_05 (driver 10 Dec 2004)
>> PS3 EHCI Host Controller
>> EHCI ff.ff, hcd state 1
>> structural params 0xffffffff
>> capability params 0xffffffff
>> status ffffffff Async Periodic Recl Halt IAA FATAL FLR PCD ERR INT
>> command ffffffff park=3 ithresh=63 LReset IAAD Async Periodic period=?? Reset R
>> intrenable ffffffff IAA FATAL FLR PCD ERR INT
>> uframe ffffffff
>> port 1 status ffffffff POWER OWNER sig=? RESET SUSPEND RESUME OCC OC PEC PE CSC
>> port 2 status ffffffff POWER OWNER sig=? RESET SUSPEND RESUME OCC OC PEC PE CSC
>> irq normal 30832 err 30 reclaim 84 (lost 1)
>> complete 31221 unlink 10
> 
> This is very bad.  It indicates that the CPU was unable to communicate
> with the EHCI controller at all!  All the memory-mapped I/O reads
> returned 0xffffffff.  No wonder the keyboard and mouse stopped working.
> 
> I have no idea what could have caused this to happen.  Even if the 
> controller had suffered a fatal error, you wouldn't see this.  It looks 
> like the bus's connection to the controller was turned off.
> 
> I'm CC-ing the PS3 maintainer and mailing list.  Maybe people there can 
> help.
> 
> Alan Stern


There is a known but yet unfixed bug for the PS3's EHCI Async Periodic
(typically audio recording) device handling.  There are a few related
hardware errata that I have not yet implemented driver fixes for that
I think are causing it.  

I guess it is the same problem as reported by Abhishek since Andrew's
dmesg (http://www.osl.iu.edu/~afriedle/dmesg.txt) shows similar 
results.

More info is here:

  http://ozlabs.org/pipermail/cbe-oss-dev/2009-February/006365.html

I have bought a ART Tube USB device but have not had time to fix
this bug.  It is on my todo list.  Please feel free to make an
attempt.

Alan, thanks for your effort on this so far, sorry you didn't know
about the previous report.

-Geoff

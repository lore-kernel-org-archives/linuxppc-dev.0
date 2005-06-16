Return-Path: <per.hallsmark@t2data.com>
Received: from t2data.se (unknown [212.247.174.226])
	by ozlabs.org (Postfix) with ESMTP id 3959867B84
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 23:20:39 +1000 (EST)
Received: from WorldClient by t2data.se (MDaemon.PRO.v8.0.3.R)
	with ESMTP id md50000164348.msg
	for <linuxppc-embedded@ozlabs.org>; Thu, 16 Jun 2005 15:12:19 +0200
Date: Thu, 16 Jun 2005 15:12:15 +0200
From: "Per Hallsmark" <per.hallsmark@t2data.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <WorldClient-F200506161512.AA12150000@t2data.se>
In-Reply-To: <200506161456.44420.david.jander@protonic.nl>
References: <200506161456.44420.david.jander@protonic.nl>
Subject: Re: jffs2 freezing in gc for long time...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

A hot tip would be to configure either syslog to log to a logserver
or at least mount a tmpfs filesystem on /var/log.
Running a syslog could wear out the flash quite quickly, especially
during the development phases...

While you are at it, mount tmpfs's on /tmp and /var as well.

I believe JFFS2 suits very well in a embedded device, the system
just need to be configured for a such, since a "standard" linux
installation are more outlined for server/desktop usage ;-)

Regards,
Per

-----Original Message-----
From: David Jander <david.jander@protonic.nl>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 16 Jun 2005 14:56:43 +0200
Subject: jffs2 freezing in gc for long time...

> 
> Hi list,
> 
> I have the following situation:
> 
> CPU: MPC852T-100MHz
> Flash: 32Mbyte mirror-bit, 15Mbyte jffs2 partition rw-mouted
> Kernel: 2.4.25 (linuxppc_2_4_devel CVS from denx from a month ago or
> so, with 
> custom patches not concerning MTD at all). For completeness, it
> contains the 
> file fs/jffs2/gc.c version: gc.c,v 1.145 2005/02/09 09:09:01
> 
> Sometimes, I get this:
> During boot, mounting is quick, but when starting syslogd, it freezes
> for some 
> 20 minutes, then syslogd returns an error (exit!=0) but the daemon
> keeps 
> running in background, as well as the garbage collection thread from
> jffs2 
> for some additional minutes. During that time, everything like "ls -l"
> on a 
> certain directory of the flash partition freezes (status D is ps aux)
> until 
> the GC thread has finished.
> 
> I can understand that GC has to occur at some time, but is it normal
> that it 
> takes THAT long???
> 
> Is there a newer version of the MTD driver that does not present these 
> symptoms?
> 
> If this is supposed to work like that, I would say jffs2 is pretty
> useless for 
> any embedded system, so it is not supposed to be like that, right?
> RIGHT??
> 
> What am I doing wrong? Is the flash partition too big? Shouldn't I be
> using 
> jffs2?
> 
> Any advice is appreciated...
> 
> Greetings,
> 
> -- 
> David Jander
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

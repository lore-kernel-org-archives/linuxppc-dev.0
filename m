Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 2152767B86
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 22:56:51 +1000 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id D4ED04044
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 14:57:00 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 16 Jun 2005 14:56:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200506161456.44420.david.jander@protonic.nl>
Subject: jffs2 freezing in gc for long time...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi list,

I have the following situation:

CPU: MPC852T-100MHz
Flash: 32Mbyte mirror-bit, 15Mbyte jffs2 partition rw-mouted
Kernel: 2.4.25 (linuxppc_2_4_devel CVS from denx from a month ago or so, with 
custom patches not concerning MTD at all). For completeness, it contains the 
file fs/jffs2/gc.c version: gc.c,v 1.145 2005/02/09 09:09:01

Sometimes, I get this:
During boot, mounting is quick, but when starting syslogd, it freezes for some 
20 minutes, then syslogd returns an error (exit!=0) but the daemon keeps 
running in background, as well as the garbage collection thread from jffs2 
for some additional minutes. During that time, everything like "ls -l" on a 
certain directory of the flash partition freezes (status D is ps aux) until 
the GC thread has finished.

I can understand that GC has to occur at some time, but is it normal that it 
takes THAT long???

Is there a newer version of the MTD driver that does not present these 
symptoms?

If this is supposed to work like that, I would say jffs2 is pretty useless for 
any embedded system, so it is not supposed to be like that, right? RIGHT??

What am I doing wrong? Is the flash partition too big? Shouldn't I be using 
jffs2?

Any advice is appreciated...

Greetings,

-- 
David Jander

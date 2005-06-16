Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id C29C8679F2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 23:46:59 +1000 (EST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 45DAF4044
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 15:47:10 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 16 Jun 2005 15:46:53 +0200
References: <200506161456.44420.david.jander@protonic.nl>
	<WorldClient-F200506161512.AA12150000@t2data.se>
In-Reply-To: <WorldClient-F200506161512.AA12150000@t2data.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200506161546.54301.david.jander@protonic.nl>
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

On Thursday 16 June 2005 15:12, Per Hallsmark wrote:
> A hot tip would be to configure either syslog to log to a logserver
> or at least mount a tmpfs filesystem on /var/log.

We do this already.... the old way, with a ramdisk mounted on /var, and the 
rw-jffs2 partition mounted on /flash, then /var/log/xxx is a link to a 
directory in /flash/log/, where I place "persistent" log files.
/var/log/messages and friends reside on the ramdisk only.
/tmp is a symlink to /var/tmp.
Well, the use of tmpfs is indeed easier, so thanks anyway for the tip.

> Running a syslog could wear out the flash quite quickly, especially
> during the development phases...

That's true, but we need some logfiles (logged via syslogd) to be persistent 
and survive reboots at any moment, but we can't afford a system freeze just 
because the GC-routine needs to run.
I still need to study syslogd, to see what it does when writing becomes 
blocked for a long time. Does syslogd buffer? For how much data? Will I loose 
data in the end or will the calling process hang?
If someone has experience with this, and knows the answer to some of these 
questions, I'd be glad to hear it.

Greetings,

-- 
David Jander

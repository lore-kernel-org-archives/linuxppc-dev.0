Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DBAFBDDF48
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 13:20:38 +1000 (EST)
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id m853KXwS023936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 20:20:34 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id
	m853KW64012642
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Sep 2008 20:20:32 -0700
Date: Thu, 4 Sep 2008 20:20:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.27-rc5-mm1 mystery trace
Message-Id: <20080904202032.2299c2c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Booting the putative 2.6.27-rc5-mm1 lineup on the g5 I see:

io scheduler cfq registered
proc_dir_entry '00' already registered
Call Trace:
[c00000017a0fbae0] [c000000000012540] unrecov_restore+0x98d8/0x1220c (unreliable)
[c00000017a0fbb90] [c000000000149798] dst_error+0x117d3c/0x42ba04
[c00000017a0fbc40] [c000000000149c14] dst_error+0x1181b8/0x42ba04
[c00000017a0fbcc0] [c0000000001f9260] dst_error+0x1c7804/0x42ba04
[c00000017a0fbd60] [c0000000005ccc8c] _sinittext+0x25c8c/0x371d4
[c00000017a0fbde0] [c000000000009230] unrecov_restore+0x5c8/0x1220c
[c00000017a0fbee0] [c0000000005a7d90] _sinittext+0xd90/0x371d4
[c00000017a0fbf90] [c000000000026db4] fpdisable+0xa6f4/0xa884
nvidiafb: Device ID: 10de0141 
nvidiafb: CRTC0 analog not found
nvidiafb: CRTC1 analog found

from which I conclude

a) someone broke powerpc's kallsyms processing and

b) someone screwed up their procfs handling.

The output of `nm -n vmlinux' is at
http://userweb.kernel.org/~akpm/nm-n.txt.  You'll see that
c000000000012540 is actually somewhere inside proc_register().



This is stupid:

g5:/usr/src/25> gdb vmlinux
GNU gdb Red Hat Linux (6.3.0.0-1.21rh)
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "ppc-yellowdog-linux-gnu"..."/usr/src/25/vmlinux": not in executable format: File format not recognized

probably there's some command line magic to make it work, but there
shouldn't be.

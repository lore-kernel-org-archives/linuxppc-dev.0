Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF308DDE41
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 06:33:15 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH 50/59] sysctl: Move utsname sysctls to their own file
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656853154-git-send-email-ebiederm@xmission.com>
	<45AE5FDC.5050603@sw.ru>
Date: Wed, 17 Jan 2007 12:31:22 -0700
In-Reply-To: <45AE5FDC.5050603@sw.ru> (Kirill Korotaev's message of "Wed, 17
	Jan 2007 20:41:48 +0300")
Message-ID: <m1ps9d8n79.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	aharkes@cs.cmu.edu, tim@cyberelk.net, linux-scsi@vger.kernel.org,
	kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, rtc-linux@googlegroups.com,
	clemens@ladisch.de, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
	andrea@suse.de, linux390@de.ibm.com,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	containers@lists.osdl.org, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, aia21@cantab.net, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kirill Korotaev <dev@sw.ru> writes:

> Eric, though I personally don't care much:
> 1. I ask for not setting your authorship/copyright on the code which you just
> copied
>   from other places. Just doesn't look polite IMHO.

I can't claim complete ownership of the code, there was plenty of feed back
and contributions from others but the final form without a big switch
statement is mine.  I certainly can't claim the table, it has been in
that form for years.

If you notice I actually didn't say whose copyright it was :)  just
that I wrote the file.

If there are copyright claims I should include I will be happy to do that.
Mostly I was just trying to find some stupid boiler plate that would work.

> 2. I would propose to not introduce utsname_sysctl.c.
>   both files are too small and minor that I can't see much reasons splitting
> them.

The impact of moving this code out of sysctl.c is a major
simplification, to sysctl.c.  Putting them in their own file means we
can cleanly restrict the code to only be compiled CONFIG_SYSCTL is set.

It is a necessary first step to implementing a per process /proc/sys.

It reorganizes the ipc and utsname sysctl from a terribly fragile
structure to something that is robust and easy to follow.  Code
scattered all throughout sysctl.c was just a disaster.  We had
several instances of having to fix bugs with odd combinations of
CONFIG options, simply because the other spot that needed to be touched
wasn't obvious.

So from my perspective this is an extremely worthwhile change that
will make maintenance easier and is a small first step towards
some nice future functionality.

Eric

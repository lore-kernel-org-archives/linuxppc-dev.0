Return-Path: <herbert@13thfloor.at>
Received: from MAIL.13thfloor.at (MAIL.13thfloor.at [213.145.232.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.13thfloor.at", Issuer "Domain Service" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CBD0EDDEB7
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 09:48:05 +1100 (EST)
Date: Mon, 22 Jan 2007 23:24:42 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 50/59] sysctl: Move utsname sysctls to their own file
Message-ID: <20070122222442.GD11128@MAIL.13thfloor.at>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656853154-git-send-email-ebiederm@xmission.com>
	<45AE5FDC.5050603@sw.ru> <m1ps9d8n79.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m1ps9d8n79.fsf@ebiederm.dsl.xmission.com>
Cc: linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
	clemens@ladisch.de, ak@suse.de, linuxppc-dev@ozlabs.org,
	paulus@samba.org, aharkes@cs.cmu.edu, schwidefsky@de.ibm.com,
	tim@cyberelk.net, linux-scsi@vger.kernel.org,
	kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, xfs@oss.sgi.com,
	rtc-linux@googlegroups.com, heiko.carstens@de.ibm.com,
	linux-390@vm.marist.edu, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	Kirill Korotaev <dev@sw.ru>, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	containers@lists.osdl.org, linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 17, 2007 at 12:31:22PM -0700, Eric W. Biederman wrote:
> Kirill Korotaev <dev@sw.ru> writes:
> 
> > Eric, though I personally don't care much:
> > 1. I ask for not setting your authorship/copyright on the code which you just
> > copied
> >   from other places. Just doesn't look polite IMHO.
> 
> I can't claim complete ownership of the code, there was plenty of feed back
> and contributions from others but the final form without a big switch
> statement is mine.  I certainly can't claim the table, it has been in
> that form for years.
> 
> If you notice I actually didn't say whose copyright it was :)  just
> that I wrote the file.
> 
> If there are copyright claims I should include I will be happy to do that.
> Mostly I was just trying to find some stupid boiler plate that would work.

IMHO that is fine ...

> > 2. I would propose to not introduce utsname_sysctl.c.
> >   both files are too small and minor that I can't see much reasons splitting
> > them.
> 
> The impact of moving this code out of sysctl.c is a major
> simplification, to sysctl.c.  Putting them in their own file means we
> can cleanly restrict the code to only be compiled CONFIG_SYSCTL is set.
> 
> It is a necessary first step to implementing a per process /proc/sys.
> 
> It reorganizes the ipc and utsname sysctl from a terribly fragile
> structure to something that is robust and easy to follow.  Code
> scattered all throughout sysctl.c was just a disaster.  We had
> several instances of having to fix bugs with odd combinations of
> CONFIG options, simply because the other spot that needed to be touched
> wasn't obvious.
> 
> So from my perspective this is an extremely worthwhile change that
> will make maintenance easier and is a small first step towards
> some nice future functionality.

yep, agreed ...

best,
Herbert

> Eric
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers

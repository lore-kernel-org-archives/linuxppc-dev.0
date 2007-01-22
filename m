Return-Path: <herbert@13thfloor.at>
Received: from MAIL.13thfloor.at (MAIL.13thfloor.at [213.145.232.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.13thfloor.at", Issuer "Domain Service" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D86B9DDE46
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jan 2007 09:46:23 +1100 (EST)
Date: Mon, 22 Jan 2007 23:21:15 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Subject: Re: [PATCH 25/59] sysctl: C99 convert arch/frv/kernel/pm.c
Message-ID: <20070122222115.GC11128@MAIL.13thfloor.at>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656443582-git-send-email-ebiederm@xmission.com>
	<45AE5969.8030603@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45AE5969.8030603@sw.ru>
Cc: linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
	clemens@ladisch.de, ak@suse.de, linuxppc-dev@ozlabs.org,
	paulus@samba.org, aharkes@cs.cmu.edu, schwidefsky@de.ibm.com,
	tim@cyberelk.net, linux-scsi@vger.kernel.org,
	kurt.hackel@oracle.com, coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, rtc-linux@googlegroups.com,
	heiko.carstens@de.ibm.com, xfs@oss.sgi.com,
	xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	containers@lists.osdl.org, linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 17, 2007 at 08:14:17PM +0300, Kirill Korotaev wrote:
> another small minor note.
> 
> > From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> > 
> > Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> > ---
> >  arch/frv/kernel/pm.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
> >  1 files changed, 43 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
> > index c1840d6..aa50333 100644
> > --- a/arch/frv/kernel/pm.c
> > +++ b/arch/frv/kernel/pm.c
> > @@ -401,17 +401,53 @@ static int cm_sysctl(ctl_table *table, int __user *name, int nlen,
> >  
> >  static struct ctl_table pm_table[] =
> >  {
> > -	{CTL_PM_SUSPEND, "suspend", NULL, 0, 0200, NULL, &sysctl_pm_do_suspend},
> > -	{CTL_PM_CMODE, "cmode", &clock_cmode_current, sizeof(int), 0644, NULL, &cmode_procctl, &cmode_sysctl, NULL},
> > -	{CTL_PM_P0, "p0", &clock_p0_current, sizeof(int), 0644, NULL, &p0_procctl, &p0_sysctl, NULL},
> > -	{CTL_PM_CM, "cm", &clock_cm_current, sizeof(int), 0644, NULL, &cm_procctl, &cm_sysctl, NULL},
> > -	{0}
> > +	{
> > +		.ctl_name	= CTL_PM_SUSPEND,
> > +		.procname	= "suspend",
> > +		.data		= NULL,
> > +		.maxlen		= 0,
> > +		.mode		= 0200,
> > +		.proc_handler	= &sysctl_pm_do_suspend,
> > +	},
> > +	{
> > +		.ctl_name	= CTL_PM_CMODE,
> > +		.procname	= "cmode",
> > +		.data		= &clock_cmode_current,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &cmode_procctl,
> > +		.strategy	= &cmode_sysctl,
> > +	},
> > +	{
> > +		.ctl_name	= CTL_PM_P0,
> > +		.procname	= "p0",
> > +		.data		= &clock_p0_current,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &p0_procctl,
> > +		.strategy	= &p0_sysctl,
> > +	},
> > +	{
> > +		.ctl_name	= CTL_PM_CM,
> > +		.procname	= "cm",
> > +		.data		= &clock_cm_current,
> > +		.maxlen		= sizeof(int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &cm_procctl,
> > +		.strategy	= &cm_sysctl,
> > +	},
> > +	{ .ctl_name = 0}
> in next patch (26/59) you write just "{ }". .ctl_name = 0 not required here.

I'd prefer '{ 0 }' here, but I'm fine with the '{ .ctl_name = 0 }'
too, just '{ }' seems confusing, and it actually might get
misinterpreted too ..

best,
Herbert

> >  };
> >  
> >  static struct ctl_table pm_dir_table[] =
> >  {
> > -	{CTL_PM, "pm", NULL, 0, 0555, pm_table},
> > -	{0}
> > +	{
> > +		.ctl_name	= CTL_PM,
> > +		.procname	= "pm",
> > +		.mode		= 0555,
> > +		.child		= pm_table,
> > +	},
> > +	{ .ctl_name = 0}
> >  };
> >  
> >  /*
> 
> _______________________________________________
> Containers mailing list
> Containers@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/containers

Return-Path: <dev@sw.ru>
Received: from relay.sw.ru (mailhub.sw.ru [195.214.233.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AE98DDE25
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 04:07:22 +1100 (EST)
Message-ID: <45AE5969.8030603@sw.ru>
Date: Wed, 17 Jan 2007 20:14:17 +0300
From: Kirill Korotaev <dev@sw.ru>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 25/59] sysctl: C99 convert arch/frv/kernel/pm.c
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656443582-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656443582-git-send-email-ebiederm@xmission.com>
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

another small minor note.

> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/frv/kernel/pm.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
> index c1840d6..aa50333 100644
> --- a/arch/frv/kernel/pm.c
> +++ b/arch/frv/kernel/pm.c
> @@ -401,17 +401,53 @@ static int cm_sysctl(ctl_table *table, int __user *name, int nlen,
>  
>  static struct ctl_table pm_table[] =
>  {
> -	{CTL_PM_SUSPEND, "suspend", NULL, 0, 0200, NULL, &sysctl_pm_do_suspend},
> -	{CTL_PM_CMODE, "cmode", &clock_cmode_current, sizeof(int), 0644, NULL, &cmode_procctl, &cmode_sysctl, NULL},
> -	{CTL_PM_P0, "p0", &clock_p0_current, sizeof(int), 0644, NULL, &p0_procctl, &p0_sysctl, NULL},
> -	{CTL_PM_CM, "cm", &clock_cm_current, sizeof(int), 0644, NULL, &cm_procctl, &cm_sysctl, NULL},
> -	{0}
> +	{
> +		.ctl_name	= CTL_PM_SUSPEND,
> +		.procname	= "suspend",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0200,
> +		.proc_handler	= &sysctl_pm_do_suspend,
> +	},
> +	{
> +		.ctl_name	= CTL_PM_CMODE,
> +		.procname	= "cmode",
> +		.data		= &clock_cmode_current,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &cmode_procctl,
> +		.strategy	= &cmode_sysctl,
> +	},
> +	{
> +		.ctl_name	= CTL_PM_P0,
> +		.procname	= "p0",
> +		.data		= &clock_p0_current,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &p0_procctl,
> +		.strategy	= &p0_sysctl,
> +	},
> +	{
> +		.ctl_name	= CTL_PM_CM,
> +		.procname	= "cm",
> +		.data		= &clock_cm_current,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= &cm_procctl,
> +		.strategy	= &cm_sysctl,
> +	},
> +	{ .ctl_name = 0}
in next patch (26/59) you write just "{ }". .ctl_name = 0 not required here.


>  };
>  
>  static struct ctl_table pm_dir_table[] =
>  {
> -	{CTL_PM, "pm", NULL, 0, 0555, pm_table},
> -	{0}
> +	{
> +		.ctl_name	= CTL_PM,
> +		.procname	= "pm",
> +		.mode		= 0555,
> +		.child		= pm_table,
> +	},
> +	{ .ctl_name = 0}
>  };
>  
>  /*

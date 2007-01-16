Return-Path: <ioe-lkml@rameria.de>
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de
	[80.67.18.13]) by ozlabs.org (Postfix) with ESMTP id A99FCDDFC0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 10:36:24 +1100 (EST)
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 31/59] sysctl: C99 convert the ctl_tables in
	arch/mips/au1000/common/power.c
Date: Tue, 16 Jan 2007 23:20:17 +0100
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656551180-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656551180-git-send-email-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701162320.27961.ioe-lkml@rameria.de>
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	aharkes@cs.cmu.edu, schwidefsky@de.ibm.com, tim@cyberelk.net,
	codalist@telemann.coda.cs.cmu.edu, rtc-linux@googlegroups.com,
	linux-scsi@vger.kernel.org, kurt.hackel@oracle.com,
	coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@steeleye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, a.zummo@towertech.it,
	tony.luck@intel.com, linux-ntfs-dev@lists.sourceforge.net,
	netdev@vger.kernel.org, aia21@cantab.net,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, containers@lists.osdl.org,
	linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Eric,

On Tuesday, 16. January 2007 17:39, Eric W. Biederman wrote:
> diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
> index b531ab7..31256b8 100644
> --- a/arch/mips/au1000/common/power.c
> +++ b/arch/mips/au1000/common/power.c
> @@ -419,15 +419,41 @@ static int pm_do_freq(ctl_table * ctl, int write, struct file *file,

> +	{
> +		.ctl_name 	= CTL_UNNUMBERED,
> +		.procname	= "suspend",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_suspend
> +	},

No need for zero initialization for maxlen.

> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "sleep",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_sleep
> +	},

dito

> +	{
> +		.ctl_name	= CTL_UNNUMBERED,
> +		.procname	= "freq",
> +		.data		= NULL,
> +		.maxlen		= 0,
> +		.mode		= 0600,
> +		.proc_handler	= &pm_do_freq
> +	},
> +	{}
>  };

dito

Regards

Ingo Oeser

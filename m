Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 928E0DE0FD
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 14:18:46 +1100 (EST)
Subject: Re: [PATCH 36/59] sysctl: C99 convert ctl_tables entries in
	arch/ppc/kernel/ppc_htab.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <11689656602523-git-send-email-ebiederm@xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656602523-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 14:16:54 +1100
Message-Id: <1169003814.4778.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "<Andrew Morton" <akpm@osdl.org>, linux-mips@linux-mips.org,
	linux-parport@lists.infradead.org, heiko.carstens@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, aharkes@cs.cmu.edu, tim@cyberelk.net,
	linux-scsi@vger.kernel.org, kurt.hackel@oracle.com,
	coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, rtc-linux@googlegroups.com,
	clemens@ladisch.de, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
	andrea@suse.de, linux390@de.ibm.com,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	ak@suse.de, ralf@linux-mips.org, containers@lists.osdl.org,
	lethal@linux-sh.org, schwidefsky@de.ibm.com, aia21@cantab.net,
	philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-01-16 at 09:39 -0700, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> And make the mode of the kernel directory 0555 no one is allowed
> to write to sysctl directories.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/ppc/kernel/ppc_htab.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/ppc/kernel/ppc_htab.c b/arch/ppc/kernel/ppc_htab.c
> index bd129d3..77b20ff 100644
> --- a/arch/ppc/kernel/ppc_htab.c
> +++ b/arch/ppc/kernel/ppc_htab.c
> @@ -442,11 +442,16 @@ static ctl_table htab_ctl_table[]={
>  		.mode		= 0644,
>  		.proc_handler	= &proc_dol2crvec,
>  	},
> -	{ 0, },
> +	{}
>  };
>  static ctl_table htab_sysctl_root[] = {
> -	{ 1, "kernel", NULL, 0, 0755, htab_ctl_table, },
> - 	{ 0,},
> +	{
> +		.ctl_name	= CTL_KERN,
> +		.procname	= "kernel",
> +		.mode		= 0555,
> +		.child		= htab_ctl_table,
> +	},
> +	{}
>  };
>  
>  static int __init

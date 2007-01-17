Return-Path: <dev@sw.ru>
Received: from relay.sw.ru (mailhub.sw.ru [195.214.233.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87335DE044
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 04:15:34 +1100 (EST)
Message-ID: <45AE5B8A.5040407@sw.ru>
Date: Wed, 17 Jan 2007 20:23:22 +0300
From: Kirill Korotaev <dev@sw.ru>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 33/59] sysctl: s390 move sysctl definitions to sysctl.h
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
	<11689656572714-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11689656572714-git-send-email-ebiederm@xmission.com>
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

IDs not sorted in enum. see below.

> From: Eric W. Biederman <ebiederm@xmission.com> - unquoted
> 
> We need to have the the definition of all top level sysctl
> directories registers in sysctl.h so we don't conflict by
> accident and cause abi problems.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/s390/appldata/appldata.h |    3 +--
>  arch/s390/kernel/debug.c      |    1 -
>  arch/s390/mm/cmm.c            |    4 ----
>  include/linux/sysctl.h        |    7 +++++++
>  4 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/appldata/appldata.h b/arch/s390/appldata/appldata.h
> index 0429481..4069b81 100644
> --- a/arch/s390/appldata/appldata.h
> +++ b/arch/s390/appldata/appldata.h
> @@ -21,8 +21,7 @@
>  #define APPLDATA_RECORD_NET_SUM_ID	0x03	/* must be < 256 !     */
>  #define APPLDATA_RECORD_PROC_ID		0x04
>  
> -#define CTL_APPLDATA 		2120	/* sysctl IDs, must be unique */
> -#define CTL_APPLDATA_TIMER 	2121
> +#define CTL_APPLDATA_TIMER 	2121	/* sysctl IDs, must be unique */
>  #define CTL_APPLDATA_INTERVAL 	2122
>  #define CTL_APPLDATA_MEM	2123
>  #define CTL_APPLDATA_OS		2124
> diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
> index bb57bc0..c81f8e5 100644
> --- a/arch/s390/kernel/debug.c
> +++ b/arch/s390/kernel/debug.c
> @@ -852,7 +852,6 @@ debug_finish_entry(debug_info_t * id, debug_entry_t* active, int level,
>  static int debug_stoppable=1;
>  static int debug_active=1;
>  
> -#define CTL_S390DBF 5677
>  #define CTL_S390DBF_STOPPABLE 5678
>  #define CTL_S390DBF_ACTIVE 5679
>  
> diff --git a/arch/s390/mm/cmm.c b/arch/s390/mm/cmm.c
> index 607f50e..df733d5 100644
> --- a/arch/s390/mm/cmm.c
> +++ b/arch/s390/mm/cmm.c
> @@ -256,10 +256,6 @@ cmm_skip_blanks(char *cp, char **endp)
>  }
>  
>  #ifdef CONFIG_CMM_PROC
> -/* These will someday get removed. */
> -#define VM_CMM_PAGES		1111
> -#define VM_CMM_TIMED_PAGES	1112
> -#define VM_CMM_TIMEOUT		1113
>  
>  static struct ctl_table cmm_table[];
>  
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 71c16b4..56d0161 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -73,6 +73,8 @@ enum
>  	CTL_SUNRPC=7249,	/* sunrpc debug */
>  	CTL_PM=9899,		/* frv power management */
>  	CTL_FRV=9898,		/* frv specific sysctls */
> +	CTL_S390DBF=5677,	/* s390 debug */
> +	CTL_APPLDATA=2120,	/* s390 appldata */
<<<< not sorted by ID? imho should be sorted. otherwise can'be unnotied when inserted above.

>  };
>  
>  /* CTL_BUS names: */
> @@ -205,6 +207,11 @@ enum
>  	VM_PANIC_ON_OOM=33,	/* panic at out-of-memory */
>  	VM_VDSO_ENABLED=34,	/* map VDSO into new processes? */
>  	VM_MIN_SLAB=35,		 /* Percent pages ignored by zone reclaim */
> +
> +	/* s390 vm cmm sysctls */
> +	VM_CMM_PAGES=1111,
> +	VM_CMM_TIMED_PAGES=1112,
> +	VM_CMM_TIMEOUT=1113,
>  };
>  
>  

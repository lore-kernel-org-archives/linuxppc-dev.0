Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BX6h4Jl1zF0x7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 05:38:04 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5LJYpSN101864
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 15:38:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jrfbf7b5f-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 15:38:01 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 21 Jun 2018 13:38:01 -0600
Subject: Re: [PATCH v04 9/9] hotplug/pmt: Update topology after PMT
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
References: <71195eb3-e11c-f586-d359-7026bdfd9a8a@linux.vnet.ibm.com>
 <201806211048.moFJfljN%fengguang.wu@intel.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Thu, 21 Jun 2018 14:37:57 -0500
MIME-Version: 1.0
In-Reply-To: <201806211048.moFJfljN%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <6508b229-80fe-6dcd-1afe-e85b8cbc48d6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I posted the wrong copy of the file the first time.
That is what broke here.  I posted the correction almost
immediately to the list.  The correct one has

Message ID <8c437fe5-632c-a7ed-1f11-66c4578a1d93@linux.vnet.ibm.com>

Sorry for the inconvenience.
Michael

On 06/20/2018 09:13 PM, kbuild test robot wrote:
> Hi Michael,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.18-rc1 next-20180620]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Michael-Bringmann/powerpc-hotplug-Update-affinity-for-migrated-CPUs/20180621-085543
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/platforms/pseries/dlpar.c: In function 'dlpar_pmt':
>>> arch/powerpc/platforms/pseries/dlpar.c:453:2: error: implicit declaration of function 'rebuild_sched_domains' [-Werror=implicit-function-declaration]
>      rebuild_sched_domains();
>      ^~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> vim +/rebuild_sched_domains +453 arch/powerpc/platforms/pseries/dlpar.c
> 
>    435	
>    436	static int dlpar_pmt(struct pseries_hp_errorlog *work)
>    437	{
>    438		struct list_head *pos, *q;
>    439	
>    440		ssleep(15);
>    441	
>    442		list_for_each_safe(pos, q, &dlpar_delayed_list) {
>    443			struct pseries_hp_errorlog *tmp;
>    444	
>    445			tmp = list_entry(pos, struct pseries_hp_errorlog, list);
>    446			handle_dlpar_errorlog(tmp);
>    447	
>    448			list_del(pos);
>    449			kfree(tmp);
>    450		}
>    451	
>    452		ssleep(5);
>  > 453		rebuild_sched_domains();
>    454	
>    455		return 0;
>    456	}
>    457	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com

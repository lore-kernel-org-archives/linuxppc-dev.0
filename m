Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysFCz4zRjzF0HQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 21:27:11 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB6ANnHp135857
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Dec 2017 05:27:08 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2epdy12twa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 05:27:08 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Wed, 6 Dec 2017 03:27:06 -0700
Subject: Re: [linux-next][41e83b9][gcc 4.8.5] make modules fail at
 net/netfilter/xt_bpf.ko
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 06 Dec 2017 15:56:59 +0530
In-Reply-To: <20171205180650.GV21978@ZenIV.linux.org.uk>
References: <1512484991.13113.11.camel@abdul>
 <20171205180650.GV21978@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512556019.13113.18.camel@abdul>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-12-05 at 18:06 +0000, Al Viro wrote:
> On Tue, Dec 05, 2017 at 08:13:11PM +0530, Abdul Haleem wrote:
> > Hi Al Viro,
> > 
> > Today's next kernel build failed with commit 41e83b9: fix "netfilter:
> > xt_bpf: Fix XT_BPF_MODE_FD_PINNED
> > 
> > Machine Type: Power 7
> > kernel version: 4.15.0-rc2-next-20171204
> > kernel config: attached
> > test: 'make modules'
> > 
> > ERROR: ".bpf_prog_get_type_path" [net/netfilter/xt_bpf.ko] undefined!
> > 
> > Kernel built fine when bad commit is reverted.
> 
> In the same commit there's
> 
> +EXPORT_SYMBOL(bpf_prog_get_type_path);
> 
> so I really wonder WTF is going on...
> 
> Oh, I see.  !BPF_SYSCALL and NETFILTER_XT_MATCH_BPF in .config triggers
> that.  Incremental (to be folded into the commit in question) follows:

Thank you for the patch, the build succeeded. But I see some new
warnings.

./include/linux/bpf.h: In function ‘bpf_prog_get_type_path’:
./include/linux/bpf.h:515:2: warning: return makes pointer from integer
without a cast [enabled by default]
  return -EOPNOTSUPP;
  ^

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre

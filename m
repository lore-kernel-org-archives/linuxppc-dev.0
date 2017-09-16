Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvS6y0HsczDrhx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 19:45:13 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8G9iwOl046631
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 05:45:11 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d10gfj6ks-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 05:45:11 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 19:45:09 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8G9hpLL28115030
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 19:43:51 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8G9hoi7018133
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 19:43:51 +1000
Date: Sat, 16 Sep 2017 15:13:45 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 Jessica Yu <jeyu@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] powerpc64: Add .opd based function descriptor
 dereference
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
 <20170916035347.19705-4-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170916035347.19705-4-sergey.senozhatsky@gmail.com>
Message-Id: <20170916094345.d332z3odceqiyrll@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/09/16 12:53PM, Sergey Senozhatsky wrote:
> We are moving towards separate kernel and module function descriptor
> dereference callbacks. This patch enables it for powerpc64.
> 
> For pointers that belong to the kernel
> -  Added __start_opd and __end_opd pointers, to track the kernel
>    .opd section address range;
> 
> -  Added dereference_kernel_function_descriptor(). Now we
>    will dereference only function pointers that are within
>    [__start_opd, __end_opd];
> 
> For pointers that belong to a module
> -  Added dereference_module_function_descriptor() to handle module
>    function descriptor dereference. Now we will dereference only
>    pointers that are within [module->opd.start, module->opd.end].

Would it be simpler to just use kernel_text_address() and dereference 
everything else? See commit 83e840c770f2c5 ("powerpc64/elfv1: Only 
dereference function descriptor for non-text symbols") for a related 
patch.

- Naveen

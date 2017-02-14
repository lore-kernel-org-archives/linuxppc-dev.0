Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN0js1CCMzDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:36:16 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EBXbQO097549
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 06:36:14 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kwv4g3p1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 06:36:14 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 04:36:13 -0700
Subject: Re: [PATCH v3 1/2] powerpc: Emulation support for load/store
 instructions on LE
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1487063803-10848-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <87d1elm5uu.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org,
 lsorense@csclub.uwaterloo.ca, oohall@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org, chris@distroguy.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 17:05:57 +0530
MIME-Version: 1.0
In-Reply-To: <87d1elm5uu.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <58A2EB9D.4080506@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Michael,

On Tuesday 14 February 2017 03:50 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>
>> emulate_step() uses a number of underlying kernel functions that were
>> initially not enabled for LE. This has been rectified since.
> When exactly? ie. which commit.

I found couple of commits:

6506b4718b ("powerpc: Fix Unaligned Loads and Stores")
dbc2fbd7c2 ("powerpc: Fix Unaligned LE Floating Point Loads and Stores")

There may be more.

Patch2 is to test emulate_step() for basic load/store instructions and it
seems to be working fine on LE.

>
> Should we backport this? ie. is it actually a bug people are hitting in
> the real world much?

Yes, we should backport this. kernel-space hw-breakpoint feature is broken
on LE without this. This is on ppc64le:

  $ sudo cat /proc/kallsyms  | grep pid_max
    c00000000116998c D pid_max

  $ sudo ./perf record -a --event=mem:0xc00000000116998c sleep 10


Before patch:
  It does not record any data and throws below warning.

  $ dmesg
    [  817.895573] Unable to handle hardware breakpoint. Breakpoint at 0xc00000000116998c will be disabled.
    [  817.895581] ------------[ cut here ]------------
    [  817.895588] WARNING: CPU: 24 PID: 2032 at arch/powerpc/kernel/hw_breakpoint.c:277 hw_breakpoint_handler+0x124/0x230
    ...

After patch:
  It records data properly.

  $ sudo ./perf report --stdio
    ...
    # Samples: 36  of event 'mem:0xc00000000116998c'
    # Event count (approx.): 36
    #
    # Overhead  Command        Shared Object     Symbol     
    # ........  .............  ................  .............
    #
        63.89%  kdumpctl       [kernel.vmlinux]  [k] alloc_pid
        27.78%  opal_errd      [kernel.vmlinux]  [k] alloc_pid
         5.56%  kworker/u97:4  [kernel.vmlinux]  [k] alloc_pid
         2.78%  systemd        [kernel.vmlinux]  [k] alloc_pid



>
> cheers
>

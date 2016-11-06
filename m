Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBlHG20wvzDvPY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 05:59:20 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA6IwX8V085598
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Nov 2016 13:59:18 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26j7pynaxd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 13:59:18 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Sun, 6 Nov 2016 11:59:17 -0700
Subject: Re: [PATCH 1/3] powerpc: Emulation support for load/store
 instructions on LE
To: Anton Blanchard <anton@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1478076783-2872-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1478076783-2872-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161103080412.68240cda@kryten> <581ACDF2.1010409@linux.vnet.ibm.com>
 <8737j8opwb.fsf@concordia.ellerman.id.au>
 <581B110F.9050805@linux.vnet.ibm.com>
 <e993dc5c-7a90-e43b-b761-a70a79b3d1d9@au1.ibm.com>
 <581C1D32.50108@linux.vnet.ibm.com> <20161106063151.3ef04e9e@kryten>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, chris@distroguy.com,
 aneesh.kumar@linux.vnet.ibm.com, ast@kernel.org,
 linux-kernel@vger.kernel.org, oss@buserror.net,
 paul.gortmaker@windriver.com, duwe@lst.de,
 lsorense@csclub.uwaterloo.ca, bauerman@linux.vnet.ibm.com,
 oohall@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org, viro@zeniv.linux.org.uk,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 7 Nov 2016 00:29:04 +0530
MIME-Version: 1.0
In-Reply-To: <20161106063151.3ef04e9e@kryten>
Content-Type: text/plain; charset=windows-1252
Message-Id: <581F7D78.1040008@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sunday 06 November 2016 01:01 AM, Anton Blanchard wrote:
> Hi,
>
>> kprobe, uprobe, hw-breakpoint and xmon are the only user of
>> emulate_step.
>>
>> Kprobe / uprobe single-steps instruction if they can't emulate it, so
>> there is no problem with them. As I mention, hw-breakpoint is broken.
>> However I'm not sure about xmon, I need to check that.
> I was mostly concerned that it would impact kprobes. Sounds like we are
> ok there.
>
>> So yes, there is no user-visible feature that depends on this.
> Aren't hardware breakpoints exposed via perf? I'd call perf
> user-visible.


Thanks Anton, That's a good catch. I tried this on ppc64le:

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


-Ravi

Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swPqk5RgkzDt3V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 22:04:18 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id os4so1917581pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 04:04:18 -0700 (PDT)
Subject: Re: [PowerPC] Kernel panic while running CPU toggle test on 4.8.0
 kernel
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, ego@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com
References: <ad110c25-00bc-2800-0376-d5fa60c39999@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <a8dc0b1f-7f2a-db5b-87fa-37d61adcf03b@gmail.com>
Date: Fri, 14 Oct 2016 22:04:19 +1100
MIME-Version: 1.0
In-Reply-To: <ad110c25-00bc-2800-0376-d5fa60c39999@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 14/10/16 17:24, Abdul Haleem wrote:
> Hi,
> 
> Kernel Oops, followed by kernel panic seen while running rcutorture test on 4.8.0 kernel
> Machine Type : PowerPC Bare Metal
> 
> RCU torture test steps:
> 1. modprobe rcutorture
> 2. start CPU offline and online while torture test is running
> 
> dmesg start flooded with Oops messages following kernel panic resulted in machine reboot.

Good bug. The report looks good


Any chance you could add ftrace_dump_on_oops to command line and start this test
with tracing enabled? Otherwise, getting the line via addr2line of select_task_rq_fair+0xac8/0xca0
would be helpful.

It would also be nice to know the CFAR value (CFAR: c0000000000089e0) using
addr2line

Balbir Singh.

Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhmtq2Wt3zF1G1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 17:43:15 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1F6elAn018928
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 01:43:12 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4wduwnya-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 01:43:12 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 15 Feb 2018 06:43:10 -0000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Douglas Miller <dougmill@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param
 xmon=off
In-Reply-To: <87eflnre7w.fsf@concordia.ellerman.id.au>
References: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
 <CAKTCnz=cDmeU6rvqpHf_oW-JjtcVSNjeSQpwzwRMo5U_g+hAwg@mail.gmail.com>
 <8737264c91.fsf@vajain21.in.ibm.com>
 <87eflnre7w.fsf@concordia.ellerman.id.au>
Date: Thu, 15 Feb 2018 12:13:03 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d116wy6g.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for looking into this patch Mpe.

Michael Ellerman <mpe@ellerman.id.au> writes:
> <snip>
>
> But the same crash happens with XMON_DEFAULT=n and nothing on the
> command line.
Yes, XMON_DEFAULT=n and empty boot command line implies xmon=off hence
you will see the same issue and this patch should fix that issue too.

>
> The problem is not xmon=off on the command line.
>
> The problem is that when xmon_on = false and we enter xmon via sysrq and
> then set breakpoints, we need to enable xmon_on before leaving xmon.
>
Agree on both the points made.

> So this is a bug introduced by:
>
>   3b5bf42b81d5 ("powerpc/xmon: Fix an unexpected xmon on/off state change")
>
>
> How to fix it is not entirely clear. In general I like the behaviour we
> have since the above commit, ie. quickly dropping into xmon and
> inspecting something doesn't leave xmon enabled, which then causes the
> system not to kdump/reboot later.
Agree on the convenience factor of leaving the xmon console
enabled. However we still need a way to disable xmon completely at
kernel-boot time. Leaving xmon enabled even if 'xmon=off' is provided at
command line is counter intuitive.

>
> What would be nice is if we keep that behaviour, but any action you take
> in xmon that requires xmon to remain resident, ie. setting a breakpoint,
> calls a function which makes sure xmon_on = true and if it wasn't prints
> a nice message saying "Turning xmon on due to breakpoint insertion" or
> something.
That makes sense to me and sounds workable. However we already have a
debugfs interface to enable/disable xmon debugger hook. I can also tweak
this interface to also register the sysrq key when xmon is enabled. This
should provide the user the ability to still use xmon if they want to
after the system has booted with xmon=off.

>
> cheers
>

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMpb26LVlzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:59:42 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E3wv4J068421
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:59:40 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kfyayq7s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 22:59:39 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 13:59:37 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 493132CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:59:34 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E3xQqk6226070
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:59:34 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E3x1bZ027581
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 14:59:01 +1100
Subject: Re: [PATCH] powerpc/xmon: add debugfs entry for xmon
To: Nicholas Piggin <npiggin@gmail.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
References: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20170214123540.38b995cb@roar.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, xinhui.pan@linux.vnet.ibm.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 11:58:42 +0800
MIME-Version: 1.0
In-Reply-To: <20170214123540.38b995cb@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <559244cc-dcc0-a477-b51b-7417a61158ed@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2017/2/14 10:35, Nicholas Piggin 写道:
> On Mon, 13 Feb 2017 19:00:42 -0200
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> wrote:
>
>> Currently the xmon debugger is set only via kernel boot command-line.
>> It's disabled by default, and can be enabled with "xmon=on" on the
>> command-line. Also, xmon may be accessed via sysrq mechanism, but once
>> we enter xmon via sysrq,  it's  kept enabled until system is rebooted,
>> even if we exit the debugger. A kernel crash will then lead to xmon
>> instance, instead of triggering a kdump procedure (if configured), for
>> example.
>>
>> This patch introduces a debugfs entry for xmon, allowing user to query
>> its current state and change it if desired. Basically, the "xmon" file
>> to read from/write to is under the debugfs mount point, on powerpc
>> directory. Reading this file will provide the current state of the
>> debugger, one of the following: "on", "off", "early" or "nobt". Writing
>> one of these states to the file will take immediate effect on the debugger.
>>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>> ---
>> * I had this patch partially done for some time, and after a discussion
>> at the kernel slack channel latest week, I decided to rebase and fix
>> some remaining bugs. I'd change 'x' option to always disable the debugger,
>> since with this patch we can always re-enable xmon, but today I noticed
>> Pan's patch on the mailing list, so perhaps his approach of adding a flag
>> to 'x' option is preferable. I can change this in a V2, if requested.
>> Thanks in advance!
>
> xmon state changing after the first sysrq+x violates principle of least
> astonishment, so I think that should be fixed.
>
hi, Nick
yes, as long as xmon is disabled during boot, it should still be disabled after existing xmon.
My patch does not fix that as it need people add one more char 'z' following 'x'.
I will provide a new patch to fix that.

> Then the question is, is it worth making it runtime configurable with xmon
> command or debugfs tunables?
>
They are options for people to turn xmon features on or off. Maybe people needn't this.
However I am not a fan  of debugfs this time as I am used to using xmon cmds. :)

Hi, Guilherme
So in the end, my thought is that: 1) cmd x|X will exit xmon and keep xmon in the original state(indicated by var xmon_off).
2) Then add options to turn some features on/off. And debugfs maybe not fit for this. But I am also wondering at same time, are people needing this?

thanks
xinhui

> Thanks,
> Nick
>

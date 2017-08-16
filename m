Return-Path: <brking@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXldk1Fg0zDr1y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 09:18:34 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7GNHMGZ044155
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 19:18:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ccudgujmh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 19:18:31 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 16 Aug 2017 19:18:30 -0400
Subject: Re: [BUG][bisected 270065e] linux-next fails to boot on powerpc
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "hare@suse.com" <hare@suse.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
References: <1502902815.3305.22.camel@abdul.in.ibm.com>
 <1502904072.2421.3.camel@wdc.com>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 16 Aug 2017 18:18:25 -0500
MIME-Version: 1.0
In-Reply-To: <1502904072.2421.3.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <2f686064-3e32-df8d-134f-962b5181da9d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/16/2017 12:21 PM, Bart Van Assche wrote:
> On Wed, 2017-08-16 at 22:30 +0530, Abdul Haleem wrote:
>> As of next-20170809, linux-next on powerpc boot hung with below trace
>> message.
>>
>> [ ... ]
>>
>> A bisection resulted in first bad commit (270065e92 - scsi: scsi-mq:
>> Always unprepare ...) in the merge branch 'scsi/for-next'
>>
>> System booted fine when the below commit is reverted: 
>>
>> commit 270065e92c317845d69095ec8e3d18616b5b39d5
>> Author: Bart Van Assche <bart.vanassche@wdc.com>
>> Date:   Thu Aug 3 14:40:14 2017 -0700
>>
>>     scsi: scsi-mq: Always unprepare before requeuing a request
> 
> Hello Brian and Michael,
> 
> Do you agree that this probably indicates a bug in the PowerPC block driver
> that is used to access the boot disk? Anyway, since a solution is not yet
> available, I will submit a revert for this patch.

I've been looking at this a bit, and can recreate the issue, but haven't
got to root cause of the issue as of yet. If I do a sysrq-w while the system is hung
during boot I see this:

[   25.561523] Workqueue: events_unbound async_run_entry_fn
[   25.561527] Call Trace:
[   25.561529] [c0000001697873f0] [c000000169701600] 0xc000000169701600 (unreliable)
[   25.561534] [c0000001697875c0] [c00000000001ab78] __switch_to+0x2e8/0x430
[   25.561539] [c000000169787620] [c00000000091ccb0] __schedule+0x310/0xa00
[   25.561543] [c0000001697876f0] [c00000000091d3e0] schedule+0x40/0xb0
[   25.561548] [c000000169787720] [c000000000921e40] schedule_timeout+0x200/0x430
[   25.561553] [c000000169787810] [c00000000091db10] io_schedule_timeout+0x30/0x70
[   25.561558] [c000000169787840] [c00000000091e978] wait_for_common_io.constprop.3+0x178/0x280
[   25.561563] [c0000001697878c0] [c00000000047f7ec] blk_execute_rq+0x7c/0xd0
[   25.561567] [c000000169787910] [c000000000614cd0] scsi_execute+0x100/0x230
[   25.561572] [c000000169787990] [c00000000060d29c] scsi_report_opcode+0xbc/0x170
[   25.561577] [c000000169787a50] [d000000004fe6404] sd_revalidate_disk+0xe04/0x1620 [sd_mod]
[   25.561583] [c000000169787b80] [d000000004fe6d84] sd_probe_async+0xb4/0x230 [sd_mod]
[   25.561588] [c000000169787c00] [c00000000010fc44] async_run_entry_fn+0x74/0x210
[   25.561593] [c000000169787c90] [c000000000102f48] process_one_work+0x198/0x480
[   25.561598] [c000000169787d30] [c0000000001032b8] worker_thread+0x88/0x510
[   25.561603] [c000000169787dc0] [c00000000010b030] kthread+0x160/0x1a0
[   25.561608] [c000000169787e30] [c00000000000b3a4] ret_from_kernel_thread+0x5c/0xb8

I was noticing that we are commonly in scsi_report_opcode. Since ipr RAID arrays don't support
the MAINTENANCE_IN / MI_REPORT_SUPPORTED_OPERATION_CODES, I tried setting sdev->no_report_opcodes = 1
in ipr's slave configure. This seems to eliminate the boot hang for me, but is only working around
the issue. Since this command is not supported by ipr, it should return with an illegal request.
When I'm hung at this point, there is nothing outstanding to the adapter / driver. I'll continue
debugging...

-Brian 

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

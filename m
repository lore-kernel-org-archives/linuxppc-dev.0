Return-Path: <vaibhav@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423fTl4ZVdzF38t
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 16:00:59 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w835xboM086787
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Sep 2018 02:00:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m8xvp8yxc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Sep 2018 02:00:56 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.ibm.com>;
 Mon, 3 Sep 2018 07:00:53 +0100
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 "Oliver O'Halloran" <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Make possible for user to force a full
 ipl cec reboot
In-Reply-To: <0fd029d2-e8ac-4392-6961-62e588ee5182@au1.ibm.com>
References: <20180901081745.2165-1-vaibhav@linux.ibm.com>
 <0fd029d2-e8ac-4392-6961-62e588ee5182@au1.ibm.com>
Date: Mon, 03 Sep 2018 11:30:45 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87va7nm86q.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for looking into this Andrew,

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> Oh good, someone else has finally picked this up and sent a kernel 
> patch, I did the skiboot half and then neglected to make it useful (I 
> sent an RFC at https://patchwork.ozlabs.org/patch/697604/ but never 
> followed up on it... this approach seems more usable, I think).
Thanks for pointing that out. I wasnt aware of this patch.


> When you say "the reboot command" - is this behaviour of passing the 
> argument common to all the important init systems/reboot utils?  What's 
> the correct systemd way to do it?
Mostly Yes,

On systemd the reboot command is just a symlink to systemctl binary that
checks argv[0] and maintains the a backward compatible behaviour. The
more systemd specific command 'systemctl reboot full' will also do the
same thing. So this patch should work on systemd.

Looking at 'upstart' I see support for adding an arg to the reboot
command since revision
https://bazaar.launchpad.net/~upstart-devel/upstart/trunk/revision/1432.3.1
. So upstart should also be supported.

I dont see support for sending an arg in 'SysVinit' halt command
yet. However this patch wont break the halt command. Just that SysVinit
systems will continue to use fast-reboot like today. Though
theorectially with this patch a SysVinit user can write a tool to issue
reboot syscall with cmd == LINUX_REBOOT_CMD_RESTART2 and arg == "full".

>>   	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
>> -		rc = opal_cec_reboot();
>> +
>> +		/* See if we need to do a full IPL reboot */
>> +		if (cmd && strcmp(cmd, "full") == 0)
>> +			rc = opal_cec_reboot2(OPAL_REBOOT_FULL_IPL, NULL);
>
> You might want to check for OPAL_UNSUPPORTED here just in case we're 
> running on ancient firmware.
Good idea, will fix this in v2.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.

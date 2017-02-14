Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN8n5169pzDqRY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 04:39:36 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EHcpZC044064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 12:39:34 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28m2evknrb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 12:39:34 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 15:39:32 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 668341DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 12:39:31 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1EHdUIk4464708
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 15:39:30 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1EHdUTm026077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 15:39:30 -0200
Subject: Re: [PATCH] powerpc/xmon: add debugfs entry for xmon
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <87vasdknq7.fsf@concordia.ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 xinhui.pan@linux.vnet.ibm.com
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 15:39:29 -0200
MIME-Version: 1.0
In-Reply-To: <87vasdknq7.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d9391480-0e70-a5b9-c315-a4933753d71c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/02/2017 09:37, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
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
> 
> I like this in general.
> 
> But I think we can simplify it a bit.
> 
> I don't think we need the nobt state anymore. As far as I can see it was
> added as a way to reinstate the old behaviour when the auto backtrace
> mode was added, but I've never heard of anyone using it.
> 
> If anyone hits a crash where they really need that feature they can
> always just hack the code to disable the backtrace.
> 
> So I think step 1 is a patch to drop the xmon_no_auto_backtrace stuff.
> 
> Also I'm not sure EARLY needs to be a separate state. It's just a
> one-off invocation at boot, all we really need is just a single bit of
> state communicated from early_parse_xmon() to xmon_setup(), ie. a static
> bool would do.
> 
> If we agree with that, then there's only two states left, on and off, in
> which case it can probably just be an int - and we can use a simple
> attribute file rather than custom parsing.
> 

Thanks for the good suggestions Michael, I'll change the code and submit
a new version.


>> * I had this patch partially done for some time, and after a discussion
>> at the kernel slack channel latest week, I decided to rebase and fix
>> some remaining bugs. I'd change 'x' option to always disable the debugger,
> 
> Not quite.
> 
> 'x' should exit and leave xmon in whatever state it was previously in.

Agreed!

Thanks,


Guilherme

> 
> cheers
> 

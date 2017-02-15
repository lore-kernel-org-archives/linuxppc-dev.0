Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNQNz5BdJzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 14:53:07 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F3n3ur101408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:53:04 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28mb5bfxd5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:53:04 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 20:53:03 -0700
Subject: Re: [PATCH] powerpc/xmon: add debugfs entry for xmon
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20170214123540.38b995cb@roar.ozlabs.ibm.com>
 <559244cc-dcc0-a477-b51b-7417a61158ed@linux.vnet.ibm.com>
 <8ddc4a78-4dd9-40df-2f00-503b4ff204b0@linux.vnet.ibm.com>
Cc: xinhui.pan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org
From: panxinhui <xinhui@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 11:52:56 +0800
MIME-Version: 1.0
In-Reply-To: <8ddc4a78-4dd9-40df-2f00-503b4ff204b0@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <7b8735e8-3f6f-d6ec-4382-5729fb9b69c3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2017/2/15 上午1:35, Guilherme G. Piccoli 写道:
> On 14/02/2017 01:58, Pan Xinhui wrote:
>>
>>
>> 在 2017/2/14 10:35, Nicholas Piggin 写道:
>>> On Mon, 13 Feb 2017 19:00:42 -0200
>>>
>>> xmon state changing after the first sysrq+x violates principle of least
>>> astonishment, so I think that should be fixed.
>>>
>> hi, Nick
>> yes, as long as xmon is disabled during boot, it should still be disabled after existing xmon.
>> My patch does not fix that as it need people add one more char 'z' following 'x'.
>> I will provide a new patch to fix that.
>>
>>> Then the question is, is it worth making it runtime configurable with xmon
>>> command or debugfs tunables?
>>>
>> They are options for people to turn xmon features on or off. Maybe people needn't this.
>> However I am not a fan  of debugfs this time as I am used to using xmon cmds. :)
>>
>> Hi, Guilherme
>> So in the end, my thought is that: 1) cmd x|X will exit xmon and keep xmon in the original state(indicated by var xmon_off).
>> 2) Then add options to turn some features on/off. And debugfs maybe not fit for this. But I am also wondering at same time, are people needing this?
> 
> Hi Nick and Xinhui, thanks very much for the feedback.
> I agree, we should keep xmon in the state it was firstly set, on boot
> time - dropping to the debugger using sysrq shouldn't change it.
> 
Yes, and feel free to include my fix patch "powerpc/xmon: Fix an unexpected xmon onoff state change" :)

> Now, the use case of the debugfs approach is to allow user to
> enable/disable xmon without need to drop into the debugger itself, or
> reboot the machine.
Good, got it.
We look forward to your new patch. :)

thanks
xinhui
> Imagine a scenario in which we have a production machine, and:
> 
> 
> i) For some reason, somebody kept xmon enabled on grub.cfg and now, we
> want to let kdump work in case of crash - how to disable xmon in runtime?
> 
> ii) The opposite: xmon wasn't enable on boot time in production machine,
> but we have a super-rare issue and want to drop to xmon next time it
> happens, so we need to enable it. But we don't want to drop into the
> debugger to force it gets enabled, so how do we enable it?
> 
> Regarding the place of the xmon state file, I believe debugfs is the
> right place - where else could we add it? procfs? configfs?
> 
> Thanks,
> 
> 
> Guilherme
>>
>> thanks
>> xinhui
>>
>>> Thanks,
>>> Nick
>>>
>>

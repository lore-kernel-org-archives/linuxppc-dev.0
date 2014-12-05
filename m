Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C0F71A0CD0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 12:40:41 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 11:40:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8E1732BB0072
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 12:40:36 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB51eah842467366
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 12:40:36 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB51eZRU015774
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 12:40:35 +1100
Date: Fri, 5 Dec 2014 09:40:34 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/pci: remove pci device on a bus in reverse order
Message-ID: <20141205014033.GA8408@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1417663477-9124-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141204054035.C3DAC1400E9@ozlabs.org>
 <20141204072117.GA9978@richard> <20141204224813.GA8008@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141204224813.GA8008@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 05, 2014 at 09:48:13AM +1100, Gavin Shan wrote:
>On Thu, Dec 04, 2014 at 03:21:18PM +0800, Wei Yang wrote:
>>On Thu, Dec 04, 2014 at 04:40:35PM +1100, Michael Ellerman wrote:
>>>On Thu, 2014-04-12 at 03:24:37 UTC, Wei Yang wrote:
>>>> As in commit ac205b7b (PCI: make sriov work with hotplug remove) indicates,
>>>> when removing pci devices on a bus which has VFs, we need to remove them in
>>>> the reverse order.
>>>> 
>>>> This patch applies this pattern on the hotplug remove path on powerpc arch.
>>>
>>>So is this is a bug fix?
>>
>>It hasn't trigger a bug yet. I found this issue during the code reading. When
>>VFs are enabled and try to remove a bus with VFs, it will face a problem. So I
>>port the change in commit ac205b7b here.
>>
>>>
>>>Where/how have you tested this?
>>
>>I have tested after change on Power8, the EEH hotplug path works fine for PFs
>>now. Will test this when EEH for VFs are ready.
>>
>>Suggest me to keep it untill EEH for VFs are ready?
>>
>
>Please keep it and resend it (with typo fixed as I pointed) after SRIOV patchset
>gets merged. If SRIOV isn't enabled, we don't need the code change.
>
>By the way, it's something related to EEH for PFs. When PF and its VFs seat on
>same PCI bus, we should remove VFs before putting PF offline in the reversed
>order as you did in your code change. Otherwise, PF is put into offline and
>its driver disables VFs. We try redoing the removal for VFs in hotplug path,
>which would cause race condition. If VFs aren't existing, until your SRIOV
>patchset is merged, we don't have this problem. Please correct me if I
>understood things wrongly.
>

Current code is fine until VF is introduced. Yes, your understanding is
correct.

>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me

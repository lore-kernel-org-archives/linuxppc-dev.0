Return-Path: <vmansur@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E48881A002C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:30:07 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vmansur@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 17:30:07 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 849922BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:30:03 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7D7Ulu815532268
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:30:47 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7D7U2eI021240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:30:02 +1000
Message-ID: <53EB13D9.5050501@linux.vnet.ibm.com>
Date: Wed, 13 Aug 2014 12:59:29 +0530
From: Vishal Mansur <vmansur@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] powerpc: non-GPL export for eeh_dev_check_failure
References: <53E0ED41.8030804@linux.vnet.ibm.com>
 <20140805155140.2b200061@alan.etchedpixels.co.uk>
 <1407726995.4508.64.camel@pasglop>
In-Reply-To: <1407726995.4508.64.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/11/2014 8:46 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2014-08-05 at 15:51 +0100, One Thousand Gnomes wrote:
>> On Tue, 05 Aug 2014 20:12:09 +0530
>> Vishal Mansur <vmansur@linux.vnet.ibm.com> wrote:
>>
>>> EEH kernel services are inconsistently exported by the 
>>> kernel. eeh_check_failure is exported for any use, but 
>>> eeh_dev_check_failure is exported only for GPL use. 
>>> While eeh_check_failure is implemented for a specific 
>>> purpose to be used by services such as readl, it is 
>>> not suited for a purpose where caller needs eeh status. 
>>> This functionality is provided by eeh_dev_check_failure.
>>>
>>> This patch relaxes the export for eeh_dev_check_failure
>>> to make it consistent with eeh_check_failure() and 
>>> usable by non-GPL modules.
>>
>> The GPL covers all derivative works. Tweaking this doesn't magically
>> allow you to use the feature in non GPL code. Your legal department can I
>> am sure explain in detail further.
> 
> This is an interesting case... I assume this has to do with a well known
> GPU manufacturer...
> 
> The PCI APIs are generally exported in such a way that a non-GPL driver
> can use them (regardless of whether one considers a non-GPL driver to be
> legal here or not, this is besides the point).
> 
> eeh_dev_check_failure() can be considered as powerpc specific extension
> of the PCI API for use by PCI drivers and as such, it *could* be
> construed that we should be consistent (and consistent with
> eeh_check_failure()) and expose it as an EXPORT_SYMBOL without the GPL
> suffix.
> 
> So I'm somewhat tempted to take this patch, but Vishal, the driver in
> question could, I suppose, as a workaround, use a readl to some scratch
> register of some description, no ?

Ben, calling readl to some scratch register will be same as calling 
eeh_check_failure, caller will not be able to get eeh status.

Hence for the purpose where caller wants to know eeh status during
a bad register read, it can not be worked around using readl.

Thanks,
Vishal

> 
> Cheers,
> Ben.
> 
>> Alan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

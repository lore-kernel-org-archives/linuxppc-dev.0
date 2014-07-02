Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB2821A002D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 22:12:34 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 2 Jul 2014 17:42:32 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 677133940061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 17:42:27 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s62CCi3w10092860
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jul 2014 17:42:45 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s62CCQLJ029679
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jul 2014 17:42:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/6] KVM: PPC: BOOK3S: HV: Deny virtual page class key
 update via h_protect
In-Reply-To: <20140702045002.GC16865@drongo>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1404040655-12076-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140702045002.GC16865@drongo>
Date: Wed, 02 Jul 2014 17:42:25 +0530
Message-ID: <87tx70m02e.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Sun, Jun 29, 2014 at 04:47:31PM +0530, Aneesh Kumar K.V wrote:
>> This makes it consistent with h_enter where we clear the key
>> bits. We also want to use virtual page class key protection mechanism
>> for indicating host page fault. For that we will be using key class
>> index 30 and 31. So prevent the guest from updating key bits until
>> we add proper support for virtual page class protection mechanism for
>> the guest. This will not have any impact for PAPR linux guest because
>> Linux guest currently don't use virtual page class key protection model
>
> As things stand, without this patch series, we do actually have
> everything we need in the kernel for guests to use virtual page class
> keys.  Arguably we should have a capability to tell userspace how many
> storage keys the guest can use, but that's the only missing piece as
> far as I can see.

yes.

>
> If we add such a capability, I can't see any reason why we should need
> to disable guest use of storage keys in this patchset.

With this patchset, we would need additonal changes to find out whether the key
fault happened because of the guest's usage of the key. I was planning to do
that as an add-on series to keep the changes in this minimal. Also since
linux didn't use keys i was not sure whether guest support of keys is an
important item.

-aneesh

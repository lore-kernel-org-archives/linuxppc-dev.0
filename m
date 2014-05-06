Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D0D0E140E5B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:06:08 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 May 2014 00:06:07 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EEC472BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:06:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46Diu4H61604026
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 23:44:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46E64MG009115
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 May 2014 00:06:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
In-Reply-To: <536887EF.2070201@suse.de>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <20140506004133.GA12595@iris.ozlabs.ibm.com>
 <536887EF.2070201@suse.de>
Date: Tue, 06 May 2014 19:36:00 +0530
Message-ID: <8738gnrohj.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 06.05.14 02:41, Paul Mackerras wrote:
>> On Mon, May 05, 2014 at 01:19:30PM +0200, Alexander Graf wrote:
>>> On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>> +	return vcpu->arch.fault_dar;
>>> How about PA6T and G5s?
>> G5 sets DAR on an alignment interrupt.
>>
>> As for PA6T, I don't know for sure, but if it doesn't, ordinary
>> alignment interrupts wouldn't be handled properly, since the code in
>> arch/powerpc/kernel/align.c assumes DAR contains the address being
>> accessed on all PowerPC CPUs.
>
> Now that's a good point. If we simply behave like Linux, I'm fine. This 
> definitely deserves a comment on the #ifdef in the code.
>

Will update and send V5

-aneesh

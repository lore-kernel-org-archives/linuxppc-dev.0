Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AC6301412D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:12:37 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 19:42:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C0343125804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 19:41:26 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46ECZR87799124
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 19:42:35 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46ECSGS015350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 19:42:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
In-Reply-To: <536887EF.2070201@suse.de>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <20140506004133.GA12595@iris.ozlabs.ibm.com>
 <536887EF.2070201@suse.de>
Date: Tue, 06 May 2014 19:42:28 +0530
Message-ID: <87zjivq9mb.fsf@linux.vnet.ibm.com>
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


How about ?

#ifdef CONFIG_PPC_BOOK3S_64
	/*
	 * Linux always expect a valid  dar as per alignment
	 * interrupt handling code (fix_alignment()). Don't compute the dar
	 * value here, instead used the saved dar value. Right now we restrict
	 * this only for BOOK3S-64.
	 */
	return vcpu->arch.fault_dar;
#else


-aneesh

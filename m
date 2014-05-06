Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45ADB141321
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 16:57:55 +1000 (EST)
Message-ID: <536887EF.2070201@suse.de>
Date: Tue, 06 May 2014 08:57:51 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <20140506004133.GA12595@iris.ozlabs.ibm.com>
In-Reply-To: <20140506004133.GA12595@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06.05.14 02:41, Paul Mackerras wrote:
> On Mon, May 05, 2014 at 01:19:30PM +0200, Alexander Graf wrote:
>> On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>> +	return vcpu->arch.fault_dar;
>> How about PA6T and G5s?
> G5 sets DAR on an alignment interrupt.
>
> As for PA6T, I don't know for sure, but if it doesn't, ordinary
> alignment interrupts wouldn't be handled properly, since the code in
> arch/powerpc/kernel/align.c assumes DAR contains the address being
> accessed on all PowerPC CPUs.

Now that's a good point. If we simply behave like Linux, I'm fine. This 
definitely deserves a comment on the #ifdef in the code.


Alex

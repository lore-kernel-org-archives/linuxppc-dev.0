Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 72BBB2C0232
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 22:28:14 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 16:58:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6923F3940057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:58:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VBRwMY46071870
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:57:58 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VBS5TV024326
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:58:06 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 07/10] KVM: PPC: BOOK3S: PR: Emulate facility status
 and control register
In-Reply-To: <20140130060000.GB10611@iris.ozlabs.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140130060000.GB10611@iris.ozlabs.ibm.com>
Date: Fri, 31 Jan 2014 16:58:05 +0530
Message-ID: <87ob2sjsqi.fsf@linux.vnet.ibm.com>
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

> On Tue, Jan 28, 2014 at 10:14:12PM +0530, Aneesh Kumar K.V wrote:
>> We allow priv-mode update of this. The guest value is saved in fscr,
>> and the value actually used is saved in shadow_fscr. shadow_fscr
>> only contains values that are allowed by the host. On
>> facility unavailable interrupt, if the facility is allowed by fscr
>> but disabled in shadow_fscr we need to emulate the support. Currently
>> all but EBB is disabled. We still don't support performance monitoring
>> in PR guest.
>
> ...
>
>> +	/*
>> +	 * Save the current fscr in shadow fscr
>> +	 */
>> +	mfspr r3,SPRN_FSCR
>> +	PPC_STL r3, VCPU_SHADOW_FSCR(r7)
>
> I don't think you need to do this.  What could possibly have changed
> FSCR since we loaded it on the way into the guest?

The reason for facility unavailable interrupt is encoded in FSCR right ?

-aneesh

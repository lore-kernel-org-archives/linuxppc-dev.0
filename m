Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3EA0814139A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:25:41 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 19:55:37 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 29A6E1258053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 19:54:32 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s46EPhTu64815260
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 19:55:43 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s46EPZ3f030959
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 19:55:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
In-Reply-To: <20140506042058.GA25186@drongo>
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677834.5010808@suse.de> <87lhug9taz.fsf@linux.vnet.ibm.com>
 <20140506042058.GA25186@drongo>
Date: Tue, 06 May 2014 19:55:34 +0530
Message-ID: <87r447q90h.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, May 05, 2014 at 08:17:00PM +0530, Aneesh Kumar K.V wrote:
>> Alexander Graf <agraf@suse.de> writes:
>> 
>> > On 05/04/2014 07:30 PM, Aneesh Kumar K.V wrote:
>> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> >
>> > No patch description, no proper explanations anywhere why you're doing 
>> > what. All of that in a pretty sensitive piece of code. There's no way 
>> > this patch can go upstream in its current form.
>> >
>> 
>> Sorry about being vague. Will add a better commit message. The goal is
>> to export MPSS support to guest if the host support the same. MPSS
>> support is exported via penc encoding in "ibm,segment-page-sizes". The
>> actual format can be found at htab_dt_scan_page_sizes. When the guest
>> memory is backed by hugetlbfs we expose the penc encoding the host
>> support to guest via kvmppc_add_seg_page_size. 
>
> In a case like this it's good to assume the reader doesn't know very
> much about Power CPUs, and probably isn't familiar with acronyms such
> as MPSS.  The patch needs an introductory paragraph explaining that on
> recent IBM Power CPUs, while the hashed page table is looked up using
> the page size from the segmentation hardware (i.e. the SLB), it is
> possible to have the HPT entry indicate a larger page size.  Thus for
> example it is possible to put a 16MB page in a 64kB segment, but since
> the hash lookup is done using a 64kB page size, it may be necessary to
> put multiple entries in the HPT for a single 16MB page.  This
> capability is called mixed page-size segment (MPSS).  With MPSS,
> there are two relevant page sizes: the base page size, which is the
> size used in searching the HPT, and the actual page size, which is the
> size indicated in the HPT entry.  Note that the actual page size is
> always >= base page size.

I will update the commit message with the above details

-aneesh

Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23B18140B00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:47:05 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 5 May 2014 20:17:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 061FE1258048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 20:15:57 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s45El8ja44695768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 20:17:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s45El0ut007698
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 20:17:00 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
In-Reply-To: <53677834.5010808@suse.de>
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53677834.5010808@suse.de>
Date: Mon, 05 May 2014 20:17:00 +0530
Message-ID: <87lhug9taz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 05/04/2014 07:30 PM, Aneesh Kumar K.V wrote:
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> No patch description, no proper explanations anywhere why you're doing 
> what. All of that in a pretty sensitive piece of code. There's no way 
> this patch can go upstream in its current form.
>

Sorry about being vague. Will add a better commit message. The goal is
to export MPSS support to guest if the host support the same. MPSS
support is exported via penc encoding in "ibm,segment-page-sizes". The
actual format can be found at htab_dt_scan_page_sizes. When the guest
memory is backed by hugetlbfs we expose the penc encoding the host
support to guest via kvmppc_add_seg_page_size. 

Now the challenge to THP support is to make sure that our henter,
hremove etc decode base page size and actual page size correctly
from the hash table entry values. Most of the changes is to do that.
Rest of the stuff is already handled by kvm. 

NOTE: It is much easier to read the code after applying the patch rather
than reading the diff. I have added comments around each steps in the
code.

-aneesh

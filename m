Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85AD62C0308
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 13:38:42 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 10 Dec 2013 21:38:21 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 315C3E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 21:40:37 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBAG8CZI49414378
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 21:38:13 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBAG8GsM004499
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 21:38:16 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Use schedule instead of cond_resched
In-Reply-To: <C3F93DB3-202A-427D-A7B6-A868F3743507@suse.de>
References: <1386685284-3862-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C3F93DB3-202A-427D-A7B6-A868F3743507@suse.de>
Date: Tue, 10 Dec 2013 21:38:14 +0530
Message-ID: <877gbcsn81.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 10.12.2013, at 15:21, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We already checked need_resched. So we can call schedule directly
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> The real fix for the issue you're seeing is
>
>   https://lkml.org/lkml/2013/11/28/241

True, I mentioned that in the thread

https://lkml.org/lkml/2013/12/9/64

But do we need to do cond_resched after we checked for need_resched() ?

-aneesh

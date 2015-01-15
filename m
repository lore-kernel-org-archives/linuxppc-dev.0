Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDF911A0548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 22:07:21 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Thu, 15 Jan 2015 11:07:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 37D361B0804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 11:07:52 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0FB7Ftx59113494
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 11:07:15 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0FB7Drv017632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 04:07:14 -0700
Message-ID: <54B79F5F.1040806@de.ibm.com>
Date: Thu, 15 Jan 2015 12:07:11 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
To: David Vrabel <david.vrabel@citrix.com>, linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] [PATCH 3/8] x86/xen/p2m: Replace ACCESS_ONCE with
 READ_ONCE
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com>
 <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com>
 <54B799DC.1050008@citrix.com>
In-Reply-To: <54B799DC.1050008@citrix.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 15.01.2015 um 11:43 schrieb David Vrabel:
> On 15/01/15 08:58, Christian Borntraeger wrote:
>> ACCESS_ONCE does not work reliably on non-scalar types. For
>> example gcc 4.6 and 4.7 might remove the volatile tag for such
>> accesses during the SRA (scalar replacement of aggregates) step
>> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
>>
>> Change the p2m code to replace ACCESS_ONCE with READ_ONCE.
> 
> Acked-by: David Vrabel <david.vrabel@citrix.com>

Thanks

> Let me know if you want me to merge this via the Xen tree.


With your Acked-by, I can easily carry this in my tree. We can 
then ensure that this patch is merged before the ACCESS_ONCE is
made stricter - making bisecting easier.

Christian

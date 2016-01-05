Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C9E61A1158
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 02:39:53 +1100 (AEDT)
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 5 Jan 2016 15:39:48 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4AE1C17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 15:40:29 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u05FdiJU3998202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jan 2016 15:39:44 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u05FdeMj015056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jan 2016 08:39:44 -0700
Subject: Re: [PATCH v2 22/32] s390: define __smp_xxx
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-23-git-send-email-mst@redhat.com>
 <20160104134525.GA6344@twins.programming.kicks-ass.net>
 <20160104221323-mutt-send-email-mst@redhat.com>
 <20160105091319.59ddefc7@mschwide>
 <20160105105335-mutt-send-email-mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 virtualization@lists.linux-foundation.org,
 Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Andrey Konovalov <andreyknvl@google.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <568BE3B9.8020901@de.ibm.com>
Date: Tue, 5 Jan 2016 16:39:37 +0100
MIME-Version: 1.0
In-Reply-To: <20160105105335-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/05/2016 10:30 AM, Michael S. Tsirkin wrote:

> 
> arch/s390/kernel/vdso.c:        smp_mb();
> 
> Looking at
> 	Author: Christian Borntraeger <borntraeger@de.ibm.com>
> 	Date:   Fri Sep 11 16:23:06 2015 +0200
> 
> 	    s390/vdso: use correct memory barrier
> 
> 	    By definition smp_wmb only orders writes against writes. (Finish all
> 	    previous writes, and do not start any future write). To protect the
> 	    vdso init code against early reads on other CPUs, let's use a full
> 	    smp_mb at the end of vdso init. As right now smp_wmb is implemented
> 	    as full serialization, this needs no stable backport, but this change
> 	    will be necessary if we reimplement smp_wmb.
> 
> ok from hypervisor point of view, but it's also strange:
> 1. why isn't this paired with another mb somewhere?
>    this seems to violate barrier pairing rules.
> 2. how does smp_mb protect against early reads on other CPUs?
>    It normally does not: it orders reads from this CPU versus writes
>    from same CPU. But init code does not appear to read anything.
>    Maybe this is some s390 specific trick?
> 
> I could not figure out the above commit.

It was probably me misreading the code. I change a wmb into a full mb here
since I was changing the defintion of wmb to a compiler barrier. I tried to
fixup all users of wmb that really pair with other code. I assumed that there
must be some reader (as there was a wmb before) but I could not figure out
which. So I just played safe here.

But it probably can be removed.

> arch/s390/kvm/kvm-s390.c:       smp_mb();

This can go. If you have a patch, I can carry that via the kvms390 tree,
or I will spin a new patch with you as suggested-by.

Christian

Return-Path: <dahi@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F21611A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 04:10:29 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dahi@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 17:10:25 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5888B17D8059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:10:38 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARHAMSu18743550
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:10:22 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARHAJ4V026115
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 10:10:21 -0700
From: David Hildenbrand <dahi@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Thu, 27 Nov 2014 18:10:15 +0100
Message-Id: <1417108217-42687-1-git-send-email-dahi@linux.vnet.ibm.com>
In-Reply-To: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, mst@redhat.com, heiko.carstens@de.ibm.com,
 dahi@linux.vnet.ibm.com, David.Laight@ACULAB.COM, paulus@samba.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simple prototype to enable might_sleep() checks in might_fault(), avoiding false
positives for scenarios involving explicit pagefault_disable().

So this should work:
	spin_lock(&lock); /* also if left away */
	pagefault_disable()
	rc = copy_to_user(...)
	pagefault_enable();
	spin_unlock(&lock); /*

And this should report a warning again:
	spin_lock(&lock);
	rc = copy_to_user(...);
	spin_unlock(&lock);

Still missing:
- Split of preempt documentation update + preempt_active define reshuffle
- Debug version to test for over/underflows
- Change documentation of user access methods to reflect the real behavior
- Don't touch the preempt counter, only the pagefault disable counter (future
  work)

David Hildenbrand (2):
  preempt: track pagefault_disable() calls in the preempt counter
  mm, sched: trigger might_sleep() in might_fault() when pagefaults are
    disabled

 include/linux/kernel.h       |  9 +++++++--
 include/linux/preempt_mask.h | 24 +++++++++++++++++++-----
 include/linux/uaccess.h      | 21 ++++++++++++++-------
 mm/memory.c                  | 15 ++++-----------
 4 files changed, 44 insertions(+), 25 deletions(-)

-- 
1.8.5.5

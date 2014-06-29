Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E9E81A0012
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 02:57:19 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 22:27:12 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A86E83940048
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 22:27:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TGwQWs36569090
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 22:28:26 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TGv8IQ032676
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 22:27:08 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/6] Use virtual page class key protection mechanism for
 speeding up guest page fault
In-Reply-To: <1404041166.31323.2.camel@pasglop>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1404041166.31323.2.camel@pasglop>
Date: Sun, 29 Jun 2014 22:27:07 +0530
Message-ID: <8738enwt5o.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sun, 2014-06-29 at 16:47 +0530, Aneesh Kumar K.V wrote:
>
>> To achieve the above we use virtual page calss protection mechanism for
>> covering (2) and (3). For both the above case we mark the hpte
>> valid, but associate the page with virtual page class index 30 and 31.
>> The authority mask register is configured such that class index 30 and 31
>> will have read/write denied. The above change results in a key fault
>> for (2) and (3). This allows us to forward a NO_HPTE fault directly to guest
>> without doing the expensive hash pagetable lookup.
>
> So we have a measurable performance benefit (about half a second out of
> 8).

I was able to measure a performance benefit of 2 seconds earlier. But
once i get the below patch applied that got reduced. I am trying
to find how the patch is helping the performance. May be it is
avoiding some unnecessary invalidation ?

http://mid.gmane.org/1403876103-32459-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

I also believe the benefit depends on how much impact a hash table
lookup have. I did try to access the addresses linearly so that I can make
sure we do take a cache miss for hash page table access. 

>but you didn't explain the drawback here which is to essentially make
> it impossible for guests to exploit virtual page class keys, or did you
> find a way to still make that possible ?

I am now making PROTFAULT to go to host. That means, ksm sharing is
represented as read only page and an attempt to write to it will get to
host via PROTFAULT. Now with that we can implement keys for guest if we
want to. So irrespective of what restrictions guest has put in, if the
host swapout the page, we will deny read/write. Now if the key fault
need to go to guest, we will find that out looking at the key index. 

>
> As it-is, it's not a huge issue for Linux but we might have to care with
> other OSes that do care...
>
> Do we have a way in PAPR to signify to the guest that the keys are not
> available ?

Right now Qemu doesn't provide the device tree node
ibm,processor-storage-keys. That means guest cannot use keys. So we are
good there. If we want to support guest keys, we need to fill that with
the value that indicate how many keys can be used for data and instruction.

-aneesh

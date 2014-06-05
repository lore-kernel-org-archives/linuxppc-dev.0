Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBF541A0251
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 23:04:10 +1000 (EST)
Received: by mail-pb0-f51.google.com with SMTP id ma3so1092857pbc.24
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jun 2014 06:04:08 -0700 (PDT)
Message-ID: <53906AC1.6000404@ozlabs.ru>
Date: Thu, 05 Jun 2014 23:04:01 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] PPC: KVM: Add support for 64bit TCE windows
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>	
 <1401953144-19186-4-git-send-email-aik@ozlabs.ru>	
 <1401953908.3247.121.camel@pasglop> <539037DB.5080706@ozlabs.ru>	
 <1401964037.3247.129.camel@pasglop> <53905ADB.8000100@suse.de>
 <1401971411.3247.132.camel@pasglop>
In-Reply-To: <1401971411.3247.132.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2014 10:30 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-06-05 at 13:56 +0200, Alexander Graf wrote:
>> What if we ask user space to give us a pointer to user space allocated 
>> memory along with the TCE registration? We would still ask user space to 
>> only use the returned fd for TCE modifications, but would have some 
>> nicely swappable memory we can store the TCE entries in.
> 
> That isn't going to work terribly well for VFIO :-) But yes, for
> emulated devices, we could improve things a bit, including for
> the 32-bit TCE tables.
> 
> For emulated, the real mode path could walk the page tables and fallback
> to virtual mode & get_user if the page isn't present, thus operating
> directly on qemu memory TCE tables instead of the current pinned stuff.
> 
> However that has a cost in performance, but since that's really only
> used for emulated devices and PAPR VIOs, it might not be a huge issue.
> 
> But for VFIO we don't have much choice, we need to create something the
> HW can access.

You are confusing things here.

There are 2 tables:
1. guest-visible TCE table, this is what is allocated for VIO or emulated PCI;
2. real HW DMA window, one exists already for DMA32 and one I will
allocated for a huge window.

I have just #2 for VFIO now but we will need both in order to implement
H_GET_TCE correctly, and this is the table I will allocate by this new ioctl.


>> In fact, the code as is today can allocate an arbitrary amount of pinned 
>> kernel memory from within user space without any checks.
> 
> Right. We should at least account it in the locked limit.

Yup. And (probably) this thing will keep a counter of how many windows were
created per KVM instance to avoid having multiple copies of the same table.


-- 
Alexey

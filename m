Return-Path: <toiwoton@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrfvz6H96zDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 03:39:43 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id o80so3052708wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 10:39:43 -0700 (PDT)
Subject: Re: [PATCH 09/14] resource limits: track highwater mark of locked
 memory
To: Oleg Nesterov <oleg@redhat.com>
References: <1468578983-28229-1-git-send-email-toiwoton@gmail.com>
 <1468578983-28229-10-git-send-email-toiwoton@gmail.com>
 <20160715151408.GA32317@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Christian Benvenuti <benve@cisco.com>, Dave Goodell <dgoodell@cisco.com>,
 Sudeep Dutt <sudeep.dutt@intel.com>,
 Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>,
 Konstantin Khlebnikov <koct9i@gmail.com>,
 Cyrill Gorcunov <gorcunov@openvz.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Eric B Munson <emunson@akamai.com>, Alexey Klimov <klimov.linux@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Chen Gang
 <gang.chen.5i5j@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 David Rientjes <rientjes@google.com>, Hugh Dickins <hughd@google.com>,
 Alexander Kuleshov <kuleshovmail@gmail.com>,
 "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC"
 <kvm-ppc@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
 "open list:BPF (Safe dynamic programs and tools)" <netdev@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
From: Topi Miettinen <toiwoton@gmail.com>
Message-ID: <5c43bc33-6625-ceb7-e96e-adf7df5b642c@gmail.com>
Date: Fri, 15 Jul 2016 17:39:26 +0000
MIME-Version: 1.0
In-Reply-To: <20160715151408.GA32317@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/16 15:14, Oleg Nesterov wrote:
> On 07/15, Topi Miettinen wrote:
>>
>> Track maximum size of locked memory, to be able to configure
>> RLIMIT_MEMLOCK resource limits. The information is available
>> with taskstats and cgroupstats netlink socket.
> 
> So I personally still dislike the very idea of this series... but I won't
> argue if you convince maintainers.
> 
>> @@ -2020,6 +2020,10 @@ static int acct_stack_growth(struct vm_area_struct *vma, unsigned long size, uns
>>  		return -ENOMEM;
>>  
>>  	update_resource_highwatermark(RLIMIT_STACK, actual_size);
>> +	if (vma->vm_flags & VM_LOCKED)
>> +		update_resource_highwatermark(RLIMIT_MEMLOCK,
>> +					      (mm->locked_vm + grow) <<
>> +					      PAGE_SHIFT);
> 
> Btw this is not right. The same for the previous patch which tracks
> RLIMIT_STACK. The "current" task can debugger/etc.

acct_stack_growth() is called from expand_upwards() and
expand_downwards(). They call security_mmap_addr() and the various LSM
implementations also use current task in the checks. Are these also not
right?

> 
> Yes, yes, this just reminds that the whole rlimit logic in this path
> is broken but still...

I'd be happy to fix the logic with a separate prerequisite patch and
then use the right logic for this patch, but I'm not sure I know how.
Could you elaborate a bit?

-Topi

> 
> Oleg.
> 

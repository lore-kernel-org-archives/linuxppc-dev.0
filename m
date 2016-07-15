Return-Path: <toiwoton@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrfSb1vJGzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 03:19:27 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id x83so2955070wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 10:19:27 -0700 (PDT)
Subject: Re: [PATCH 00/14] Present useful limits to user (v2)
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
References: <1468578983-28229-1-git-send-email-toiwoton@gmail.com>
 <5788F0E1.8090203@nod.at>
Cc: Jonathan Corbet <corbet@lwn.net>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Alexander Graf <agraf@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>,
 Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Christian Benvenuti <benve@cisco.com>, Dave Goodell <dgoodell@cisco.com>,
 Sudeep Dutt <sudeep.dutt@intel.com>,
 Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Markus Elfring <elfring@users.sourceforge.net>,
 "David S. Miller" <davem@davemloft.net>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Konstantin Khlebnikov <koct9i@gmail.com>, Jiri Slaby <jslaby@suse.cz>,
 Cyrill Gorcunov <gorcunov@openvz.org>, Michal Hocko <mhocko@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Dave Hansen <dave.hansen@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Marcus Gelderie <redmnic@gmail.com>,
 Vladimir Davydov <vdavydov@virtuozzo.com>, Joe Perches <joe@perches.com>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen
 <ak@linux.intel.com>, Oleg Nesterov <oleg@redhat.com>,
 Stas Sergeev <stsp@list.ru>, Amanieu d'Antras <amanieu@gmail.com>,
 Wang Xiaoqiang <wangxq10@lzu.edu.cn>, Helge Deller <deller@gmx.de>,
 Mateusz Guzik <mguzik@redhat.com>, Alex Thorlton <athorlton@sgi.com>,
 Ben Segall <bsegall@google.com>, John Stultz <john.stultz@linaro.org>,
 Rik van Riel <riel@redhat.com>, Eric B Munson <emunson@akamai.com>,
 Alexey Klimov <klimov.linux@gmail.com>, Chen Gang
 <gang.chen.5i5j@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 David Rientjes <rientjes@google.com>, Hugh Dickins <hughd@google.com>,
 Alexander Kuleshov <kuleshovmail@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 "open list:IA64 (Itanium) PLATFORM" <linux-ia64@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC"
 <kvm-ppc@vger.kernel.org>,
 "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
 "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:BPF (Safe dynamic programs and tools)" <netdev@vger.kernel.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
From: Topi Miettinen <toiwoton@gmail.com>
Message-ID: <cf28b6b8-6d0d-8ce2-f3dc-953b9bee12d1@gmail.com>
Date: Fri, 15 Jul 2016 17:19:14 +0000
MIME-Version: 1.0
In-Reply-To: <5788F0E1.8090203@nod.at>
Content-Type: text/plain; charset=iso-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/16 14:19, Richard Weinberger wrote:
> Hi!
> 
> Am 15.07.2016 um 12:35 schrieb Topi Miettinen:
>> Hello,
>>
>> There are many basic ways to control processes, including capabilities,
>> cgroups and resource limits. However, there are far fewer ways to find out
>> useful values for the limits, except blind trial and error.
>>
>> This patch series attempts to fix that by giving at least a nice starting
>> point from the highwater mark values of the resources in question.
>> I looked where each limit is checked and added a call to update the mark
>> nearby.
>>
>> Example run of program from Documentation/accounting/getdelauys.c:
>>
>> ./getdelays -R -p `pidof smartd`
>> printing resource accounting
>> RLIMIT_CPU=0
>> RLIMIT_FSIZE=0
>> RLIMIT_DATA=18198528
>> RLIMIT_STACK=135168
>> RLIMIT_CORE=0
>> RLIMIT_RSS=0
>> RLIMIT_NPROC=1
>> RLIMIT_NOFILE=55
>> RLIMIT_MEMLOCK=0
>> RLIMIT_AS=130879488
>> RLIMIT_LOCKS=0
>> RLIMIT_SIGPENDING=0
>> RLIMIT_MSGQUEUE=0
>> RLIMIT_NICE=0
>> RLIMIT_RTPRIO=0
>> RLIMIT_RTTIME=0
>>
>> ./getdelays -R -C /sys/fs/cgroup/systemd/system.slice/smartd.service/
>> printing resource accounting
>> sleeping 1, blocked 0, running 0, stopped 0, uninterruptible 0
>> RLIMIT_CPU=0
>> RLIMIT_FSIZE=0
>> RLIMIT_DATA=18198528
>> RLIMIT_STACK=135168
>> RLIMIT_CORE=0
>> RLIMIT_RSS=0
>> RLIMIT_NPROC=1
>> RLIMIT_NOFILE=55
>> RLIMIT_MEMLOCK=0
>> RLIMIT_AS=130879488
>> RLIMIT_LOCKS=0
>> RLIMIT_SIGPENDING=0
>> RLIMIT_MSGQUEUE=0
>> RLIMIT_NICE=0
>> RLIMIT_RTPRIO=0
>> RLIMIT_RTTIME=0
>>
>> In this example, smartd is running as a non-root user. The presented
>> values can be used as a starting point for giving new limits to the
>> service.
> 
> I don't think it is worth sprinkling the kernel with update_resource_highwatermark()
> calls just to get these metrics.
> 
> Can't we teach the existing perf infrastructure to collect these highwatermarks for us?

I don't know. What kind of changes do you think would be needed?

-Topi

> 
> Thanks,
> //richard
> 

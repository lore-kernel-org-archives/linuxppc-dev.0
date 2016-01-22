Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com
 [IPv6:2607:f8b0:4002:c07::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7375A1A075A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 21:42:01 +1100 (AEDT)
Received: by mail-yk0-x22b.google.com with SMTP id k129so82071620yke.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 02:42:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453451744.24910.4.camel@ellerman.id.au>
References: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
 <1453440564.21683.8.camel@ellerman.id.au>
 <56A1CC1C.3000009@linux.vnet.ibm.com>
 <1453451744.24910.4.camel@ellerman.id.au>
Date: Fri, 22 Jan 2016 13:41:58 +0300
Message-ID: <CAOJe8K2nE-49zBrCNrwNoepccv5UZ2SvdX0Ut_2XtzMhJd2T7Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/22/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Fri, 2016-01-22 at 11:58 +0530, Vasant Hegde wrote:
>> On 01/22/2016 10:59 AM, Michael Ellerman wrote:
>> > On Thu, 2016-01-21 at 21:45 +0530, Vasant Hegde wrote:
>> >
>> > > With commit 90a545e9 (restrict /dev/mem to idle io memory ranges)
>> > > mapping
>> > > rtas_rmo_buf from user space is failing. Hence we are not able to make
>> > > RTAS syscall.
>> >
>> > Having said that, why the <expletive deleted> is librtas mapping
>> > /dev/mem in
>> > the first place? Unless there is a very good reason, and probably even
>> > if there
>> > is, we should fix that to use a sane API.
>>
>> We use rtas system call. We use /dev/mem interface to map the RTAS memory
>> region
>> (allocated by kernel and information is passed to user space via procfs)
>> so that
>> we can read/write to RTAS memory.
>>
>> I do not have historical information. May be Nathan has more information
>> on this.
>
> Yeah, we need to dig into what it's actually doing and why. I had a quick
> look
> but it wasn't obvious.
>
> We should not need 1) a system call, 2) a proc interface, and 3) a mmap of
> /dev/mem.
>
> If the syscall's not sufficient and we really need to mmap, we should create
> a
> device which can then be mmapped in a more standard way.
>
> Having said that, Nathan's been moving more of the hotplug logic into the
> kernel, so I'm also not clear on how much of the existing API we will need
> in
> the future. So yep hopefully Nathan can chime in.

Yeah, but if we're going to move to only one interface to work with
RTAS we can break existing applications.

>
> cheers
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

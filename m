Return-Path: <keescook@google.com>
Received: from mail-vk0-x232.google.com (mail-vk0-x232.google.com
 [IPv6:2607:f8b0:400c:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgWvq1wm5zDqMZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 16:54:44 +1100 (AEDT)
Received: by mail-vk0-x232.google.com with SMTP id w201so10218015vkw.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 21:54:43 -0800 (PST)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87r2ppvaeq.fsf@concordia.ellerman.id.au>
References: <20180212133731.GE3443@dhcp22.suse.cz>
 <87r2ppvaeq.fsf@concordia.ellerman.id.au>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 12 Feb 2018 21:54:39 -0800
Message-ID: <CAGXu5j+DnkUv9pZn93wxA6_2s+c3Ap_Q34OR0weY7Y9MJ1aP9Q@mail.gmail.com>
Subject: Re: samples/seccomp/ broken when cross compiling s390,
 ppc allyesconfig
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@kernel.org>, Will Drewry <wad@chromium.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 12, 2018 at 7:25 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Michal Hocko <mhocko@kernel.org> writes:
>> Hi,
>> my build test machinery chokes on samples/seccomp when cross compiling
>> s390 and ppc64 allyesconfig. This has been the case for quite some
>> time already but I never found time to look at the problem and report
>> it. It seems this is not new issue and similar thing happend for
>> MIPS e9107f88c985 ("samples/seccomp/Makefile: do not build tests if
>> cross-compiling for MIPS").
>>
>> The build logs are attached.
>>
>> What is the best way around this? Should we simply skip compilation on
>> cross compile or is actually anybody relying on that? Or should I simply
>> disable it for s390 and ppc?
>
> The whole thing seems very confused. It's not building for the target,
> it's building for the host, ie. the Makefile sets hostprogs-m and
> HOSTCFLAGS etc.
>
> So it can't possibly work with cross compiling as it's currently
> written.
>
> Either the Makefile needs some serious work to properly support cross
> compiling or it should just be disabled when cross compiling.

Hrm, yeah, the goal was to entirely disable cross compiling, but I
guess we didn't hit it with a hard enough hammer. :)

-Kees

-- 
Kees Cook
Pixel Security

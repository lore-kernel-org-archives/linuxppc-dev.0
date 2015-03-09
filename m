Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0112.outbound.protection.outlook.com [157.56.110.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DC0B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 19:26:48 +1100 (AEDT)
Message-ID: <54FD592F.7080202@freescale.com>
Date: Mon, 9 Mar 2015 10:26:23 +0200
From: Purcareata Bogdan <b43198@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 0/3] powerpc: Enable seccomp filter support
References: <1424247413-20753-1-git-send-email-bogdan.purcareata@freescale.com>	
 <54F01C85.2020602@freescale.com>
 <1425070490.4645.86.camel@kernel.crashing.org>
In-Reply-To: <1425070490.4645.86.camel@kernel.crashing.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Cc: linux-kernel@vger.kernel.org, pmoore@redhat.com, paulus@samba.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.02.2015 22:54, Benjamin Herrenschmidt wrote:
> On Fri, 2015-02-27 at 09:28 +0200, Purcareata Bogdan wrote:
>> Ping?
>
> What is the ping for ?
>
> Ben.

Making sure the patches are not lost on the mailing lists :) Didn't 
receive any feedback on v4 and just wanted to check if there's anything 
more I can do.

Thank you,
Bogdan P.

>> On 18.02.2015 10:16, Bogdan Purcareata wrote:
>>> Add the missing pieces in order to enable SECCOMP_FILTER on PowerPC
>>> architectures, and enable this support.
>>>
>>> Testing has been pursued using libseccomp with the latest ppc support patches
>>> [1][2], on Freescale platforms for both ppc and ppc64. Support on ppc64le has
>>> also been tested, courtesy of Mike Strosaker.
>>>
>>> [1] https://groups.google.com/forum/#!topic/libseccomp/oz42LfMDsxg
>>> [2] https://groups.google.com/forum/#!topic/libseccomp/TQWfCt_nD7c
>>>
>>> v4:
>>> - rebased on top of 3.19
>>>
>>> v3:
>>> - keep setting ENOSYS in syscall entry assembly when syscall tracing is disabled
>>>
>>> v2:
>>> - move setting ENOSYS from syscall entry assembly to do_syscall_trace_enter
>>>
>>> Bogdan Purcareata (3):
>>>     powerpc: Don't force ENOSYS as error on syscall fail
>>>     powerpc: Relax secure computing on syscall entry trace
>>>     powerpc: Enable HAVE_ARCH_SECCOMP_FILTER
>>>
>>>    arch/powerpc/Kconfig           | 1 +
>>>    arch/powerpc/kernel/entry_32.S | 7 ++++++-
>>>    arch/powerpc/kernel/entry_64.S | 5 +++--
>>>    arch/powerpc/kernel/ptrace.c   | 8 ++++++--
>>>    4 files changed, 16 insertions(+), 5 deletions(-)
>>>
>
>

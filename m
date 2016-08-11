Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s94xP07Z9zDqfj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:07:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: move hmi.c to arch/powerpc/kvm/
In-Reply-To: <87vaz8t62z.fsf@concordia.ellerman.id.au>
References: <1470224194-15412-1-git-send-email-pbonzini@redhat.com>
 <20160810184127.GA27257@potion> <87vaz8t62z.fsf@concordia.ellerman.id.au>
Date: Thu, 11 Aug 2016 21:07:48 +1000
Message-ID: <87popftvgb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com> writes:
>
>> 2016-08-03 13:36+0200, Paolo Bonzini:
>>> hmi.c functions are unused unless sibling_subcore_state is nonzero, and
>>> that in turn happens only if KVM is in use.  So move the code to
>>> arch/powerpc/kvm/, putting it under CONFIG_KVM_BOOK3S_64_HANDLER
>>> rather than CONFIG_PPC_BOOK3S_64.  The sibling_subcore_state is also
>>> included in struct paca_struct only if KVM is supported by the kernel.
>>>=20
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: kvm-ppc@vger.kernel.org
>>> Cc: kvm@vger.kernel.org
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>> 	It would be nice to have this in 4.8, to minimize any 4.9 conflicts.
>>> 	Build-tested only, with and without KVM enabled.
>>
>> If you agree with the change, would you prefer to have this patch merged
>> through the PowerPC tree?
>
> Yeah I'll pull it into my fixes branch.

And then I pulled it out again:

  (.text+0x157fc): undefined reference to `.wait_for_subcore_guest_exit'
  (.text+0x15834): undefined reference to `.wait_for_tb_resync'
  make[1]: *** [vmlinux] Error 1

http://kisskb.ellerman.id.au/kisskb/buildresult/12775422/

cheers

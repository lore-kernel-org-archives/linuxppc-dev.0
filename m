Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 8D9B62C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 21:54:12 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RESEND v4] powerpc: kvm: fix rare but potential deadlock
 scene
Date: Wed, 20 Nov 2013 11:53:33 +0100
Message-Id: <2E495A93-B729-49D8-B225-2213460EF3C4@suse.de>
References: <1384841568-20986-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <C03A0DFC-4883-43CA-8EBB-0F80821C31BE@suse.de>
 <CAFgQCTvYikfqKpZn0twggeg7OX56JkvZibWjxM1wn8qPS33RGw@mail.gmail.com>
In-Reply-To: <CAFgQCTvYikfqKpZn0twggeg7OX56JkvZibWjxM1wn8qPS33RGw@mail.gmail.com>
To: Liu ping fan <kernelfans@gmail.com>
Cc: Gleb Natapov <gleb@redhat.com>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 20.11.2013 um 03:42 schrieb Liu ping fan <kernelfans@gmail.com>:
>=20
>> On Tue, Nov 19, 2013 at 6:39 PM, Alexander Graf <agraf@suse.de> wrote:
>>=20
>>> On 19.11.2013, at 07:12, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>>=20
>>> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
>>> realmode, so it can trigger the deadlock.
>>>=20
>>> Suppose the following scene:
>>>=20
>>> Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of
>>> vcpus.
>>>=20
>>> If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched
>>> out, and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be
>>> caught in realmode for a long time.
>>>=20
>>> What makes things even worse if the following happens,
>>> On cpuM, bitlockX is hold, on cpuN, Y is hold.
>>> vcpu_B_2 try to lock Y on cpuM in realmode
>>> vcpu_A_2 try to lock X on cpuN in realmode
>>>=20
>>> Oops! deadlock happens
>>>=20
>>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>>=20
>> Any particular reason for the resend? The patch is already applied, no?
> Oh, seems that I misunderstood your meaning. You said "Actually, I've
> changed my mind and moved the patch to the for-3.13 branch instead.
> Please make sure to CC kvm@vger on all patches you submit though". So
> I think it is necessary to resend with cc kvm@vger

Oh. I meant "for next time" :). But now that it happened for this patch alre=
ady it's even better.

Thanks a lot!

Alex

>=20
> Regards,
> Pingfan

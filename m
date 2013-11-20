Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x232.google.com (mail-qc0-x232.google.com
 [IPv6:2607:f8b0:400d:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 227662C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 13:42:29 +1100 (EST)
Received: by mail-qc0-f178.google.com with SMTP id i7so5490354qcq.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 18:42:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C03A0DFC-4883-43CA-8EBB-0F80821C31BE@suse.de>
References: <1384841568-20986-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <C03A0DFC-4883-43CA-8EBB-0F80821C31BE@suse.de>
Date: Wed, 20 Nov 2013 10:42:26 +0800
Message-ID: <CAFgQCTvYikfqKpZn0twggeg7OX56JkvZibWjxM1wn8qPS33RGw@mail.gmail.com>
Subject: Re: [PATCH RESEND v4] powerpc: kvm: fix rare but potential deadlock
 scene
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Gleb Natapov <gleb@redhat.com>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 19, 2013 at 6:39 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 19.11.2013, at 07:12, Liu Ping Fan <kernelfans@gmail.com> wrote:
>
>> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
>> realmode, so it can trigger the deadlock.
>>
>> Suppose the following scene:
>>
>> Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of
>> vcpus.
>>
>> If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched
>> out, and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be
>> caught in realmode for a long time.
>>
>> What makes things even worse if the following happens,
>>  On cpuM, bitlockX is hold, on cpuN, Y is hold.
>>  vcpu_B_2 try to lock Y on cpuM in realmode
>>  vcpu_A_2 try to lock X on cpuN in realmode
>>
>> Oops! deadlock happens
>>
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>
> Any particular reason for the resend? The patch is already applied, no?
>
Oh, seems that I misunderstood your meaning. You said "Actually, I've
changed my mind and moved the patch to the for-3.13 branch instead.
Please make sure to CC kvm@vger on all patches you submit though". So
I think it is necessary to resend with cc kvm@vger

Regards,
Pingfan

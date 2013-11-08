Return-Path: <kernelfans@gmail.com>
Received: from mail-qe0-x232.google.com (mail-qe0-x232.google.com
 [IPv6:2607:f8b0:400d:c02::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E4482C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 19:38:26 +1100 (EST)
Received: by mail-qe0-f50.google.com with SMTP id 1so1621221qee.37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Nov 2013 00:38:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFgQCTvWAAr83nq9MmZm44Om36kYC3tOnkUPumfRAVCeYXjLAg@mail.gmail.com>
References: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <470E7CC0-6397-4343-89DA-6818531E6775@suse.de>
 <CAFgQCTvWAAr83nq9MmZm44Om36kYC3tOnkUPumfRAVCeYXjLAg@mail.gmail.com>
Date: Fri, 8 Nov 2013 16:38:19 +0800
Message-ID: <CAFgQCTv98HzhHZKX+QCc0hebdHQweNzaJhpxZJzvpp1eQgKcmw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: kvm: optimize "sc 0" as fast return
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 8, 2013 at 12:19 PM, Liu ping fan <kernelfans@gmail.com> wrote:
> On Fri, Nov 8, 2013 at 11:10 AM, Alexander Graf <agraf@suse.de> wrote:
>>
>> On 08.11.2013, at 03:44, Liu Ping Fan <kernelfans@gmail.com> wrote:
>>
>>> syscall is a very common behavior inside guest, and this patch
>>> optimizes the path for the emulation of BOOK3S_INTERRUPT_SYSCALL,
>>> so hypervisor can return to guest without heavy exit, i.e, no need
>>> to swap TLB, HTAB,.. etc
>>
>> The syscall exit you touch here only happens when you do an sc > 0 with MSR_PR set inside the guest. The only case you realistically see this is when you run PR KVM inside of an HV KVM guest.
>>
> Maybe I misunderstood the ISA spec, but refer for "6.5.14 System Call
> Interrupt", no description about the MSR_PR when sc trigger a syscall
> interrupt. So I think, guest application "sc 0" will also fall to the
> kernel who owns hypervisor mode.  Am I right?
>
Some further comment: I think the essential of the problem is whether
we switch RMA from guest to HV when interrupts raise.
DSI/ISI will be redirected to HDSI and RMA switch.  But what about
SYSCALL, and DEC, external interrupt, ...etc?

>> I don't think we should optimize for that case. Instead, we should rather try to not bounce to the 1st hypervisor in the first place in that scenario :).
>>
> Sorry, but just want to make clear about the idiom:  0 -> kernel run
> with NV, and 1st -> kernel run on HV-KVM and provide PR-KVM to up
> layer? Right?
>
> When you say "try to not bounce to the 1st hypervisor ", what is the
> exact meaning and how can we achieve this?  I am a quite newer on
> powerpc, and hope that I can get more clear figure about it  :)
>

Thanks
Pingfan

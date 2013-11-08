Return-Path: <kernelfans@gmail.com>
Received: from mail-qe0-x22c.google.com (mail-qe0-x22c.google.com
 [IPv6:2607:f8b0:400d:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D5E22C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 15:20:29 +1100 (EST)
Received: by mail-qe0-f44.google.com with SMTP id 6so1487905qeb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Nov 2013 20:20:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1383883907.4776.215.camel@pasglop>
References: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <470E7CC0-6397-4343-89DA-6818531E6775@suse.de>
 <1383883503.4776.214.camel@pasglop>
 <1383883907.4776.215.camel@pasglop>
Date: Fri, 8 Nov 2013 12:20:23 +0800
Message-ID: <CAFgQCTtkc7YoWG2p1xrPTKHoR2S7fE1ZEc1xaBQvxe6bMWsE0w@mail.gmail.com>
Subject: Re: [PATCH] powerpc: kvm: optimize "sc 0" as fast return
From: Liu ping fan <kernelfans@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 8, 2013 at 12:11 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2013-11-08 at 15:05 +1100, Benjamin Herrenschmidt wrote:
>> On Fri, 2013-11-08 at 04:10 +0100, Alexander Graf wrote:
>> > On 08.11.2013, at 03:44, Liu Ping Fan <kernelfans@gmail.com> wrote:
>> >
>> > > syscall is a very common behavior inside guest, and this patch
>> > > optimizes the path for the emulation of BOOK3S_INTERRUPT_SYSCALL,
>> > > so hypervisor can return to guest without heavy exit, i.e, no need
>> > > to swap TLB, HTAB,.. etc
>> >
>> > The syscall exit you touch here only happens when you do an sc > 0
>> > with MSR_PR set inside the guest. The only case you realistically see
>> > this is when you run PR KVM inside of an HV KVM guest.
>> >
>> > I don't think we should optimize for that case. Instead, we should
>> > rather try to not bounce to the 1st hypervisor in the first place in
>> > that scenario :).
>>
>> Well, so unfortunately openstack CI uses PR inside HV pretty
>> heavily .... it *might* be worthwhile optimizing that path if the patch
>> is simple enough... I'd make that Paul's call.
>
> Note that this is a statement of value for the idea ... not the
> implementation ;-) From a quick look with Paulus, the patch is quite
> broken. I'll let Paul comment in details.
>
Thank you very much,

Regards,
Pingfan

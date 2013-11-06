Return-Path: <kernelfans@gmail.com>
Received: from mail-qa0-x230.google.com (mail-qa0-x230.google.com
 [IPv6:2607:f8b0:400d:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F37F2C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 18:26:46 +1100 (EST)
Received: by mail-qa0-f48.google.com with SMTP id w8so1819984qac.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Nov 2013 23:26:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131106050100.GC14842@drongo>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131106050100.GC14842@drongo>
Date: Wed, 6 Nov 2013 15:26:42 +0800
Message-ID: <CAFgQCTuZ8tG4vA_tbQ9988aXhSdcxSD+MX7XqVcjrdT7xWjYBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc/kvm: simplify the entering logic for
 secondary thread
From: Liu ping fan <kernelfans@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 6, 2013 at 1:01 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Tue, Nov 05, 2013 at 03:42:42PM +0800, Liu Ping Fan wrote:
>> After the primary vcpu changes vcore_state to VCORE_RUNNING, there is
>> very little chance to schedule to secondary vcpu. So if we change the
>
> Why do you say there is very little chance to run the secondary vcpu?
>
>> code sequence around set vcore_state to VCORE_RUNNING and disable
>> preemption, we lost little. But we simplify the entering logi, based on
>> the fact that if primary vcpu runs, the secondary vcpu can not be scheduled.
>
> If a vcpu does a hypercall or something else that requires the host
> (kernel or userspace) to do something, that can happen in the context
> of the vcpu task for that vcpu.  That vcpu task can run on another
> core (unless it has been pinned).  When it is finished we would like
> the vcpu to continue executing in the guest as soon as possible.  The
> code that you remove in this patch enables that to happen without
> having to wait until the other threads exit the guest.  So I don't
> think it is a good idea to remove this code.
>
Yes, you are right.

Thanks and regards,
Pingfan


> Regards,
> Paul.

Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438FF1A1E06
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 08:56:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 2 Sep 2015 08:56:07 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 766EE2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 08:56:04 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t81MtmJN1769838
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 08:55:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t81MtWYZ023435
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 08:55:32 +1000
Message-ID: <1441148107.2668.57.camel@au1.ibm.com>
Subject: Re: [PATCH] KVM: ppc: Fix size of the PSPB register
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Thomas Huth <thuth@redhat.com>, kvm-ppc@vger.kernel.org, Alexander Graf
 <agraf@suse.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Date: Wed, 02 Sep 2015 08:55:07 +1000
In-Reply-To: <20150901224521.GC23007@fergus.ozlabs.ibm.com>
References: <1441143678-14295-1-git-send-email-thuth@redhat.com>
 <1441146305.2668.51.camel@au1.ibm.com>
 <20150901224521.GC23007@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-02 at 08:45 +1000, Paul Mackerras wrote:
> On Wed, Sep 02, 2015 at 08:25:05AM +1000, Benjamin Herrenschmidt
> wrote:
> > On Tue, 2015-09-01 at 23:41 +0200, Thomas Huth wrote:
> > > The size of the Problem State Priority Boost Register is only
> > > 32 bits, so let's change the type of the corresponding variable
> > > accordingly to avoid future trouble.
> > 
> > It's not future trouble, it's broken today for LE and this should
> > fix
> > it BUT ....
> 
> No, it's broken today for BE hosts, which will always see 0 for the
> PSPB register value.  LE hosts are fine.

0 or PSPB << 32 ?

> > The asm accesses it using lwz/stw and C accesses it as a ulong. On
> > LE
> > that will mean that userspace will see the value << 32
> 
> No, that will happen on BE, and since KVM_REG_PPC_PSPB says it's a
> 32-bit register, we'll just pass 0 back to userspace when it reads
> it.

Ah ok, I missed that bit about KVM_REG_PPC_PSPB

> > Now "fixing" it might break migration if that field is already
> > stored/loaded in its "broken" form. We may have to keep the
> > "broken"
> > behaviour and document that qemu sees a value shifted by 32.
> 
> It will be being set to 0 on BE hosts across migration today
> (fortunately 0 is a benign value for PSPB).  If we fix this on both
> the source and destination host, then the value will get migrated
> across correctly.

Ok, I missed the part where KVM_REG_PPC_PSPB passed it down as a 32
-bit. That means Thomas patch should work indeed.

> I think Thomas's patch is fine, it just needs a stronger patch
> description saying that it fixes an actual bug.

Right.

Cheers,
Ben.

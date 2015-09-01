Return-Path: <benh@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C49061A1E07
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 08:31:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 2 Sep 2015 08:31:25 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CF2CF2CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 08:31:22 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t81MVEAd47644848
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 08:31:22 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t81MUo9c016505
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 08:30:50 +1000
Message-ID: <1441146625.2668.53.camel@au1.ibm.com>
Subject: Re: [PATCH] KVM: ppc: Fix size of the PSPB register
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Paul Mackerras <paulus@ozlabs.org>, Thomas Huth <thuth@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Date: Wed, 02 Sep 2015 08:30:25 +1000
In-Reply-To: <20150901222434.GA23007@fergus.ozlabs.ibm.com>
References: <1441143678-14295-1-git-send-email-thuth@redhat.com>
 <20150901222434.GA23007@fergus.ozlabs.ibm.com>
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

On Wed, 2015-09-02 at 08:24 +1000, Paul Mackerras wrote:
> On Tue, Sep 01, 2015 at 11:41:18PM +0200, Thomas Huth wrote:
> > The size of the Problem State Priority Boost Register is only
> > 32 bits, so let's change the type of the corresponding variable
> > accordingly to avoid future trouble.
> 
> Since we're already using lwz/stw in the assembly code in
> book3s_hv_rmhandlers.S, this is actually a bug fix, isn't it?
> How did you find it?  Did you observe a failure of some kind, or did
> you just find it by code inspection?

Won't the fix break migration ? Unless qemu doens't migrate it ...

> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

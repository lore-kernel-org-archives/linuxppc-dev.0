Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swHhW1xXQzDt2K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 17:27:39 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 128so6575339pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 23:27:39 -0700 (PDT)
Date: Fri, 14 Oct 2016 17:27:30 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org, kvm-ppc@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, sam.bobroff@au1.ibm.com
Subject: Re: [PATCH 0/6] kvm: powerpc halt polling updates
Message-ID: <20161014172730.127ed3fb@roar.ozlabs.ibm.com>
In-Reply-To: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
References: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 14 Oct 2016 11:53:18 +1100
Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:

> This patch series makes some updates and bug fixes to the powerpc kvm-hv
> halt polling code.
> 
> The first two patches are concerned with exporting the generic kvm module
> parameter variables and accessing these from the powerpc specific code.
> 
> The third patch fixes a bug where changing the global max halt polling
> interval module parameter can sometimes have no effect.
> 
> The fourth patch decreases the default global max halt polling interval
> to something more sensible.
> 
> The fifth patch contains generic fixups with no functional effect.
> 
> The last patch adds halt polling documentation.

I want to enable polling idle in Linux for SPLPAR/KVM as we do for
dedicated mode. Essentially the guest OS will spin for a small time
before ceding.

There will be a lot of interaction between this and halt polling. I
think guest polling may still be worthwhile if you have halt polling in
the host, although it might be less effective. We should set up some
performance testing with various guest/host parameters and see what
works best. What have you been testing with so far?

Thanks,
Nick

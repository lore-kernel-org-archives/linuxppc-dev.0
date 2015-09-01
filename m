Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4743E1A1E06
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 08:24:38 +1000 (AEST)
Date: Wed, 2 Sep 2015 08:24:34 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: ppc: Fix size of the PSPB register
Message-ID: <20150901222434.GA23007@fergus.ozlabs.ibm.com>
References: <1441143678-14295-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441143678-14295-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 01, 2015 at 11:41:18PM +0200, Thomas Huth wrote:
> The size of the Problem State Priority Boost Register is only
> 32 bits, so let's change the type of the corresponding variable
> accordingly to avoid future trouble.

Since we're already using lwz/stw in the assembly code in
book3s_hv_rmhandlers.S, this is actually a bug fix, isn't it?
How did you find it?  Did you observe a failure of some kind, or did
you just find it by code inspection?

Paul.

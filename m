Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7EE021A1E18
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 17:16:28 +1000 (AEST)
Subject: Re: [PATCH] KVM: ppc: Fix size of the PSPB register
To: Paul Mackerras <paulus@ozlabs.org>
References: <1441143678-14295-1-git-send-email-thuth@redhat.com>
 <20150901222434.GA23007@fergus.ozlabs.ibm.com>
Cc: kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55E6A245.2050108@redhat.com>
Date: Wed, 2 Sep 2015 09:16:21 +0200
MIME-Version: 1.0
In-Reply-To: <20150901222434.GA23007@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/15 00:24, Paul Mackerras wrote:
> On Tue, Sep 01, 2015 at 11:41:18PM +0200, Thomas Huth wrote:
>> The size of the Problem State Priority Boost Register is only
>> 32 bits, so let's change the type of the corresponding variable
>> accordingly to avoid future trouble.
> 
> Since we're already using lwz/stw in the assembly code in
> book3s_hv_rmhandlers.S, this is actually a bug fix, isn't it?
> How did you find it?  Did you observe a failure of some kind, or did
> you just find it by code inspection?

Code inspection. I was looking for similar problems like the issue with
the XER register that we've hit recently
(https://patchwork.ozlabs.org/patch/476872/) while I was trying to debug
a similar problem.

 Thomas

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19A561A06A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 09:33:47 +1100 (AEDT)
Message-ID: <1417041226.12952.1.camel@concordia>
Subject: Re: powerpc/powernv: Fix the hmi event version check.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 27 Nov 2014 09:33:46 +1100
In-Reply-To: <5475AAC8.7040105@linux.vnet.ibm.com>
References: <20141126034419.0917A1401B1@ozlabs.org>
 <5475AAC8.7040105@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-26 at 15:56 +0530, Mahesh Jagannath Salgaonkar wrote:
> On 11/26/2014 09:14 AM, Michael Ellerman wrote:
> > On Thu, 2014-20-11 at 04:14:36 UTC, Mahesh Salgaonkar wrote:
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> The current HMI event structure is an ABI and carries a version field to
> >> accommodate future changes without affecting/rearranging current structure
> >> members that are valid for previous versions. The current version check
> >> "if (hmi_evt->version != OpalHMIEvt_V1)" seems to consider that version
> >> will always be V1 which may not be true in future. If we start supporting
> >> HMI event > V1, this check would fail without printing anything on older
> >> kernels. This patch fixes this issue.
> > 
> > It's not clear what you mean when you say "this check would fail without
> > printing anything". The check will fail, and it will print something, ie. the
> > error message.
> > 
> > What you mean is "the check will fail, and the HMI info will not be printed".
> 
> My Bad, Yes. I meant 'HMI info will not be printed'. Do you want me to
> re spin the patch with correction.

No that's fine, I've fixed it up to be:

    The current HMI event structure is an ABI and carries a version field to
    accommodate future changes without affecting/rearranging current structure
    members that are valid for previous versions.
    
    The current version check "if (hmi_evt->version != OpalHMIEvt_V1)"
    doesn't accomodate the fact that the version number may change in
    future.
    
    If firmware starts returning an HMI event with version > 1, this check
    will fail and no HMI information will be printed on older kernels.
    
    This patch fixes this issue.


> > I'll CC this to stable unless you disagree.
> 
> Yes. This patch needs to go to stable.

Yep I've added Cc stable to the patch.

cheers

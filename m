Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD5691A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 10:45:05 +1100 (AEDT)
Message-ID: <1427413505.23142.3.camel@ellerman.id.au>
Subject: Re: [PATCH v3] powerpc: Use PFN_PHYS() to avoid truncating the
 physical address
From: Michael Ellerman <mpe@ellerman.id.au>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Fri, 27 Mar 2015 10:45:05 +1100
In-Reply-To: <5514264A.6020502@Freescale.com>
References: <1427291352-31256-1-git-send-email-Emilian.Medve@Freescale.com>
 <FB8A0580-9A76-4F83-BDE7-2EECC0063C1C@kernel.crashing.org>
 <5514264A.6020502@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@Freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 10:31 -0500, Emil Medve wrote:
> Hello Kumar,
> 
> 
> On 03/26/2015 10:18 AM, Kumar Gala wrote:
> > Why no commit message with what issue this change was trying to fix?
> 
> A while back, when I attempted to remove bootmem (in favor of just plain
> memblock as in powerpc land bootmem was just a wrapper to memblock
> anyway) I run at some point into a problem with an intermediate address
> value because of this '<< PAGE_SHIFT' on the wrong width variable. Using
> PFN_PHYS() took care of it (it has a cast) so I decided to get this
> defensive patch applied. Since, I dropped my bootmem/memblock patches in
> favor to Anton's (Blanchard) work so my concrete issue example is
> somewhat gone

I'm not a big fan of it unless it's actually fixing an issue. It's a lot of
churn and the end result is less readable IMHO.

cheers

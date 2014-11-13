Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E97201A019F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 16:42:27 +1100 (AEDT)
Message-ID: <1415857347.28703.8.camel@concordia>
Subject: Re: [PATCH V2] powerpc/TM: Disable/Enable TM looking at the ibm,
 pa-features device tree entry
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 13 Nov 2014 16:42:27 +1100
In-Reply-To: <87d28tasfe.fsf@linux.vnet.ibm.com>
References: <1414938762-20126-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415753046.5175.22.camel@neuling.org> <87d28tasfe.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-11-12 at 11:09 +0530, Aneesh Kumar K.V wrote:
> Michael Neuling <mikey@neuling.org> writes:
> 
> > On Sun, 2014-11-02 at 20:02 +0530, Aneesh Kumar K.V wrote:
> >> Runtime disable transactional memory feature looking at pa-features
> >> device tree entry. We need to do this so that we can run a kernel
> >> built with TM config in PR mode. 
> >
> > I'm happy to turn this off but why do we need to do this in PR mode?
> > Can you explain this in the commit message.
> 
> Hmm, that commit message needs an update. I initially did the patch for
> P8 PR support and wanted a mechanism to disable TM. Alex added basic TM
> support for PR mode after that. So we can drop the PR part of the
> commit message.
> 
> Michael Ellerman,
> 
> Let me know if you want me to send an updated version with the those
> part of the commit message dropped

How about:

  powerpc: Disable CPU_FTR_TM if TM is disabled by firmware
  
  Firmware is allowed to communicate to us via the "ibm,pa-features" property
  that TM (Transactional Memory) support is disabled.
  
  Currently this doesn't happen on any platform we're aware of, but we should
  honor it anyway.


cheers

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC3AF1A013F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 19:32:31 +1000 (EST)
Message-ID: <1402997541.7661.128.camel@pasglop>
Subject: Re: [PATCH] powerpc/kvm: support to handle sw breakpoint
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 17 Jun 2014 19:32:21 +1000
In-Reply-To: <53A0096D.3020108@suse.de>
References: <1402780097-28827-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53A0022D.5020108@suse.de> <1402996939.7661.126.camel@pasglop>
 <53A0096D.3020108@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, paulus@samba.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-17 at 11:25 +0200, Alexander Graf wrote:
> On 17.06.14 11:22, Benjamin Herrenschmidt wrote:
> > On Tue, 2014-06-17 at 10:54 +0200, Alexander Graf wrote:
> >> Also, why don't we use twi always or something else that actually is
> >> defined as illegal instruction? I would like to see this shared with
> >> book3s_32 PR.
> > twi will be directed to the guest on HV no ? We want a real illegal
> > because those go to the host (for potential emulation by the HV).
> 
> Ah, good point. I guess we need different one for PR and HV then to 
> ensure compatibility with older ISAs on PR.

Well, we also need to be careful with what happens if a PR guest puts
that instruction in, do that stop its HV guest/host ?

What if it's done in userspace ? Do that stop the kernel ? :-)

Maddy, I haven't checked, does your patch ensure that we only ever stop
if the instruction is at a recorded bkpt address ? It still means that a
userspace process can practically DOS its kernel by issuing a lot of
these causing a crapload of exits.

Cheers,
Ben.

> Alex
> 
> > I'm
> > trying to see if I can get the architect to set one in stone in a future
> > proof way.
> >
> > Cheers,
> > Ben.
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

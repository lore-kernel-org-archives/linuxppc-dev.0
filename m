Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0AAB1A0B51
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2016 21:37:53 +1100 (AEDT)
Message-ID: <1456483072.25691.11.camel@ellerman.id.au>
Subject: Re: [PATCH 02/12] powerpc/module: Mark module stubs with a magic value
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org,  mbenes@suse.cz
Date: Fri, 26 Feb 2016 21:37:52 +1100
In-Reply-To: <20160225131727.GD21932@lst.de>
References: <1456324115-21144-1-git-send-email-mpe@ellerman.id.au>
 <1456324115-21144-2-git-send-email-mpe@ellerman.id.au>
 <20160225131727.GD21932@lst.de>
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

On Thu, 2016-02-25 at 14:17 +0100, Torsten Duwe wrote:
> On Thu, Feb 25, 2016 at 01:28:25AM +1100, Michael Ellerman wrote:
> > 
> > We can make that process easier by marking the generated stubs with a
> > magic value, and then looking for that magic value. Altough this is not
> > as rigorous as the current method, I believe it is sufficient in
> > practice.
> 
> The actual magic value is sort of debatable; it should be "improbable"
> enough. But this can be changed easily, for each kernel compile, even.

Yeah. Given the locations we're trying to patch are computed in the first place
from the mcount call sites, I feel like we don't need to be super paranoid
here. The only time I've heard of this code (the current version) tripping up
is when folks are hacking on ftrace.

> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Torsten Duwe <duwe@suse.de>
> 
> [for reference:]

> > +#define STUB_MAGIC 0x73747562 /* stub */

Which is one of:

ori     r21,r19,29811
andi.   r20,r27,30050

Both of which are pretty improbable. They don't appear in any kernel I have
around here.

I have more plans for this code, which would hopefully mean we can get rid of
the magic checking entirely. But I think this is OK for now.

cheers

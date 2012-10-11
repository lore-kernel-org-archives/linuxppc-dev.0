Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id EDE5A2C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2012 03:06:10 +1100 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4C573632-7629-4E7A-8A67-FD4698B7430D@suse.de>
References: <4C573632-7629-4E7A-8A67-FD4698B7430D@suse.de>
 <20121011120502.0211f1267dedf3776e4cf85b@canb.auug.org.au>
 <13876.1349947620@warthog.procyon.org.uk>
To: Alexander Graf <agraf@suse.de>
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the
 powerpc-merge tree
Date: Thu, 11 Oct 2012 17:05:57 +0100
Message-ID: <14077.1349971557@warthog.procyon.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Liu Yu <yu.liu@freescale.com>,
 B04825@freescale.com, linux-kernel@vger.kernel.org,
 Stuart Yoder <stuart.yoder@freescale.com>, dhowells@redhat.com,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> wrote:

> Do I have to move them to their own header file or can I just #ifdef
> __KERNEL__ around the place where __ASSEMBLY__ starts to the end of the
> file?

That depends on whether it happens before or after my disintegration script is
run on the header.  Ben has pulled my powerpc thing into the powerpc tree
already.  If he doesn't mind repulling, then if you give me a patch or a git
branch to fix it, I can apply that and regenerate the powerpc branch.

Otherwise, you need to disintegrate manually:

 (1) Move the public part to arch/powerpc/include/uapi/asm/epapr_hcalls.h

 (2) #include the public part from arch/powerpc/include/asm/epapr_hcalls.h

 (3) Move the "headers-y += epapr_hcalls.h" line from .../asm/Kbuild to
     .../uapi/asm/Kbuild.

You should not then need __KERNEL__ guards in either header.

David

Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E96F1A028E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 12:55:37 +1100 (AEDT)
Message-ID: <1427248536.29319.4.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/pseries: Simplify check for suspendability
 during suspend/migration
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cyril Bur <cyrilbur@gmail.com>
Date: Wed, 25 Mar 2015 12:55:36 +1100
In-Reply-To: <1427158353.8284.12.camel@cyril>
References: <1425500547-22777-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1427158353.8284.12.camel@cyril>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-24 at 11:52 +1100, Cyril Bur wrote:
> On Wed, 2015-03-04 at 12:22 -0800, Tyrel Datwyler wrote:
> > During suspend/migration operation we must wait for the VASI state reported
> > by the hypervisor to become Suspending prior to making the ibm,suspend-me
> > RTAS call. Calling routines to rtas_ibm_supend_me() pass a vasi_state variable
> > that exposes the VASI state to the caller. This is unnecessary as the caller
> > only really cares about the following three conditions; if there is an error
> > we should bailout, success indicating we have suspended and woken back up so
> > proceed to device tree updated, or we are not suspendable yet so try calling
> > rtas_ibm_suspend_me again shortly.
> > 
> > This patch removes the extraneous vasi_state variable and simply uses the
> > return code to communicate how to proceed. We either succeed, fail, or get
> > -EAGAIN in which case we sleep for a second before trying to call
> > rtas_ibm_suspend_me again.
> > 
> Hi Tyrel, sorry this fell off my radar. Thanks for addressing all those
> issues.
> 
> > Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> > Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> > Cc: Cyril Bur <cyrilbur@gmail.com>
> > ---
> > 
> > Changes in v2:
> > - Addressed Cyril's comments as follow:
> > - Removed unused vasi_rc variable
> > - Kept return behavior of ppc_rtas the same in the case of VASI error
> 
> Looks good for ppc_rtas(). Still changing a return value (pointed out
> below) in migrate_store(), we might be ok with that since its the sysfs
> file but mentioning it in the commit message would be a good idea.

Yeah I think that's fine.

> When rtas_ibm_suspend me() now returns -EIO, migrate_store() will now
> return -EIO. It used to return -1.

-1 is EPERM which is wrong, so -EIO is better at least.

Tyrel can you please resend with an updated changelog that documents that
change.

cheers

Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D2B752C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 03:23:05 +1100 (EST)
Message-ID: <1390494165.24905.554.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore
 the core registers
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Thu, 23 Jan 2014 10:22:45 -0600
In-Reply-To: <46dd04cc9b6245fa90d20e2d94ff8523@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
 <1389743456.24905.143.camel@snotra.buserror.net>
 <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842249.24905.196.camel@snotra.buserror.net>
 <6f81ef13c25744b685b99a3fbb304f1b@BN1PR03MB188.namprd03.prod.outlook.com>
 <1390266361.24905.399.camel@snotra.buserror.net>
 <7db8f36932f84bc5bdcb8a7777c55383@BN1PR03MB188.namprd03.prod.outlook.com>
 <1390438219.24905.551.camel@snotra.buserror.net>
 <46dd04cc9b6245fa90d20e2d94ff8523@BN1PR03MB188.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Zhao
 Chenhui-B35336 <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-22 at 20:49 -0600, Wang Dongsheng-B40534 wrote:
> > > >
> > > > The whole point of calling enable_kernel_fp() in C code before
> > > > suspending is to ensure that the FP state gets saved.  If FP is used
> > > > after that point it is a bug.  If you're worried about such bugs, then
> > > > clear MSR[FP] after calling enable_kernel_fp(), rather than adding
> > > > redundant state saving.
> > > >
> > >
> > > enable_kernel_fp() calling in MEM suspend flow.
> > > Hibernation is different with MEM suspend, and I'm not sure where will call
> > this
> > > interface, so we need to ensure the integrity of the core saving. I don't
> > think
> > > this code is *redundant*. I trust that the kernel can keep the FP related
> > > operations, that's why a judgment is here. :)
> > 
> > For hibernation, save_processor_state() is called first, which does
> > flush_fp_to_thread() which has a similar effect (though I wonder if it's
> > being called on the correct task for non-SMP).
> > 
> Yes, thanks, I miss this code.:)
> 
> But I still think we need to keep this judgment, because i provide an API.
> If you still insist on I can remove *FP*, but I don't want to do this..:)

I insist.  Redundant code wastes review and maintenance bandwidth, and
is a potential source of bugs.

-Scott

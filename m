Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94627B7C25
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 08:38:00 +1100 (EST)
Subject: Re: [PATCH 20/27] Split init_new_context and destroy_context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <4AECAA0A.1080304@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-21-git-send-email-agraf@suse.de>
	<20091031154059.750d7213.sfr@canb.auug.org.au>
	<4AECAA0A.1080304@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 01 Nov 2009 08:37:41 +1100
Message-ID: <1257025061.7907.20.camel@pasglop>
Mime-Version: 1.0
Cc: Kevin Wolf <kwolf@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-10-31 at 22:20 +0100, Alexander Graf wrote:
> Stephen Rothwell wrote:
> > Hi Alexander,
> >
> > On Fri, 30 Oct 2009 16:47:20 +0100 Alexander Graf <agraf@suse.de> wrote:
> >   
> >> --- a/arch/powerpc/include/asm/mmu_context.h
> >> +++ b/arch/powerpc/include/asm/mmu_context.h
> >> @@ -23,6 +23,11 @@ extern void switch_slb(struct task_struct *tsk, struct mm_struct *mm);
> >>  extern void set_context(unsigned long id, pgd_t *pgd);
> >>  
> >>  #ifdef CONFIG_PPC_BOOK3S_64
> >> +extern int __init_new_context(void);
> >> +extern void __destroy_context(int context_id);
> >> +#endif
> >> +
> >> +#ifdef CONFIG_PPC_BOOK3S_64
> >>     
> >
> > don't add the #endif/#ifdef pair ...
> 
> Any other comments? I'd like to wind up a final patch set so I can stop
> spamming on all those MLs :-).

Just send an update for -that- patch to the list.

Ben.

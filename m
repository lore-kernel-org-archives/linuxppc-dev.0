Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 923E81007D2
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 18:07:46 +1100 (EST)
In-Reply-To: <1263264045.724.183.camel@pasglop>
References: <1262969186-18462-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1263264045.724.183.camel@pasglop>
Subject: Re: [PATCH] 8xx: fix user space TLB walk in dcbX fixup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFB21A02C2.A1F50F94-ONC12576A9.00270097-C12576A9.00272133@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 12 Jan 2010 08:07:24 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 12/01/2010 03:40:45:
>
> On Fri, 2010-01-08 at 17:46 +0100, Joakim Tjernlund wrote:
> > The newly added fixup for buggy dcbX insn's has
> > a bug that always trigger a kernel TLB walk so a user space
> > dcbX insn will cause a Kernel Machine Check if it hits DTLB error.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >
> > I found this problem in 2.4 and forward ported it to 2.6. I
> > cannot test it so I cannot be 100% sure I got it right.
> >
> >  arch/powerpc/kernel/head_8xx.S |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
>
> Do you have something to make sure that TASK_SIZE is never bigger than
> 2G ? Else userspace could be all the way to 0xbfffffff ...

No, but this is 8xx :) The TLB handlers has the same "limitation" and has always
been so.

      Jocke

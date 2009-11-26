Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E112B6F29
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 16:10:40 +1100 (EST)
Subject: Re: [RFC PATCH 08/19] powerpc: gamecube/wii: do not include PCI
	support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911221521h4844db3cpb33a1afb41833d46@mail.gmail.com>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221521h4844db3cpb33a1afb41833d46@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 16:10:33 +1100
Message-ID: <1259212233.16367.264.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-11-22 at 16:21 -0700, Grant Likely wrote:
> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
> > The Nintendo GameCube and Wii video game consoles do not have PCI hardware.
> > Avoid wasting their scarce memory by not including PCI support into the
> > kernel.
> >
> > Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> > ---
> >  arch/powerpc/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 2ba14e7..84b2566 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -679,7 +679,7 @@ config PPC_PCI_CHOICE
> >  config PCI
> >        bool "PCI support" if PPC_PCI_CHOICE
> >        default y if !40x && !CPM2 && !8xx && !PPC_83xx \
> > -               && !PPC_85xx && !PPC_86xx
> > +               && !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
> 
> phew, this is getting ugly.  But I won't ask you to clean it up.  Ack

Right. We should have the platforms that want PCI do a select
instead :-)

Cheers,
Ben.

Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5FF2314029C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 08:03:05 +1000 (EST)
Message-ID: <1399413774.15726.204.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2 v2] powerpc: Enable NO_BOOTMEM
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 6 May 2014 17:02:54 -0500
In-Reply-To: <1399412988.15726.202.camel@snotra.buserror.net>
References: <1399402084-6325-1-git-send-email-Emilian.Medve@Freescale.com>
 <1399402084-6325-2-git-send-email-Emilian.Medve@Freescale.com>
 <1399412988.15726.202.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-06 at 16:49 -0500, Scott Wood wrote:
> On Tue, 2014-05-06 at 13:48 -0500, Emil Medve wrote:
> > Currently bootmem is just a wrapper around memblock. This gets rid of
> > the wrapper code just as other ARHC(es) did: x86, arm, etc.
> > 
> > For now only cover !NUMA systems/builds
> > 
> > Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> > ---
> > 
> > v2: Acknowledge that NUMA systems/builds are not covered by this patch
> > 
> >  arch/powerpc/Kconfig  | 3 +++
> >  arch/powerpc/mm/mem.c | 8 ++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index e099899..07b164b 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -475,6 +475,9 @@ config SYS_SUPPORTS_HUGETLBFS
> >  
> >  source "mm/Kconfig"
> >  
> > +config NO_BOOTMEM
> > +	def_bool !NUMA
> 
> This will allow a user to manually turn on CONFIG_NO_BOOTMEM in the
> presence of NUMA.  From the changelog it sounds like this is not what
> you intended.

Ignore this part -- I see it doesn't have an option string for it to
show up to the user.

-Scott

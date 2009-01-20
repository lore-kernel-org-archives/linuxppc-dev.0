Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 164F7DDDE0
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 12:19:48 +1100 (EST)
Date: Tue, 20 Jan 2009 04:19:45 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH] mb862xx: Restrict compliation of platform driver to PPC
Message-ID: <20090120011945.GA23380@oksana.dev.rtsoft.ru>
References: <496A89A1.8050302@gmail.com>
	<646765f40901191650v5320f5e4tcc5fb7da0555ade1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <646765f40901191650v5320f5e4tcc5fb7da0555ade1@mail.gmail.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
	Matteo Fortini <m.fortini@selcomgroup.com>, linux-kernel@vger.kernel.org,
	Krzysztof Helt <krzysztof.h1@poczta.fm>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Anatolij Gustschin <agust@denx.de>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2009 at 11:50:33AM +1100, Julian Calaby wrote:
> Ping?
> 
> Does anyone maintain this driver?

Should be Anatolij. ;-)

But I'm interested in this driver as well.

FWIW, the patch looks OK, except for the long lines in the commit log.
Also you'd better mention exact build error in the commit log.

Reviewed-by: Anton Vorontsov <avorontsov@ru.mvista.com>


(Btw, we'd better fix the build for sparc instead of adding another
"depends on". Could anybody point to some recent, working sparc cross
toolchain? Last time I googled for it I found only some prehistoric
versions that I didn't bother to try...)

> (akpm: Sorry for cc'ing you on this, I'm not sure who else to send it to)
> 
> On Mon, Jan 12, 2009 at 11:06, Julian Calaby <julian.calaby@gmail.com> wrote:
> > mb862xx: Restrict compliation of platform driver to PPC
> >
> > The OpenFirmware part of this driver is uncompilable on SPARC due to it's dependance on several PPC specific functions.
> >
> > Restricting this to PPC to prevent these build errors.
> >
> > This was found using randconfig builds.
> >
> > Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
> >
> > ---
> >
> > A couple of notes:
> >
> > 1. After looking at the includes used by this driver, the OF part may not compile cleanly on PPC either as it doesn't appear to pull in the required headers for all the functions and constants it uses.
> >
> > 2. Also, this bug will *not* show up in allmodconfigs or allyesconfigs as the OF part of this driver is prevented from building when the PCI driver is built, and the PCI driver appears first.
> >
> > 3. This patch is over DaveM's sparc-2.6 git tree as of today.
> >
> > 4. I apologise for the massive cross-posting - I am not sure where exactly to send this patch.
> >
> > 5. Please note that I am not a member of any of these lists, so please keep me CC'd.
> >
> > Thanks,
> >
> > Julian Calaby
> >
> > ---
> >  drivers/video/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 6372f8b..8f18169 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -2111,6 +2111,7 @@ config FB_MB862XX_LIME
> >        bool "Lime GDC"
> >        depends on FB_MB862XX
> >        depends on OF && !FB_MB862XX_PCI_GDC
> > +       depends on PPC
> >        select FB_FOREIGN_ENDIAN
> >        select FB_LITTLE_ENDIAN
> >        ---help---
> >
> >

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

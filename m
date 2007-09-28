Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 87EB8DDE9B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:39:05 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3888195wag
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 13:39:04 -0700 (PDT)
Message-ID: <fa686aa40709281339r368d0e1bsfc7fe0399a60f07e@mail.gmail.com>
Date: Fri, 28 Sep 2007 14:39:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 02/18] Add Kconfig macros for Xilinx Virtex support
In-Reply-To: <20070928201946.GB23749@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181558.18608.23527.stgit@trillian.cg.shawcable.net>
	<20070928201946.GB23749@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/28/07, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 28, 2007 at 12:16:01PM -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> >  arch/powerpc/platforms/40x/Kconfig |   30 +++++++++++++++++-------------
> >  1 files changed, 17 insertions(+), 13 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
> > index c3dce3b..1aae0e6 100644
> > --- a/arch/powerpc/platforms/40x/Kconfig
> > +++ b/arch/powerpc/platforms/40x/Kconfig
> > @@ -61,13 +61,14 @@ config WALNUT
> >       help
> >         This option enables support for the IBM PPC405GP evaluation board.
> >
> > -#config XILINX_ML300
> > -#    bool "Xilinx-ML300"
> > -#    depends on 40x
> > -#    default y
> > -#    select VIRTEX_II_PRO
> > -#    help
> > -#      This option enables support for the Xilinx ML300 evaluation board.
> > +config XILINX_VIRTEX_GENERIC_BOARD
> > +     bool "Generic Xilinx Virtex board"
> > +     depends on 40x
> > +     default y
> > +     select VIRTEX_II_PRO
> > +     select VIRTEX_4_FX
> > +     help
> > +       This option enables generic support for Xilinx Virtex based boards.
>
> I would appreciate a bit verboser help text here, i.e. including what
> boards are considered generic. Maybe something like "...including ML403,
> <x>, <y>, and other 4FX/IIPro-based boards"?

Done.

          This option enables generic support for Xilinx Virtex based boards.

+         The generic virtex board support matches any device tree which
+         specifies 'xilinx,virtex' in its compatible field.  This includes
+         the Xilinx ML3xx and ML4xx reference designs using the powerpc
+         core.
+
+         Most Virtex designs should use this unless it needs to do some
+         special configuration at board probe time.
+

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

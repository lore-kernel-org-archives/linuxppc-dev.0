Return-Path: <B07421@freescale.com>
Date: Fri, 17 Jun 2011 11:58:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] powerpc: add support for MPIC message register API
Message-ID: <20110617115828.3cebd5c9@schlenkerla.am.freescale.net>
In-Reply-To: <1308288784.32158.30.camel@pasglop>
References: <1306869543-18812-1-git-send-email-meador_inge@mentor.com>
	<1306869543-18812-3-git-send-email-meador_inge@mentor.com>
	<1308288784.32158.30.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Meador Inge <meador_inge@mentor.com>, openmcapi-dev@googlegroups.com,
	devicetree-discuss@lists.ozlabs.org,
	Hollis Blanchard <hollis_blanchard@mentor.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 17 Jun 2011 15:33:04 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2011-05-31 at 14:19 -0500, Meador Inge wrote:
> > +void mpic_msgr_enable(struct mpic_msgr *msgr)
> > +{
> > +	out_be32(msgr->mer, in_be32(msgr->mer) | (1 << msgr->num));
> > +}
> > +EXPORT_SYMBOL(mpic_msgr_enable);
>=20
> Why are all those exported non-GPL ? We have a policy of making new
> in-kernel APIs generally GPL only.

=46rom Documentation/DocBook/kernel-hacking.tmpl:

  <sect1 id=3D"sym-exportsymbols-gpl">
   <title><function>EXPORT_SYMBOL_GPL()</function>  =20
    <filename class=3D"headerfile">include/linux/module.h</filename></title>
                                                    =20
   <para>                                           =20
    Similar to <function>EXPORT_SYMBOL()</function> except that the
    symbols exported by <function>EXPORT_SYMBOL_GPL()</function> can
    only be seen by modules with a                  =20
    <function>MODULE_LICENSE()</function> that specifies a GPL
    compatible license.  It implies that the function is considered
    an internal implementation issue, and not really an interface.
   </para>                                          =20
  </sect1>

When did this change from "considered an internal implementation issue, and
not really an interface" to "all new interfaces"?

-Scott

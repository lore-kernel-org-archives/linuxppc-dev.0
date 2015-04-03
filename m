Return-Path: <madalin.bucur@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E81591A0A3A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 04:29:57 +1100 (AEDT)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Joe Perches <joe@perches.com>
Subject: RE: [PATCH RFC 10/10] dpaa_eth: add trace points
Date: Fri, 3 Apr 2015 17:29:49 +0000
Message-ID: <BL2PR03MB545935082A02251893B5070E6F10@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1427905196-27778-1-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-2-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-3-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-4-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-5-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-6-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-7-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-8-git-send-email-madalin.bucur@freescale.com>
 <1427905196-27778-9-git-send-email-madalin.bucur@freescale.com>
 <1428079621.13180.10.camel@perches.com>
In-Reply-To: <1428079621.13180.10.camel@perches.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "ruxandra.radulescu@freescale.com" <ruxandra.radulescu@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
>
> On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> > Add trace points on the hot processing path.
>=20
> more trivia:
>=20
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
> []
> > +#define fd_format_name(format)	{ qm_fd_##format, #format }
> > +#define fd_format_list	\
> > +	fd_format_name(contig),	\
> > +	fd_format_name(sg)
>=20
> Are these used anywhere?

Yes, by the Frame Descriptor print:

        /* This is what gets printed when the trace event is triggered */
        TP_printk(TR_FMT,
                  __get_str(name), __entry->fqid, __entry->fd_addr,
                  __print_symbolic(__entry->fd_format, fd_format_list), 		/=
/ <-- here
                  __entry->fd_offset, __entry->fd_length, __entry->fd_statu=
s)


> > +#define TR_FMT "[%s] fqid=3D%d, fd: addr=3D0x%llx, format=3D%s, off=3D=
%u,
> len=3D%u," \
> > +	" status=3D0x%08x"
>=20
> It's nicer to coalesce string fragments.
>=20
> Unless this is intended to be used more than once,
> perhaps it's better to remove it and use the string
> directly instead.
>=20
> > +	/* This is what gets printed when the trace event is triggered */
> > +	TP_printk(TR_FMT,
> > +		  __get_str(name), __entry->fqid, __entry->fd_addr,
> > +		  __print_symbolic(__entry->fd_format, fd_format_list),
> > +		  __entry->fd_offset, __entry->fd_length, __entry-
> >fd_status)
>=20

Checkpatch seems to be less forgiving if the long string is not in a printk=
:

WARNING: line over 80 characters
#22: FILE: drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h:47:
+#define TR_FMT "[%s] fqid=3D%d, fd: addr=3D0x%llx, format=3D%s, off=3D%u, =
len=3D%u, status=3D0x%08x"

Madalin

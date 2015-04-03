Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0043.hostedemail.com
 [216.40.44.43])
 by lists.ozlabs.org (Postfix) with ESMTP id 13EF51A0AA1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 04:54:04 +1100 (AEDT)
Message-ID: <1428083639.13180.44.camel@perches.com>
Subject: Re: [PATCH RFC 10/10] dpaa_eth: add trace points
From: Joe Perches <joe@perches.com>
To: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
Date: Fri, 03 Apr 2015 10:53:59 -0700
In-Reply-To: <BL2PR03MB545935082A02251893B5070E6F10@BL2PR03MB545.namprd03.prod.outlook.com>
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
 <BL2PR03MB545935082A02251893B5070E6F10@BL2PR03MB545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
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

On Fri, 2015-04-03 at 17:29 +0000, Madalin-Cristian Bucur wrote:
> > -----Original Message-----
> > From: Joe Perches [mailto:joe@perches.com]
> >
> > On Wed, 2015-04-01 at 19:19 +0300, Madalin Bucur wrote:
> > > Add trace points on the hot processing path.
> > 
> > more trivia:
> > 
> > > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
> > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h
> > []
> > > +#define fd_format_name(format)	{ qm_fd_##format, #format }
> > > +#define fd_format_list	\
> > > +	fd_format_name(contig),	\
> > > +	fd_format_name(sg)
> > 
> > Are these used anywhere?
> Yes, by the Frame Descriptor print:
> 
>         /* This is what gets printed when the trace event is triggered */
>         TP_printk(TR_FMT,
>                   __get_str(name), __entry->fqid, __entry->fd_addr,
>                   __print_symbolic(__entry->fd_format, fd_format_list), 		// <-- here
>                   __entry->fd_offset, __entry->fd_length, __entry->fd_status)

Thanks.

I think it's nicer when format and argument match
and aren't indirected by macros.

Perhaps this would be better as:

	TP_printk("[%s] fqid=%d, fd: addr=0x%llx, format=%s, off=%u, len=%u, status=0x%08x"
		  __get_str(name), __entry->fqid, __entry->fd_addr,
		  __print_symbolic(__entry->fd_format, fd_format_list),
		  __entry->fd_offset, __entry->fd_length, __entry->fd_status)


> Checkpatch seems to be less forgiving if the long string is not in a printk:

checkpatch is brainless, people aren't.

> WARNING: line over 80 characters
> #22: FILE: drivers/net/ethernet/freescale/dpaa/dpaa_eth_trace.h:47:
> +#define TR_FMT "[%s] fqid=%d, fd: addr=0x%llx, format=%s, off=%u, len=%u, status=0x%08x"

That's a checkpatch defect.  Thanks.  I'll see about fixing it.

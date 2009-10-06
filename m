Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4651B7B8F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Oct 2009 04:32:36 +1100 (EST)
In-Reply-To: <OF8881FD0B.21715064-ONC1257647.005485CA-C1257647.00561D2D@transmode.se>
References: <1254744999-3158-1-git-send-email-Joakim.Tjernlund@transmode.se>	<1254744999-3158-4-git-send-email-Joakim.Tjernlund@transmode.se>
	<1254773824.7122.33.camel@pasglop>	<OF3182684B.BB80DBCF-ONC1257646.0073D59B-C1257646.0075AB6F@transmode.se>
	<1254778643.7122.43.camel@pasglop>		<OF16069D5F.03682AAC-ONC1257646.00774BB8-C1257646.0078E24B@transmode.se>
	<1254780556.7122.47.camel@pasglop>		<OF346FF2E6.3CCDA0FA-ONC1257646.007C13A0-C1257646.007DF396@transmode.se>
	<1254784539.7122.52.camel@pasglop>		<OFB8E4035A.83748CF0-ONC1257646.0080A097-C1257646.00819DD6@transmode.se>
	<1254789255.7122.95.camel@pasglop>		<OFC7D289B7.88EECA01-ONC1257647.001E8F29-C1257647.002265AF
	<1254811547.6035.3.camel@pasglop>
	<OF8881FD0B.21715064-ONC1257647.005485CA-C1257647.00561D2D@transmode.se>
Subject: Re: [PATCH 3/6] 8xx: get rid of _PAGE_HWWRITE dependency in MMU.
Message-ID: <OF29F79FE6.9EADAB98-ONC1257647.005FD0F3-C1257647.005FF83C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 6 Oct 2009 19:28:14 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 06/10/2009 08:45:47:
> >
> > On Tue, 2009-10-06 at 08:15 +0200, Joakim Tjernlund wrote:
> >
> > > Yes, I would too but TLB Miss knows nothing about load/store, protection etc.
> > > because DSISR isn't set. So I cannot see any other way than the TLB Error way.
> >
> > Hrm... that MMU really sucks more than I thought :-(
> >
> > I'll go read the manual and think about that a bit more.
>
> I realise now that for an ITLB Miss I can work out everything I need.
> an ITLB must be a read en everything else is in the linux pte.
> Just check present and user, add accessed if not already there.
> I blame that on too little sleep :)

bugger,  more bugs I think. Need to fix the TLB code some more

Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D73E9B7B7A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Nov 2009 04:16:32 +1100 (EST)
In-Reply-To: <4AF06172.6060407@freescale.com>
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091015165650.GA3837@compile2.chatsunix.int.mrv.com>
	<OFF665748B.AAF26319-ONC1257651.00296F23-C1257651.002D6BF7@transmode.se>
	<20091016202541.GA16358@compile2.chatsunix.int.mrv.com>
	<OF2BB5EF59.1EE0A77D-ONC1257652.003D79DC-C1257652.003EA687@LocalDomain>
	<OFA43B9FDF.F43B1705-ONC1257652.0041B12F-C1257652.004211A3@transmode.se>
	<20091030171607.GA781@loki.buserror.net>
	<20091030173749.GA855@loki.buserror.net>
	<OFD5642C2D.808C2FF1-ONC1257663.004A341C-C1257663.004A6C26@transmode.se>
	<4AF06172.6060407@freescale.com>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF0A6A360A.E7975DC3-ONC1257663.005E8213-C1257663.005EDC37@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 3 Nov 2009 18:16:07 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> wrote on 03/11/2009 17:59:30:
>
> Joakim Tjernlund wrote:
> >> and things seem to work.  You could probably replace the rlwinm by
> >> subtracting PAGE_OFFSET from swapper_pg_dir instead.
> >
> > Just guessing here, do you mean:
> >    lis   r11, (swapper_pg_dir-PAGE_OFFSET)@h
> >    ori   r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
> >    rlwimi   r11, r10, 22, 0xffc
> > or
> >    lis   r11, swapper_pg_dir@h
> >    ori   r11, r11, swapper_pg_dir@l
> >    subis   r11, r11 PAGE_OFFSET
> >    rlwimi   r11, r10, 22, 0xffc
>
> The former.

OK, I will regenerate the patch series with the
 lis   r11, (swapper_pg_dir-PAGE_OFFSET)@h
 ori   r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
 rlwimi   r11, r10, 22, 0xffc
fix.
Have you already confirmed that this works too?

 Jocke

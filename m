Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D130B7123
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Nov 2010 01:43:45 +1100 (EST)
In-Reply-To: <20101112140947.GB28223@oksana.dev.rtsoft.ru>
References: <1289570109-8160-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1289570109-8160-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<20101112140947.GB28223@oksana.dev.rtsoft.ru>
Subject: Re: [PATCH 2/2] ucc_geth: Fix deadlock
To: Anton Vorontsov <cbouatmailru@gmail.com>
Message-ID: <OF95BC4C89.14730D6A-ONC12577DB.005073FE-C12577DB.0050E5CE@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 14 Nov 2010 15:43:37 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov <cbouatmailru@gmail.com> wrote on 2010/11/12 15:09:47:
>
> On Fri, Nov 12, 2010 at 02:55:09PM +0100, Joakim Tjernlund wrote:
> > This script:
> >  while [ 1==1 ] ; do ifconfig eth0 up; usleep 1950000 ;ifconfig eth0 down; dmesg -c ;done
> > causes in just a second or two:
> > INFO: task ifconfig:572 blocked for more than 120 seconds.
> [...]
> > The reason appears to be ucc_geth_stop meets adjust_link as the
> > PHY reports PHY changes. I belive adjust_link hangs somewhere,
> > holding the PHY lock, because ucc_geth_stop disabled the
> > controller HW.
> > Fix is to stop the PHY before disabling the controller.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
>
> It's unclear where exactly adjust_link() hangs, but the patch
> looks as the right thing overall.

Yes, I too cannot find where it is hanging, just that it is hanging somewhere.
I am starting to think it is hanging somewhere else. Anyhow, the hang
goes away 100% when this patch is applied.

 Jocke

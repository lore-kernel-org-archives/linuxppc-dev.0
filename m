Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0CBDB7BBB
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Sep 2009 08:30:39 +1000 (EST)
In-Reply-To: <4ABC94ED.6070508@grandegger.com>
References: <1253620242-18461-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<4ABC94ED.6070508@grandegger.com>
Subject: Re: [PATCH] i2c-mpc: Do not generate STOP after read.
To: Jean Delvare <khali@linux-fr.org>
Message-ID: <OFDA26E787.32612566-ONC125763E.007AD2FD-C125763E.007B4FFC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 28 Sep 2009 00:26:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org,
	Esben Haabendal <eha@doredevelopment.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jean, I just noticed you pull request for i2c on LKML but I didn't see this
patch nor have I got any feedback from you. What is your view?

   Jocke

Wolfgang Grandegger <wg@grandegger.com> wrote on 25/09/2009 12:01:17:
>
> Joakim Tjernlund wrote:
> > The driver always ends a read with a STOP condition which
> > breaks subsequent I2C reads/writes in the same transaction as
> > these expect to do a repeated START(ReSTART).
> >
> > This will also help I2C multimaster as the bus will not be released
> > after the first read, but when the whole transaction ends.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> Tested-by: Wolfgang Grandegger <wg@grandegger.com>
>
> on a MPC8548 board with an up-to-date kernel. I did not realize any
> problems.
>
> Wolfgang.
>

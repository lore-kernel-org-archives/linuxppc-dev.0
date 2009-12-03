Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EBF6CB7BC3
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 02:47:39 +1100 (EST)
In-Reply-To: <4B17D4C5.3070100@gmx.de>
References: <4A124202.4010201@doredevelopment.dk>	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk> <4B17D4C5.3070100@gmx.de>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused	by
	read i2c_msg
To: Michael Lawnick <ml.lawnick@gmx.de>
Message-ID: <OF7F52A719.0BC7DECD-ONC1257681.005605F1-C1257681.00564F6E@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 3 Dec 2009 16:42:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Esben Haabendal <esbenhaabendal@gmail.com>,
	Esben Haabendal <eha@doredevelopment.dk>,
	Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Ben Dooks said the following:
> > On Tue, May 26, 2009 at 01:30:21PM +0200, Esben Haabendal wrote:
> >> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha@doredevelopment.dk> wrote:
> >> > This fixes MAL (arbitration lost) bug caused by illegal use of
> >> > RSTA (repeated START) after STOP condition generated after last byte
> >> > of reads. With this patch, it is possible to do an i2c_transfer() with
> >> > additional i2c_msg's following the I2C_M_RD messages.
> >> >
> >> > It still needs to be resolved if it is possible to fix this issue
> >> > by removing the STOP condition after reads in a robust way.
> >> >
> >> > Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
> >> > ---
> >> > ?drivers/i2c/busses/i2c-mpc.c | ? ?9 +++++++--
> >> > ?1 files changed, 7 insertions(+), 2 deletions(-)
> >>
> >> Any blockers to get this accepted?
> >
> > It would be nice to get an ack from someone who can actually test
> > the driver before getting this merged.
> >
> What is the state of this patch?
> Shouldn't we attack the problem on a more general way by inventing a
> Flag I2C_M_RESTART (or better I2C_M_NO_RESTART for backward compatibility)?
> This way the client driver is able to decide what it needs. If we do the
> choice within adapter, chance is about 50% to be wrong.

I have sent another patch (which I think is in Linus tree already) that
fixes the problem properly.

Can't remember if the driver handles M_RESTART or not. That is
a separate issue though.

      Jocke

Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67B8AB7BC7
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 02:52:39 +1100 (EST)
In-Reply-To: <20091203152916.GC23152@trinity.fluff.org>
References: <4A124202.4010201@doredevelopment.dk>	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk> <4B17D4C5.3070100@gmx.de>
	<20091203152916.GC23152@trinity.fluff.org>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused	by
	read i2c_msg
To: Ben Dooks <ben-linux@fluff.org>
Message-ID: <OF5BEE61B6.E2295369-ONC1257681.0056B9B3-C1257681.0056EB5C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 3 Dec 2009 16:49:23 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Esben Haabendal <esbenhaabendal@gmail.com>,
	Michael Lawnick <ml.lawnick@gmx.de>, linuxppc-dev@ozlabs.org,
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
> On Thu, Dec 03, 2009 at 04:09:57PM +0100, Michael Lawnick wrote:
> > Ben Dooks said the following:
> > > On Tue, May 26, 2009 at 01:30:21PM +0200, Esben Haabendal wrote:
> > >> On Tue, May 19, 2009 at 7:22 AM, Esben Haabendal <eha@doredevelopment.dk> wrote:
> > >> > This fixes MAL (arbitration lost) bug caused by illegal use of
> > >> > RSTA (repeated START) after STOP condition generated after last byte
> > >> > of reads. With this patch, it is possible to do an i2c_transfer() with
> > >> > additional i2c_msg's following the I2C_M_RD messages.
> > >> >
> > >> > It still needs to be resolved if it is possible to fix this issue
> > >> > by removing the STOP condition after reads in a robust way.
> > >> >
> > >> > Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
> > >> > ---
> > >> > ?drivers/i2c/busses/i2c-mpc.c | ? ?9 +++++++--
> > >> > ?1 files changed, 7 insertions(+), 2 deletions(-)
> > >>
> > >> Any blockers to get this accepted?
> > >
> > > It would be nice to get an ack from someone who can actually test
> > > the driver before getting this merged.
> > >
> > What is the state of this patch?
> > Shouldn't we attack the problem on a more general way by inventing a
> > Flag I2C_M_RESTART (or better I2C_M_NO_RESTART for backward compatibility)?
> > This way the client driver is able to decide what it needs. If we do the
> > choice within adapter, chance is about 50% to be wrong.
>
> The documentation for 'struct i2c_msg' already says the STOP should only
> be generated for the last message of the transfer. If STOP is being
> generated for a message that isn't the last in the transfer than this
> is incorrect behaviour.
>
> Unless otherwise indicated, I'll put the patch in the series that I'll
> send to Linus early next week.

Don't, already fixed properly and in Linus tree already.

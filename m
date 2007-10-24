Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710240854l5438e94g86b932f45eb5b546@mail.gmail.com>
Date: Wed, 24 Oct 2007 09:54:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <471F6761.3030405@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<9e4733910710240823v2022661ftb1b754a86cab88f3@mail.gmail.com>
	<471F6761.3030405@freescale.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
> > I see your point about putting the child node onto the control bus.
> > ac97 is both a control and data bus. For the i2s case the child should
> > go onto the i2c bus.
>
> I know AC97 is *also* a control bus, but treating I2S and AC97 differently is
> bad, IMHO.  If you're going to put the child node in the AC97 node, you should
> also put it in the I2S node.

They *are* different.  The choice you're making is whether or not you
keep them similar in the control path or the data path; but you still
have to choose.

>
> The 8610 has an SSI that can operate as either AC97 or I2S.  If I want to switch
> from AC97 to I2S, I should not have to move the child node out of the AC97 node.
>   I should instead just add an I2C node and point to it.

But you need a different codec node regardless.  The board/system will
in the vast majority of cases designed to only use AC97 or only use
I2S.  It's not moving a node.  It's deleting an ac97 codec node and
adding an i2s codec node.

Besides; correctness is more important that how many device tree
changes need to be made to go from one board design to another.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

Message-ID: <3CF7DEA9.AA4DDDB9@motorola.com>
Date: Fri, 31 May 2002 15:35:53 -0500
From: Gary Milliorn <gary.milliorn@motorola.com>
Reply-To: gary.milliorn@motorola.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 64Mbytes on Sandpoint-X3B
References: <20020531060244.15732.qmail@web11204.mail.yahoo.com> <20020531145120.GI32412@opus.bloom.county> <15607.36947.107412.219533@gargle.gargle.HOWL> <20020531151130.GN32412@opus.bloom.county> <3CF7BF85.9AF1FB19@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Mark A. Greer" wrote:
>
> Tom Rini wrote:
>
> > On Fri, May 31, 2002 at 10:01:39AM -0500, Jim Thompson wrote:
> > >
> > > Tom Rini writes:
> > > >
> > > > On Thu, May 30, 2002 at 11:02:44PM -0700, Sergiy Kovtun wrote:
> > > >
> > > > > Hello All,
> > > > > I try to connect all my 64 Meg memoty on
> > > > > Sandpoint-X3B,
> > > > > but received a crash( with 32M all OK).
> > > > > Source:
> > > > > SP-X3B + Altimus MPC7410
> > > > > HHL 2.0
> > > > > Any ideas??
> > > >
> > > > DINK32 12.2 does not correctly initalize the memory controller on-board.
> > > > DINK32 12.3 claims to do this correctly, but in some testing locally it
> > > > still did not get everything correct.
> > >
> > > Could you be more specific as to what is missing?
> >
> > On the DINK32 12.2 side it blindly sets some parts up for 64mb total
> > regardless of the ammount of memory.  I think there's other things as
> > well, but Mark Greer would know better..
>
> I only have 12.2 here and it initializes the wrong amount which will cause a
> panic if you rely on the getting the amount of memory from how the memory ctlr
> regs are set up.
>
> The last time I really looked at what DINK was doing to the mem ctlr was back on
> 12.0 so my info is stale now.  Sounds like Tom has the most current, detailed
> info on what DINK does.  Chances are, Sergiy, is that you'll  have to roll up
> your sleeves and dig into it.
>
> Mark
>

  12.3 is on the web at:
http://e-www.motorola.com/webapp/sps/site/prod_summary.jsp?code=DINK32


  As for the 128MB issue, the BOM for non-SODIMM boards, such as Altimus
X3B,
was increased to 128MB but the SPD writing code (no SODIMMs, so no
pre-programmed
SPD EEPROMs) still only supports 64MB init values (mi -w).  12.4 is not
done
yet but will init with larger sizes.

  In the interim, you could write 'correct' values using the 'dm i2c -a
50 0-7f'
command.  Here's an SPD dump from a 128MB SODIMM:

  0x80,0x08,0x04,0x0c,0x09,0x02,0x40,0x00,
  0x01,0x75,0x54,0x00,0x80,0x10,0x00,0x01,
  0x8f,0x04,0x06,0x01,0x01,0x00,0x0e,0xa0,
  0x60,0x00,0x00,0x14,0x0f,0x14,0x2d,0x10,
  0x15,0x08,0x15,0x08,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x97,
  0x7f,0x98,0x00,0x00,0x00,0x00,0x00,0x00,
  0x46,0x4d,0x34,0x20,0x36,0x34,0x53,0x30,
  0x36,0x34,0x43,0x33,0x2f,0x31,0x32,0x38,
  0x00,0x00,0x00,0x00,0x00,0x01,0x1e,0x1f



--
Gary Milliorn, Motorola
RISC Reference Platforms
Computing Platform Division

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Return-Path: <sha@pengutronix.de>
Date: Fri, 7 Apr 2006 09:37:01 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: MPC5200 + LocalPlus Bus + memcpy
Message-ID: <20060407073701.GC10831@localhost.localdomain>
References: <20060405113825.GA9110@localhost.localdomain>
	<583603349.20060406182144@varma-el.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <583603349.20060406182144@varma-el.com>
Cc: Sylvain Munaut <tnt@246tNt.com>, Paul Mackerras <paulus@samba.org>,
	Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

On Thu, Apr 06, 2006 at 06:21:44PM +0400, Andrey Volkov wrote:
> Hello, Sascha.
> 
> On Wednesday, April 5, 2006, Sascha Hauer wrote:
> 
> > Hi all,
> 
> > I try to use jffs2 on a flash device connected to the mpc5200
> > LocalPlus Bus. This bus does not allow misaligned accesses.
> > The jffs2 code uses memcpy to copy from a word aligned address to an
> > odd address. The ppc memcpy implementation first copies three bytes to get
> > the target address word aligned, but then the source address is on an
> > odd address. The following word accesses on this unaligned address fail
> > badly.
> Invalid crc on 'name' field ;)?

Yes, exactly ;)

> 
> > I have fixed my problem by modifying the physmap mtd driver, but some
> > day someone wants to connect SRAM to the LocalPlus Bus and I guess he
> > will expect memcpy to work.
> Heh, I'll have same problem. Patch (dirty hack)
> attached (vs head of vanilla 2.6. tree)
> 
> > (BTW the arm implementation of memcpy seems to work around this problem)
> Wrong, memcpy to/from SDRAM _may_ be unaligned, only
> memcpy_fromio/memcpy_toio _must_ be aligned to even addresses.

Hm, then a proper fix would be:
- implement an optimized version of memcpy_fromio/memcpy_toio, this
  could be a version of memcpy which only alignes on the io side
- use memcpy_fromio/memcpy_toio in jffs2 code

Do I see this right?

Is SRAM considered io? I know (Arm-)Boards which do not have SDRAM, they
run completely from SRAM.

> 
> P.S.
> Paul, Sylvain, any suggestions to fix it?
> AFAIK, memcpy_to/from_io must be it string.s, isn't it?
> 
> P.P.S Sacha if you start to write mscan driver, then please wait a
> week, I planned to send my work to can-socket at next Friday.

No I haven't started yet, and I will happily wait another week ;)

Sascha

Message-ID: <20040611171732.5878.qmail@web81604.mail.yahoo.com>
Date: Fri, 11 Jun 2004 10:17:32 -0700 (PDT)
From: Greg Goodwin <greg.goodwin@sbcglobal.net>
Subject: Re: U-Boot and kernel 2.6 
To: Wolfgang Denk <wd@denx.de>, David Woodhouse <dwmw2@infradead.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Meriin Michael-BMM063 <Meriin@motorola.com>,
	"'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040611151121.62F07C109F@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As long as the bd_info still allows for my use case I
will be happy.

I have am using the bd_info structure to pass the
differences between several Interphase boards we are
using. Since the MDIO pins and interrupts are
different I am able to use this technique to allow the
same kernel to work with the Interphase 5339F, 4538
and now I am doing the 4532.

If the bd_info structure was fixed this would not be a
problem provided a clear OEM area was defined.

typedef struct bd_info {
    /* commmon */
    void *oem_bd_info_pointer;
} bd_t;

Now filling the oem_bd_info_pointer with anything
other that NULL would allow passing OEM specific
information while still allowing the bd_info fixed
stucture to be defined in a fixed manner.

One example of my use case for the bd_info area is the
fcc_enet driver. In fcc_enet.c I can point to the pin
assigments from the core boot code. Kind of nice since
the fcc_enet driver is this case need not change for
new boards!

For those who care, I did add full MII-TOOL support,
as well as RMON status via procs and I am getting full
line rate on the driver. Still not in great shape for
folding back since it is based on 2.4.20 and not much
care to handle all cases. But it does have some
promise.

>From fcc_enet.c (small example)

  bd_t	 *bd = (bd_t *)__res;

  fip->fc_mdio = bd->bi_fcc_mdio_pin;  /* FCC MDIO pin
*/
  fip->fc_mdck = bd->bi_fcc_mdc_pin;  /* FCC MDC pin
*/


# ttcp -ts -n10000 10.2.0.65
ttcp-t: buflen=8192, nbuf=10000, align=16384/0,
port=5001  tcp  -> 10.2.0.65
ttcp-t: socket
ttcp-t: connect
ttcp-t: 81920000 bytes in 7.52 real seconds = 10642.38
KB/sec +++
ttcp-t: 10000 I/O calls, msec/call = 0.77, calls/sec =
1330.30
ttcp-t: 0.0user 7.4sys 0:07real 100% 0i+0d 0maxrss
0+2pf 0+0csw

# mii-tool eth0
eth0: negotiated 100baseTx-FD, link ok

# cat /proc/driver/fcc_enet/rmon
Total octect counter.................. 0x0060c23a
6341178
Total collision counter............... 0x00000000 0
Total broadcast packet counter........ 0x00000000 0
Total multicast packet count.......... 0x00000000 0
Total packets < 64 bytes.............. 0x00000000 0
Total packets < 64 bytes with errors.. 0x00000000 0
Total packets > 1518.................. 0x00000000 0
Total packets > 1518 with errors...... 0x00000000 0
Total packets == 64 byte,,,,,,,,...... 0x00000000 0
Total packets 64 < bytes <= 127,...... 0x000151d4
86484
Total packets 127 < bytes <= 255...... 0x00000068 104
Total packets 256 < bytes <= 511...... 0x00000000 0
Total packets 512 < bytes <= 1023..... 0x00000001 1
Total packets 1024 < bytes <= 1518.... 0x00000000 0
eth0: MII status: link up, 100 Mbps Full Duplex (FD),
auto-negotiation complete.

# cat /proc/cpuinfo
cpu             : 82xx
sbc             : Interphase 4538 revision 1
monarch         : false
t1/e1 ports     : 2
sdram           : 64MB
local sdram     : none
flash           : 4MB
cam             : none
ima             : not installed
mpc             : MPC8264AZU, 300/200/66MHz, HIP4 rev
B.1
core clock      : 294 MHz
CPM  clock      : 196 MHz
bus  clock      : 65 MHz
revision        : 16.20 (pvr 8081 1014)
bogomips        : 196.19

# cat /proc/cpuinfo
cpu             : 82xx
sbc             : Interphase 5539F revision 1
monarch         : false
t1/e1 ports     : 4
sdram           : 64MB
local sdram     : 8MB
flash           : 4MB
cam             : 16Kx64
ima             : not installed
mpc             : MPC8264AZU, 300/200/66MHz, HIP4 rev
B.1
core clock      : 294 MHz
CPM  clock      : 196 MHz
bus  clock      : 65 MHz
revision        : 16.20 (pvr 8081 1014)
bogomips        : 196.19

That should give you an idea.
>From one user here who uses the bd_info stucture.

Greg

--- Wolfgang Denk <wd@denx.de> wrote:
>
> In message
>
<1086964452.15845.1308.camel@hades.cambridge.redhat.com>
> you wrote:
> > On Fri, 2004-06-11 at 17:16 +0300, Pantelis
> Antoniou wrote:
> > > Yeah, having the bi_recs interface actually
> working
> > > would be ideal, but at the present time nothing
> is
> > > working and as AFAIK no-one is working on it.
> >
> > So we should offer some gentle encouragement. Like
> refusing to accept
> > any further modifications to
> include/asm-ppc/ppcboot.h.
>
> Then you must also refuse to accept any  further
> modifications  that
> define  "struct  bd_info"  for  any boards. Or
> please explain why you
> think that one definiton of bd_info which gets used
> by many boards is
> worse then several private definitions of the same
> structure used  by
> one board only in each case?
>
> Let's see:
>
> linuxppc-2.4				linuxppc-2.5
> ----------------------------------------------------
> -> cd arch/ppc/platforms		-> cd arch/ppc/platforms
> -> grep bd_info * | wc -l		-> grep bd_info * | wc -l
>       6					      8
> -> grep ppcboot.h * | wc -l		-> grep ppcboot.h * |
> wc -l
>       9					     12
>
> Before phasing out a working solution, even if it's
> a  poor  design,
> you should provide a new, better solution.
>
> I promise: I will make sure that U-Boot supports the
> new interface as
> soon as there is any definitive agreement about what
>  it's  going  to
> look like. As mentioned before - I'd be happy to
> accept what has been
> discussed more than two years ago, especially Mark's
> proposal.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime
> Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88
> Email: wd@denx.de
> Experience is what causes a person to make new
> mistakes  instead  of
> old ones.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

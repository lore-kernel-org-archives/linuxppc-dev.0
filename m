Date: Wed, 31 Mar 2004 17:56:25 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: Jeff Angielski <jeff@theptrgroup.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Memory mapping
Message-ID: <20040331155625.GB28919@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <20040323111736.GJ1446@smtp.barco.com> <1080086640.23208.164.camel@gaston> <20040324122652.GA22171@smtp.barco.com> <20040324142524.GA22701@smtp.barco.com> <20040324110814.E50148@forte.austin.ibm.com> <20040325154845.GF3696@smtp.barco.com> <20040325103414.C64292@forte.austin.ibm.com> <20040325104529.D64292@forte.austin.ibm.com> <20040326080012.GA7238@smtp.barco.com> <1080676178.7581.30.camel@localhost.localdomain>
Mime-Version: 1.0
In-Reply-To: <1080676178.7581.30.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How is the PICMRx configured? Do you have snoop enabled or disabled?

This is what I like about my job: problem based digging deeper into code
internals :)

Anyway, the time of day difference between us enables me to try to come
up with some kind of founded answer. We are using ppcboot (yeah, I know,
but unfortunately, there are too many things in the todo queue to
upgraced to uboot).

After some digging into kernel code, ppcboot code and the mpc8245
documentation, I assume you are trying to point me to the following:
In Section 7.5:
"Because a snoop transaction is required to establish a lock, the
MPC8245 does not honour the assertion of a LOCK when PICR1[NO_SNOOP_EN]
is set."; when describing exclusive access to data.

In cpu/mpc824x/cpu_init.c:
    CONFIG_WRITE_HALFWORD(PCICR, 0x06);
    /* bus master, respond to PCI accesses */
    CONFIG_READ_WORD(PICR1, val);
    CONFIG_WRITE_WORD( PICR1,
       (val & (PICR1_RCS0)) |
               PICR1_PROC_TYPE_603E |
               PICR1_FLASH_WR_EN | PICR1_MCP_EN |
               PICR1_CF_DPARK | PICR1_NO_BUSW_CK |
               PICR1_DEC| PICR1_CF_APARK | 0x10);
/* 8245 UM says bit 4 must be set */

#define PICR1_RCS0              0x00100000
#define PICR1_PROC_TYPE_603E    0x00040000
#define PICR1_FLASH_WR_EN       0x00001000
#define PICR1_MCP_EN            0x00000800
#define PICR1_CF_DPARK          0x00000200
#define PICR1_NO_BUSW_CK        0x00000080 /* no bus width check for
flash writes */
#define PICR1_DEC               0x00000100 /* Time Base enable on
8245/8241 */
#define PICR1_CF_APARK          0x00000008

And for PICR2:
    CONFIG_READ_WORD(PICR2, val);
    val= val & ~ (PICR2_CF_SNOOP_WS_MASK | PICR2_CF_APHASE_WS_MASK);
    /*mask off waitstate bits*/

#define PICR2_CF_APHASE_WS_MASK 0x0000000c
#define PICR2_CF_SNOOP_WS_MASK  0x000c0000

k. I got the (relevant) registers states at bootup now, I am still
looking for the NO_SNOOP_EN bit, it must be somewhere in the docs...

4.7: Speculative PCI reads see Chapter 13;

but NO_SNOOP_EN is defined for PICR2 on bit 27, could it be that the
the description in section (note) 7.5 is referring to PICR2 instead of
the mentioned PICR1?

which should be 0x8000000

I'll masking PICR2 with this tomorrow...

> will sound obvious, but have you stuck a PCI bus analyzer into the
> system to watch the actual PCI transactions? They more than make up
> for their cost in time savings. :)

Not yet, mainly because we want to interactively PPC/DSP rule out other
possibilities (an infamous DSP reset which is extremely difficult to
pinpoint); combined with the usual growing to do list with continuous
interrupts for 'paramount' things to do...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

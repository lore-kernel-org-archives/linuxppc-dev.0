Message-ID: <20020606192510.58822.qmail@web11106.mail.yahoo.com>
Date: Thu, 6 Jun 2002 12:25:10 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Sungem bug or something else?
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020406102410.14763@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I encounter an oops during boot bringing up a sungem
interface. (smp g4 450/gcc 3.1/glibc 2.2.5) If I defer
bringing up the network at boot, I can successfully
start eth0 (sungem) if I start eth1 (tulip) first, so
it may not be the sungem driver itself. This happens
on benh 2.4.19-Bpre10, and pre9.

The area which fails (according to ksymoops) is in
sungem.c <__phy_read+54/a4>

static u16 __phy_read(struct gem *gp, int reg, int
phy_addr)
{
    u32 cmd;
    int limit = 10000;

    cmd  = (1 << 30);
    cmd |= (2 << 28);
    cmd |= (phy_addr << 23) & MIF_FRAME_PHYAD;
    cmd |= (reg << 18) & MIF_FRAME_REGAD;
    cmd |= (MIF_FRAME_TAMSB);
    writel(cmd, gp->regs + MIF_FRAME);

    while (limit--) {
        cmd = readl(gp->regs + MIF_FRAME); *** here
***
        if (cmd & MIF_FRAME_TALSB)
            break;

        udelay(10);
    }

    if (!limit)
        cmd = 0xffff;

    return cmd & MIF_FRAME_DATA;
}

The actual faulting address is 0xe20d920c (the value
of gpr0; gpr31 is 0)

0xc00de2a4 <__phy_read+80>:     lwbrx   r31,r0,r0
0xc00de2a8 <__phy_read+84>:     eieio


Any clues where I should look?
Thanks
-roger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

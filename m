Date: Thu, 11 Mar 2004 17:48:00 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: [RFC] "indirect" DCR access (40x, BookE)
Message-ID: <20040312014800.GA25455@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all!

As some people know using DCR is sometimes PITA ;-).
The reason is simple, DCR number is encoded in instruction itself, so
one cannot write code like:

	for (i = 0; i < LAST_REG; ++i)
		mtdcr(DCR_XXX_BASE + i, 0);

Because of this limitation we have to use a lot of ugly #ifdefs and/or
explicit switch/if statements when accessing DCR from device drivers
(see for example include/asm-ppc/ppc405-dma.h,
drivers/net/ibm_emac/ibm_ocp_mal.c (2.4 tree), etc)

There is a simple solution for this problem (I'm sure everybody
thought of this one, but just didn't have time to code it :).

This approach trades space (16K of code) for convenience.

Here is the short snippet which demonstrates the idea (full patch is
quite big and can be found at http://kernel.ebshome.net/dcr-2.6.diff):

#define DCR_ACCESS_PROLOG(table) \
        rlwinm  r3,r3,4,18,27;   \
        lis     r5,table@h;      \
        ori     r5,r5,table@l;   \
        add     r3,r3,r5;        \
        mtctr   r3;              \
        bctr

_GLOBAL(__mfdcr)
        DCR_ACCESS_PROLOG(__mfdcr_table)

_GLOBAL(__mtdcr)
        DCR_ACCESS_PROLOG(__mtdcr_table)

__mfdcr_table:
        mfdcr  r3,0; blr
__mtdcr_table:
        mtdcr  0,r4; blr
        mfdcr  r3,1; blr
        mtdcr  1,r4; blr
        mfdcr  r3,2; blr
        mtdcr  2,r4; blr
        mfdcr  r3,3; blr
	....

I grouped reading & writing of the same DCR together to make these
functions more cache friendly. I'm not sure about the names, though
:).

This patch is against 2.6, I can easily make for 2.4 as well if there
is an interest.

Please note, I'm not proposing _removing_ current "mfdcr/mtdcr"
macros, they have their use. These "indirect" versions can be used in
some drivers to get more clean and readable code.

Comments, suggestions are welcome.

Thanks,
Eugene

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

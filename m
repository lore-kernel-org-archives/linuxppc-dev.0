Date: Mon, 19 Jan 2004 11:17:28 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: OF properties access ?
Message-ID: <20040119101728.GB18112@iliana>
References: <20040113114625.GA9294@iliana> <1074131387.818.43.camel@gaston> <20040115074439.GB14039@iliana> <1074310140.8360.27.camel@gaston> <20040118120722.GA4603@iliana> <1074468096.795.27.camel@gaston> <20040118143225.GA6717@iliana> <1074502892.813.41.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1074502892.813.41.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 19, 2004 at 08:01:33PM +1100, Benjamin Herrenschmidt wrote:
> Well... You can move that code to a later place where you can printk
> and debug waht's up. It's also possible that the _set_L2CR routine
> in the kernel you are working on isn't totally correct for your CPU
> model... Do you have the 7447 recongnized at all in cputable ?

Mmm, i have :

    {   /* 7457 */
        0xffff0000, 0x80020000, "7457",
        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
        CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
        CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
        CPU_FTR_HAS_HIGH_BATS,
        COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
        32, 32,
        __setup_cpu_745x
    },

Which should be ok, since there seem to be no way to distinguish a 7447
from a 7457 anyway (apart from maybe L2 cache probing or such).

And indeed, the problem seems to be that i get /cpus, and not
/cpus/PowerPC,74x7. I thought that the /cpus should give the cpu per
default or something such. What should i do here, i can go look for a
PowerPC,74x7, but the board can also come with other CPUs (the 750Cxe
for now). Maybe i could remove the cpus checking code completely, and go
looking for the cpu type directly.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

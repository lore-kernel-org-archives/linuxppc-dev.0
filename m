Message-ID: <3CA2091C.96665221@mvista.com>
Date: Wed, 27 Mar 2002 13:02:04 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <3CA1F048.6E1CD277@mvista.com> <20020327184011.1527@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> Any reason why BI_LAST has those 4 bytes of data set to 0, why not
> just BI_LAST size=0 and no data ?

Only reason is that it is how its implemented now so to keep backward
compatibility...

E.g., _2_4_devel, arch/ppc/boot/common/misc-simple.c:decompress_kernel()

        rec->tag = BI_LAST;
        rec->size = sizeof(struct bi_record);
        rec = (struct bi_record *)((unsigned long)rec + rec->size);

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

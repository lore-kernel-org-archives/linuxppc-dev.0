Message-ID: <3CA20A39.1B07B455@mvista.com>
Date: Wed, 27 Mar 2002 13:06:49 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <3CA1F048.6E1CD277@mvista.com> <20020327184011.1527@mailhost.mipsys.com> <3CA2091C.96665221@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Mark A. Greer" wrote:

> benh@kernel.crashing.org wrote:
>
> > Any reason why BI_LAST has those 4 bytes of data set to 0, why not
> > just BI_LAST size=0 and no data ?
>
> Only reason is that it is how its implemented now so to keep backward
> compatibility...
>
> E.g., _2_4_devel, arch/ppc/boot/common/misc-simple.c:decompress_kernel()
>
>         rec->tag = BI_LAST;
>         rec->size = sizeof(struct bi_record);
>         rec = (struct bi_record *)((unsigned long)rec + rec->size);

Ahh shit, I was thinking bi_rec had data[1], not data[0].

Attempt #6:


[0] tag: BI_FIRST
    size: 8

[1] tag: BI_CMD_LINE
    size: 36                            (4 + 4 + 26 chars + 2 pad)
    data: "console=ttyS0,115200 ip=on"
    pad: 2

[2] tag: BI_MEMSIZE
    size: 12
    data: 0x33554432                    (32 MB)

[3] tag: BI_GT64260_BASE
    size: 12
    data: 0xfc000000

[4] tag: BI_DEVICE                      (embedded enet cltr 0)
    size: 56                            (8 + 2*12 + 16 + 8 == 56)

    [4.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [4.1] tag: BI_DEV_ID
          size: 12
          data: 0x00000000              (1st enet device)

    [4.2] tag: BI_MAC_ADDR
          size: 16
          data: 0xaabbccddeeff          (6 byte MAC addr)
          pad: 2

    [4.3] tag: BI_LAST
          size: 8

[5] tag: BI_DEVICE                      (embedded enet cltr 1)
    size: 56                            (8 + 2*12 + 16 + 8 == 56)

    [5.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [5.1] tag: BI_DEV_ID
          size: 12
          data: 0x00000001              (2nd enet device)

    [5.2] tag: BI_MAC_ADDR
          size: 16
          data: 0xgghhiijjkkll          (6 byte MAC addr)
          pad: 2

    [5.3] tag: BI_LAST
          size: 8
[6] tag: BI_DEVICE                      (embedded enet cltr 2)
    size: 56                            (8 + 2*12 + 16 + 8 == 56)

    [6.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [6.1] tag: BI_DEV_ID
          size: 12
          data: 0x00000002              (3rd enet device)

    [6.2] tag: BI_MAC_ADDR
          size: 16
          data: 0xmmnnooppqqrr          (6 byte MAC addr)
          pad: 2

    [6.3] tag: BI_LAST
          size: 8

[7] tag: BI_LAST
    size: 8


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

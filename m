Message-ID: <3CA1E22C.C86C0D78@mvista.com>
Date: Wed, 27 Mar 2002 10:15:56 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>, benh@kernel.crashing.org,
	msokolov@ivan.Harhan.ORG, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203270237.AA03006@ivan.Harhan.ORG> <20020326215235.21322@mailhost.mipsys.com> <20020327071527.A2510@home.com> <3CA1E0FB.EC5935DB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Forget the last one, here's attempt #3:

Example for ev64260:
--------------------

[0] tag: BI_CMD_LINE
    size: 36                            (4 + 4 + 26 chars + 2 pad)
    data: "console=ttyS0,115200 ip=on"
    pad: 2

[1] tag: BI_MEMSIZE
    size: 12
    data: 33554432                      (32 MB)

[2] tag: BI_GT64260_BASE
    size: 12
    data: fc000000

[3] tag: BI_DEVICE                      (embedded enet cltr 0)
    size: 64                            (8 + 2*12 + 28 + 4 == 64)

    [3.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [3.2] tag: BI_DEV_ID
          size: 12
          data: 0                       (1st enet device)

    [3.3] tag: BI_MAC_ADDR
          size: 28
          data: aa:bb:cc:dd:ee:ff       (ascii)
          pad: 3

    [3.4] 0x00000000                    (NULL Termination of BI_STRUCT)

[4] tag: BI_DEVICE                      (embedded enet cltr 1)
    size: 64                            (8 + 2*12 + 28 + 4 == 64)

    [4.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [4.2] tag: BI_DEV_ID
          size: 12
          data: 1                       (2nd enet device)

    [4.3] tag: BI_MAC_ADDR
          size: 28
          data: gg:hh:ii:jj:kk:ll       (ascii)
          pad: 3

    [4.4] 0x00000000                    (NULL Termination of BI_STRUCT)

[5] tag: BI_DEVICE                      (embedded enet cltr 2)
    size: 64                            (8 + 2*12 + 28 + 4 == 64)

    [5.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [5.2] tag: BI_DEV_ID
          size: 12
          data: 2                       (3rd enet device)

    [5.3] tag: BI_MAC_ADDR
          size: 28
          data: mm:nn:oo:pp:qq:rr       (ascii)
          pad: 3

    [5.4] 0x00000000                    (NULL Termination of BI_STRUCT)

[6] 0x00000000                          (NULL Termination of whole list)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

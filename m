Message-ID: <3CA1F257.5133EA5F@mvista.com>
Date: Wed, 27 Mar 2002 11:24:55 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203271803.AA04513@ivan.Harhan.ORG> <3CA1F048.6E1CD277@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Mark A. Greer" wrote:

> Yeah, that's right, I messed up.  So what should be done for the nested ones?
> What is we use the BI_DEVICE as a quasi-BI_FIRST and then add a BI_LAST to each
> nested one?  This is what it would look like:

I messed up the size on the BI_LAST struct, should be 12.  Attempt #5:

Example for ev64260:
--------------------

[0] tag: BI_FIRST
    size: 12
    data: 0x00000000                    (don't care)

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
    size: 60                            (8 + 2*12 + 16 + 12 == 60)

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
          size: 12
          data: 0x00000000              (don't care)

[5] tag: BI_DEVICE                      (embedded enet cltr 1)
    size: 60                            (8 + 2*12 + 16 + 12 == 60)

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
          size: 12
          data: 0x00000000              (don't care)

[6] tag: BI_DEVICE                      (embedded enet cltr 2)
    size: 60                            (8 + 2*12 + 16 + 12 == 60)

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
          size: 12
          data: 0x00000000              (don't care)

[7] tag: BI_LAST
    size: 12
    data: 0x00000000                    (don't care)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

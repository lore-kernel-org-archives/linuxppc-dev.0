Message-ID: <3CA1EC69.41AE7988@mvista.com>
Date: Wed, 27 Mar 2002 10:59:37 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: msokolov@ivan.Harhan.ORG, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203271732.AA04381@ivan.Harhan.ORG> <20020327174851.14516@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:

> >But why is the MAC address in ASCII? Why not simply put the 6 bytes in there?
> >Why the extra burden of parsing the ASCII?
>
> Well, I would put the 6 bytes, I beleive he wrote it to make it
> readable for us ;)
>
> The point of bi_recs is indeed to avoid ascii (to avoid wasting too
> much space). Or else we would just use a device_tree or an xml
> tree :

Okay, this may be it, attempt #4:

Example for ev64260:
--------------------

[0] tag: BI_CMD_LINE
    size: 36                            (4 + 4 + 26 chars + 2 pad)
    data: "console=ttyS0,115200 ip=on"
    pad: 2

[1] tag: BI_MEMSIZE
    size: 12
    data: 0x33554432                    (32 MB)

[2] tag: BI_GT64260_BASE
    size: 12
    data: 0xfc000000

[3] tag: BI_DEVICE                      (embedded enet cltr 0)
    size: 52                            (8 + 2*12 + 16 + 4 == 52)

    [3.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [3.1] tag: BI_DEV_ID
          size: 12
          data: 0x00000000              (1st enet device)

    [3.2] tag: BI_MAC_ADDR
          size: 16
          data: 0xaabbccddeeff          (6 byte MAC addr)
          pad: 2

    [3.3] 0x00000000                    (NULL Termination of BI_STRUCT)

[4] tag: BI_DEVICE                      (embedded enet cltr 1)
    size: 52                            (8 + 2*12 + 16 + 4 == 52)

    [4.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [4.1] tag: BI_DEV_ID
          size: 12
          data: 0x00000001              (2nd enet device)

    [4.2] tag: BI_MAC_ADDR
          size: 16
          data: 0xgghhiijjkkll          (6 byte MAC addr)
          pad: 2

    [4.3] 0x00000000                    (NULL Termination of BI_STRUCT)

[5] tag: BI_DEVICE                      (embedded enet cltr 2)
    size: 52                            (8 + 2*12 + 16 + 4 == 52)

    [5.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_TYPE_GT_ETH

    [5.1] tag: BI_DEV_ID
          size: 12
          data: 0x00000002              (3rd enet device)

    [5.2] tag: BI_MAC_ADDR
          size: 16
          data: 0xmmnnooppqqrr          (6 byte MAC addr)
          pad: 2

    [5.3] 0x00000000                    (NULL Termination of BI_STRUCT)

[6] 0x00000000                          (NULL Termination of whole list)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

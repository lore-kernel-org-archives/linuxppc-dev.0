Message-ID: <3CA1E0FB.EC5935DB@mvista.com>
Date: Wed, 27 Mar 2002 10:10:51 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: benh@kernel.crashing.org, msokolov@ivan.Harhan.ORG,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203270237.AA03006@ivan.Harhan.ORG> <20020326215235.21322@mailhost.mipsys.com> <20020327071527.A2510@home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> On Tue, Mar 26, 2002 at 10:52:35PM +0100, benh@kernel.crashing.org wrote:
> >
> > >
> > >It would set a very bad example if it is implemented. In your proposal the
> > >records containing the GT-64260 Ethernet information have no indication
> > >in them
> > >whatsoever that they are for GT-64260 and not some other Ethernet. If
> > you make
> > >the gt64260_eth driver call a function to grab all bi_recs of this kind, the
> > >next engineer who designs a board with other hard-wired Ethernet
> > interfaces on
>

<snip>

> >
> > Yah, this is why BI_DEV_TYPE should be GT64260_xxxx
> >
> > We have several choices here for the design, I'm not sure which is best, so
> > please speak up:
> >
> > When dealing with combo-chips like the GT or PPC 4xx/8xx etc..., we can
> > either:
> >
> >  - define one BI_DEV_TYPE per chip (BI_DEV_TYPE_GT64260, ...). The actual
> > device within the GT64260 (ethernet in our case) is referenced via the
> > BI_DEV_CLASS (ethernet), BI_DEV_ID beeing optionally there in case a
> > given device in the chip exist in more than one instance.
> >
> >  - define one BI_DEV_TYPE per chip (same as above), and define a BI_DEV_ID
> > containing both function and the index (for example 'ETH0') thus we don't
> > need BI_DEV_CLASS.
> >
> >  - define a specific BI_DEV_TYPE for each function (that is
> > BI_DEV_TYPE_GT64260_ETH), BI_DEV_ID is only an index.
> >
> > I tend to prefer solution 2)
>
> Since device macro cells are commonly used across different chips,
> it might be wise to orient the records around the device macro
> rather than the SoC it is implemented in.  For example, there
> are tens of 405 variants plus a similar future of 440 variants
> that all share the EMAC macro device and corresponding driver.
> A single BI_DEV_TYPE_IBM_EMAC would be most appropriate.  Mot

<snip>

All good points.  Given Matt's comments, I think sol'n 3) may be the best.
Comments?

Here's the next iteration using Ben's sol'n 3)

I also adde NULL termination to the overall bi_rec and to each nested one so the
parsing code can stop when a NULL is hit whether its a nested one or not
(therefore we can never have a valid tag with value 0).  I also adjusted the size
of the BI_STRUCTS to include the 4 byte NULL terminator.  I also fixed an error on
the length of the BI_MAC_ADDR (was 25, should be 28 to count padding).

Mark
--

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

[3] tag: BI_STRUCT                      (embedded enet cltr 0)
    size: 68                            (12 + 2*12 + 28 + 4 == 68)
    data: BI_DEVICE

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

[4] tag: BI_STRUCT                      (embedded enet cltr 1)
    size: 68                            (12 + 2*12 + 28 + 4 == 68)
    data: BI_DEVICE

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

[5] tag: BI_STRUCT                      (embedded enet cltr 2)
    size: 68                            (12 + 2*12 + 28 + 4 == 68)
    data: BI_DEVICE

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

Message-ID: <3CA1031D.C072B4D6@mvista.com>
Date: Tue, 26 Mar 2002 18:24:13 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Val Henson <val@nmt.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <20020322210103.C3363@boardwalk> <20020324122048.8670@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben, et. al.,

Sorry for dropping out the last few days, I've been very busy with other things.

I've skimmed the email but I'll admit I didn't read them all in depth.  I've made
an example of actual bi_rec's using the ev64260 to see if my skimming worked :)
In the example, I used a BI_STRUCT to pass in  the mac addr for the 3 embedded
enet ctlrs on the gt64260.  I used the DEV_TYPE + DEV_CLASS concept but made an
"EMBEDDED" DEV_TYPE to go along with DEV_PCI so we don't have to add a new one
for each embedded ctlr.  The square brackets are only there to make it easier to
follow.  I'm assuming that every bi_rec is responsible for padding out to a
4-byte boundary.  Is that what I'm supposed to do?

Please let me know if I'm on the right track.  If so, we--the ev64260 people--can
flesh out some more bi_rec's and implement them.

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
    size: 76                            (12 + 3*12 + 25 + 3 == 76)
    data: BI_DEVICE

    [3.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_EMBEDDED

    [3.1] tag: BI_DEV_CLASS
          size: 12
          data: BI_CLASS_ENET

    [3.2] tag: BI_DEV_ID
          size: 12
          data: 0                       (1st enet device)

    [3.3] tag: BI_MAC_ADDR
          size: 25
          data: aa:bb:cc:dd:ee:ff       (ascii)
    pad: 3

[4] tag: BI_STRUCT
    size: 76
    data: BI_DEVICE

    [4.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_EMBEDDED

    [4.1] tag: BI_DEV_CLASS
          size: 12
          data: BI_CLASS_ENET

    [4.2] tag: BI_DEV_ID
          size: 12
          data: 1                       (2nd enet device)

    [4.3] tag: BI_MAC_ADDR
          size: 25
          data: gg:hh:ii:jj:kk:ll       (ascii)
    pad: 3

[5] tag: BI_STRUCT
    size: 76
    data: BI_DEVICE

    [5.0] tag: BI_DEV_TYPE
          size: 12
          data: BI_DEV_EMBEDDED

    [5.1] tag: BI_DEV_CLASS
          size: 12
          data: BI_CLASS_ENET

    [5.2] tag: BI_DEV_ID
          size: 12
          data: 2                       (3rd enet device)

    [5.3] tag: BI_MAC_ADDR
          size: 25
          data: mm:nn:oo:pp:qq:rr       (ascii)
    pad: 3


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

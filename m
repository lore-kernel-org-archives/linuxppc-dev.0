Message-ID: <38DC7847.A9DF9E7A@ncal.verio.com>
Date: Sat, 25 Mar 2000 00:26:47 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: offb.c fix (Re: PB2000 (pismo) install feedback
References: <20000323174416.031445@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

I've found the real problem with the linux-pmac_benh offb.c.
Simple pointer arithmetic problem. This fixes both the
"burnout" effect and the colormap problems.

Henry

*** offb.c.orig4        Sat Mar 25 00:20:05 2000
--- offb.c      Sat Mar 25 00:20:44 2000
***************
*** 914,920 ****
      case cmap_r128:
        /* Set palette index & data */
        out_8(info2->cmap_adr + 0xb0, regno);
!       out_le32((unsigned *)(info2->cmap_adr) + 0xb4,
                (red << 16 | green << 8 | blue));
        break;
      case cmap_M3B:
--- 914,920 ----
      case cmap_r128:
        /* Set palette index & data */
        out_8(info2->cmap_adr + 0xb0, regno);
!       out_le32((unsigned *)(info2->cmap_adr + 0xb4),
                (red << 16 | green << 8 | blue));
        break;
      case cmap_M3B:

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Date: Wed, 22 Jan 2003 15:54:10 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: wrong definition in cpm_8260.h?
In-reply-to: <00bc01c2c205$e4c95520$e600a8c0@udtech.net>
To: Shen Rong <rshen@udtech.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEIJFJAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=Windows-1252
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

The same error is in commproc.h for 8xx as well.

>
>
> Hi,
>
> In cpm_8260.h, BD_ENET_RX_STATS is defined to 0x1ff, which leads
> to the fcc driver can't clean the BD_ENET_RX_LAST&BD_ENET_RX_FIRST bits
> with the following statement:
>     bdp->cbd_sc &= ~BD_ENET_RX_STATS;
>
> The first&last bits are set by the CPM not the CPU, so they
> should be cleared after the frame is received. So it should be:
>
> #define BD_ENET_RX_STATS ((ushort)0x0fff) /* All status bits */
>
> The same problem in ppcboot.
>
>
> Shenrong
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

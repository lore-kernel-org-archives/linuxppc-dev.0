Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Owen Green" <owenjinggreen@yahoo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Fast HDLC driver
Date: Tue, 19 Nov 2002 17:48:12 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLEECEFIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20021119161020.83422.qmail@web20104.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Owen

I have written a patch to 8xx_io/enet.c that avoids copying. It still calls
netif_rx from IRQ context, but it's a start. The patch was posted a few weeks
ago to this list.

Could you post a copy of the qslinux hdlc driver? I am interested to se how
one would avoid calling netif_rx from IRQ context.

      Jocke
>
>
> Hi all,
>
> I`ve started working on a new project were a high
> performace hdlc channel is needed (at least 4Mbps on
> MPC8xx-50Mhz).
> I found several drivers for hdlc, but some are not
> very fast (copies memory,... ), most of them calls
> netif_rx from inside interrupt_handler (I don`t think
> this is the best place for doing that, watchdog may
> expire if the interface gets very busy..).
> The only driver I found that seems to be really fast
> and doesnt do all this stuff in interrupt context is
> for kernel-2.2 (QSLINUX).
> Does anyone ported this to 2.4 or knows another
> implementation of hdlc driver that could do this the
> way I`m thinking?
>
> Thanks in advance, Owen.
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

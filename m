Date: Mon, 4 Mar 2002 07:54:51 +0100
From: Andreas Liebe <liebe@hrz.tu-darmstadt.DE>
To: linuxppc-embedded@lists.linuxppc.org
Cc: hychon@genetel.co.kr
Subject: Re: eth0 : time out ....error
Message-ID: <20020304075451.B19932@hrz.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've had exactly the same problems. Probably you're using a kernel < 2.4.11.
Try this tiny from 2.4.11 which did it for me:

------------------------------------------------------------------------
*** arch/ppc/8xx_io/fec.c       Sat Mar  2 12:50:33 2002
--- arch/ppc/8xx_io/fec.c-orig  Thu Dec 20 22:31:30 2001
***************
*** 416,425 ****
                bdp++;
        }

!       if (bdp->cbd_sc & BD_ENET_TX_READY) {
                netif_stop_queue(dev);
-               fep->tx_full = 1;
-       }

        fep->cur_tx = (cbd_t *)bdp;

--- 416,423 ----
                bdp++;
        }

!       if (bdp->cbd_sc & BD_ENET_TX_READY)
                netif_stop_queue(dev);

        fep->cur_tx = (cbd_t *)bdp;

------------------------------------------------------------------------

 -Andreas


On Thu, 28 Feb 2002 10:14:39 +0900 you wrote:
> I have the problem when I get/recevie data of over 100 kbytes size
> If I send a small size data , it's trance success
> but big size data is fail and print following messages
> ...
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: transmit timed out.
> Ring data dump: cur_tx c1f70078, dirty_tx c1f70078 cur_rx: c1f70038
> tx: 8 buffers
--
Andreas Liebe/Darmstadt University of Technology/+49 6151 16-3150/3050(FAX)

Wer denkt, was andere denken sei richtig, denkt nicht (unbekannt)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

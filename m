Message-Id: <l03130300b8bba63e55e4@[192.168.1.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 18 Mar 2002 09:15:39 -0500
To: benh@kernel.crashing.org
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: 2.4.18 and dmasound and rebooting
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Can you try this patch and tell me if it helps ?
>
> ===== drivers/sound/dmasound/dmasound_awacs.c 1.21 vs edited =====
> --- 1.21/drivers/sound/dmasound/dmasound_awacs.c        Tue Feb  5
>09:58:03 2002
> +++ edited/drivers/sound/dmasound/dmasound_awacs.c      Mon Mar  4
>11:32:36 2002
> @@ -963,7 +963,9 @@
>                         st_le16(&cp->res_count, 0);
>                         st_le16(&cp->xfer_status, 0);
>                         st_le32(&cp->phy_addr, phy);
> -                       st_le16(&cp->command, OUTPUT_MORE + INTR_ALWAYS);
> +                       st_le32(&cp->cmd_dep, virt_to_bus
> (&awacs_tx_cmds[(i+1)%write_sq.max_count]));
> +                       st_le16(&cp->command, OUTPUT_MORE | BR_ALWAYS |
>INTR_ALWAYS);
> +
>                        /* point at our patched up command block */
>                         out_le32(&awacs_txdma->cmdptr, virt_to_bus(cp));
>                        /* we must re-start the controller */

Ok, sorry for getting back so slowly.

I tried compiling this in and it worked great. It eliminated some popping
that would happen on the DMA-dead recovery before.

I haven't yet tried compiling this into a kernel module yet to see if it
fixes the problem of the kernel module version of this not working.

----------------------------------------------
 Michael Zucca - mrz5149@acm.org
----------------------------------------------
 "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

Message-ID: <3B9F880D.3CE65C1A@mvista.com>
Date: Wed, 12 Sep 2001 09:06:37 -0700
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: another set of ppc405_enet changes
References: <20010911202712.B8620@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
>
> I wanted to limit this patch to be just a rework of the static var's but I
> ended up changing more things. I will attempt a summary of the changes.
> I did not compile/fix the stuff ifdef'd out by default.
>
> I attached the output from some runs with nttcp before and after the changes.
> It does not appear like there is any noticable change in performace from these
> changes. "-u" is for UDP "-r" is Rx'd on the 405GP Tx'd by my x86 box, "-t" is
> Tx'd by the 405GP Rx'd by the x86.
> One thing to look into would be the diff between UDP tx packets to the
> number rx'd on the other side. I don't know where the packets are being dropped
> now.
>
> Config.ini changed to CONFIG_PPC405_ENET to be tristate instead of just bool.
>
> Change NUM_RX to 32 and NUM_TX to 8. Doesn't change performace noticablely.
> Moved probe1 code into init function.
>
> kfree of private struct on module unload or failure to register netdevice.
>
> Used skb->len instead of tail-head in places.
>
> For both tx/rx eob int's clear reg first then loop through, instead of loop
> clear, goto top of loop again.
>
> Moved tx stat counts into tx eob from hard_xmit. In tx_eob moved netif_wake
> outside of loop.
>
> In rx_eob wait untill end of function to refill slots instead of after
> each packet. Also did skb_put instead of += tail and len. Put in check
> for dev_alloc_skb failure but still no recovery when OOM.
>


Andrew;

This look very similar to a previous patch from last week. Provide a
patch that represents addition work since then.  I have applied most of
your previous patches.  Please be patient,  this does not happen over
night.

regards,

Armin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

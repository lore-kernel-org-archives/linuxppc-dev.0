From: Risto Minev <minev@nentec.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: NPe405H: Bridging memory leakage under extreme loads
Date: Fri, 19 Mar 2004 20:30:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403192030.14899.minev@nentec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have developed a bridging scenario between an EMAC(Ethernet) and a HDLCM
bundle using the standard Linux bridging sources and extending the standard
Linux ISDN networking driver. Linux kernel used is 2.4.18.

Bridging trafic between Ethernet <-> HDLC and also Ethernet <-> Ethernet works
fine even at very high rates. Problem arises (in any of the two bridging
scenarios) when we reach the theshold, when the bridge fails to deliver all
the packets. Then we begin to have drastic memory losses. Very shortly
afterwards the system runs out of memory and hangs.

'cat /proc/slabinfo' shows great increase in 'skbuff_head_cache' objects.
For example, before a run skbuff_head_cache and system memory as shown by
top is as as follows:

>cat /proc/slabinfo | grep skb
skbuff_head_cache    165    168    160    7    7    1
>
>top
Mem: 15912K used, 46796K free, 0K shrd, 176K buff, 12048K cached
...

After a run with Smartbits traffic generator,  out of 146818 (64B) transmitted
pkts, 146394pkts were received. (difference of 424 pkts)

Now the skbuff_head_cache and memory status is as follows:

>
>cat /proc/slabinfo | grep skb
skbuff_head_cache    278   4872    160   65  203    1
>
>top
Mem: 35700K used, 27008K free, 0K shrd, 176K buff, 12048K cached
Load average: 0.13, 0.04, 0.01    (State: S=sleeping R=running, W=waiting)

There is a memory difference of around 20MB where the memory for the
undelivered packets(skbs) is less that 1MB.

After exhaustive inspecting and tracing of the code, be it the bridging code
'../net/bridge' or the ISDN code together with our extensions
'../drivers/isdn/', or the ethernet driver code in '../drivers/net/ibm_ocp/',
we come to the conclusion that every allocated skb is also being freed even
at these extreme loads.

As workaround to this problem I have extended the skb handling in
'../net/core/skbuff.c' to provide recycling of socket buffers. So now dynamic
allocation and freeing skb actions are eliminated for both ethernet and hdlc
drivers respectevely. Only reinitialisation of the skb head is done 'struct
sk_buff', before the buffer is again put into action.

This seems to fix the memory leakage problem so now I can bombard
our bridge with Smartbit trafic generator at any rate and it survives.

Now, where does the problem lie?
Other people in this mailing list have experienced this problem and solved it,
either having static skb pools or stopping interrupts during congestion.

To my mind these are workarounds to a problem runs deeper.

The problem seems to be related to the rate by which memory management
functions like alloc_skb/kfree_skb in this case are called.

Any suggestions?

Regards,

Risto

--
 Risto Minev <minev@nentec.de>
 Software Development
 NENTEC Netzwerktechnologie GmbH
 Killisfeld Strasse 64
 76227 Karlsruhe, Germany

 phone: ++49(0)721 94249 56
   fax: ++49(0)721 94249 10


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

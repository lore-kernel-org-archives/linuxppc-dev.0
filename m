Message-ID: <3FFA682D.1030402@dgt-lab.com.pl>
Date: Tue, 06 Jan 2004 08:47:57 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: cd
References: <200401041555.JAA03904@lists.linuxppc.org> <3FF91D0F.7010203@dgt-lab.com.pl> <200401052252.QAA10493@lists.linuxppc.org>
In-Reply-To: <200401052252.QAA10493@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


U¿ytkownik Samo Pogacnik napisa³:

>On Monday 05 January 2004 09:15, Wojciech Kromer wrote:
>
>
>>U¿ytkownik Samo Pogacnik napisa³:
>>
>>
>>>Is it possible that there is something wrong in the way how the:
>>>"netif_wake_queue(dev)" gets called from the interrupt handler in the
>>>"fcc_enet.c"? I can confirm this problem for 2.4.18 as well as 2.6.0
>>>kernels on mpc82xx.
>>>
>>>
>>i don't know exactly what's wrong with 82xx code, but i wrote a small
>>patch that frees unfreed skbuf before allocating new one, and now it
>>works fine
>>
>>additionaly, i had no problem with (almost) the same code on 8xx
>>
>>
>
>hi, Wojciech
>can you send the patch?
>
sure, just 4 lines addes

>did you free skbuffs from the irq handler or somewhere else?
>
>
just before allocation

>when i run netperf (snapshot) test using the 100Mbps connection, this
>test eats all the available RAM. the /proc/meminfo shows that most of the used
>memory at that point is been held by internal kernel structures (Slab).
>
>
better reults are shwn with
grep skb /proc/slabinfo

>by, Samo
>
>
here it is:

--------------------------------------------------------------------------------------------------------
***************
*** 413,418 ****
--- 412,420 ----

      /* Save skb pointer.
      */
+     //by k@m 2003-12-05
+     if(cep->tx_skbuff[cep->skb_cur])
+      dev_kfree_skb_irq (cep->tx_skbuff[cep->skb_cur]);
      cep->tx_skbuff[cep->skb_cur] = skb;

      cep->stats.tx_bytes += skb->len;
***************
*** 560,565 ****
--- 562,568 ----
          /* Free the sk buffer associated with this last transmit.
          */
          dev_kfree_skb_irq(cep->tx_skbuff[cep->skb_dirty]);
+         cep->tx_skbuff[cep->skb_dirty]=0;//by k@m 2003-12-05
          cep->skb_dirty = (cep->skb_dirty + 1) & TX_RING_MOD_MASK;

          /* Update pointer to next buffer descriptor to be transmitted.
***************
*** 1348,1353 ****
--- 1351,1357 ----
       * It works when I do this.
       */
      memset((char *)ep, 0, sizeof(fcc_enet_t));
+     memset(cep->tx_skbuff,0,sizeof(cep->tx_skbuff));

      /* Allocate space for the buffer descriptors in the DP ram.
       * These are relative offsets in the DP ram address space.
-------------------------------------------------------------------------------------------

ps: i send you my full version of fcc_enet.c

--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

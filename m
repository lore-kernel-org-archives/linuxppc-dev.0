Message-ID: <3FCF19C3.9070205@dgt-lab.com.pl>
Date: Thu, 04 Dec 2003 12:25:55 +0100
From: Wojciech Kromer <krom@dgt-lab.com.pl>
MIME-Version: 1.0
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: memory problem with fec on 8250
References: <3FCD956B.8030604@gazeta.pl> <3FCEF441.2030808@dgt-lab.com.pl> <20031204091536.GA1050@gate.ebshome.net> <3FCF0252.7070202@dgt-lab.com.pl> <20031204101901.GB1050@gate.ebshome.net> <3FCF0E68.4010303@dgt-lab.com.pl> <20031204105532.GA2065@gate.ebshome.net>
In-Reply-To: <20031204105532.GA2065@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


U¿ytkownik Eugene Surovegin napisa³:

>On Thu, Dec 04, 2003 at 11:37:28AM +0100, Wojciech Kromer wrote:
>
>
>>i have to check end-of-trasmit interrupt code, but it seems to be good,
>>and it's common used driver (i hope so)
>>
>>
>
>Yep, quick look didn't reveal anything suspicious.
>
>To quickly check TX skb leak theory I'd add one counter and
>  1) increment it in fcc_start_xmit, and increment it for each
>     transmitted packet (e.g. at line 450)
>
>  2) decrement it in fcc_enet_interrupt right after dev_kfree_skb_irq
>     (at line 593).
>
>Make this counter accessible from user mode, e.g. through /proc and
>run your test :)
>
>
>
so i made such test, theese are results:

bash-2.05# cat /proc/interrupts
           CPU0
 19:        157   8260 SIU   Edge      dsp_msg
 33:      81139   8260 SIU   Edge      fenet
 34:          0   8260 SIU   Edge      fenet
 40:       3909   8260 SIU   Edge      uart
 42:        134   8260 SIU   Edge      uart
 43:          0   8260 SIU   Edge      uart
BAD:      14481

bash-2.05# cat /proc/kdebug
tx_skb_alloc=53384 tx_skb_free=29058

_anyone_ knows why there is such difference between allocs and frees in
fcc_enet.c



--
* * * * * * * * * * * *
* per pedes ad astra! *
* * * * * * * * * * * *    mailto:krom@dgt-lab.com.pl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

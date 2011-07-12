Return-Path: <ronny.meeus@gmail.com>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4B830B6F74
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jul 2011 05:52:08 +1000 (EST)
Received: by gxk27 with SMTP id 27so2884209gxk.15
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jul 2011 12:52:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1310484474.2871.14.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
References: <CAAXf6LXHeiCT+n=Wpdf=QfUXUHUSd7fmx9y3kB7te8N3ON1fTg@mail.gmail.com>
	<1310465411.3314.6.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
	<CAMJ=MEeC1hoqufs7AfFRn3yJoC8mdw7v+14N+7e=wQuJefm4_w@mail.gmail.com>
	<1310484474.2871.14.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
Date: Tue, 12 Jul 2011 21:52:04 +0200
Message-ID: <CAMJ=MEcQUiE3DCRGS--C8apk994L_eE+x_tAPn1ewTYBe3kGYw@mail.gmail.com>
Subject: Re: softirqs are invoked while bottom halves are masked (was: Re:
	[PATCH] [PATCH] Fix deadlock in af_packet while stressing raw ethernet
	socket interface)
From: Ronny Meeus <ronny.meeus@gmail.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org,
	afleming@freescale.com,
	Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2011 at 5:27 PM, Eric Dumazet <eric.dumazet@gmail.com> wrot=
e:
> Le mardi 12 juillet 2011 =E0 14:03 +0200, Ronny Meeus a =E9crit :
>
>> Sorry for not mentioning we were using a patched kernel.
>> I was not aware that the code involved was patched by the FreeScale
>> patches we applied. The code found in the stack dumps is not
>> implemented in FSL specific files.
>>
>> While reading the code of af_packet I saw that the spin_lock_bh is
>> used in several places while this is not the case in the tpacket_rcv
>> function. Since we had a locking issue in that code, I thought that my
>> patch would be OK.
>> I was not aware that for that specific function (tpacket_rcv) a
>> different lock primitive must be used. A suggestion for improvement:
>> it would be better to document this pre-condition in the code.
>>
>> After doing the change you proposed our code now looks like:
>>
>> >---if (dev->features & NETIF_F_HW_QDISC) {
>> >--->---txq =3D dev_pick_tx(dev, skb);
>> >--->---local_bh_disable();
>> >--->---rc =3D dev_hard_start_xmit(skb, dev, txq);
>> >--->---local_bh_enable();
>> >--->---return rc;
>> >---}
>>
>> >---/* Disable soft irqs for various locks below. Also
>> >--- * stops preemption for RCU.
>> >--- */
>> >---rcu_read_lock_bh();
>>
>> but we still see the issue "BUG: sleeping function called from invalid c=
ontext":
>
> Of course you are if this is the only change you did.
>
>>
>> [ =A0 91.015989] BUG: sleeping function called from invalid context at
>> include/linux/skbuff.h:786
>> [ =A0 91.117096] in_atomic(): 1, irqs_disabled(): 0, pid: 1865, name: NM=
TX_T1842
>> [ =A0 91.200461] Call Trace:
>> [ =A0 91.229672] [ec58bbd0] [c000789c] show_stack+0x78/0x18c (unreliable=
)
>> [ =A0 91.305791] [ec58bc10] [c0022900] __might_sleep+0x100/0x118
>> [ =A0 91.372524] [ec58bc20] [c029f8d8] dpa_tx+0x128/0x758
>
>
> Please read again my mail :
>
> I said : "doing GFP_KERNEL allocations in dpa_tx() is wrong, for sure."
>
> I dont have this code, but I suspect it's using : skb_copy(skb,
> GFP_KERNEL)
>
> Just say no, use GFP_ATOMIC instead.
>
> Real question is : why skb_copy() is done, since its slow as hell.
>
>> [ =A0 91.431957] [ec58bc80] [c02d78ec] dev_hard_start_xmit+0x424/0x588
>> [ =A0 91.504952] [ec58bcc0] [c02d7ab0] dev_queue_xmit+0x60/0x3ac
>> [ =A0 91.571692] [ec58bcf0] [c0338d54] packet_sendmsg+0x8c4/0x988
>> [ =A0 91.639457] [ec58bd70] [c02c3838] sock_sendmsg+0x90/0xb4
>> [ =A0 91.703066] [ec58be40] [c02c4420] sys_sendto+0xdc/0x120
>> [ =A0 91.765646] [ec58bf10] [c02c57d0] sys_socketcall+0x148/0x210
>> [ =A0 91.833420] [ec58bf40] [c001084c] ret_from_syscall+0x0/0x3c
>> [ =A0 91.900153] --- Exception: c01 at 0x4824df00
>> [ =A0 91.900157] =A0 =A0 LR =3D 0x4828a030
>>
>
>
>

I have identified the piece of code, it was a call to skb_unshare. I
have changed it into GFP_ATOMIC.

>---if (skb_cloned(skb))
>--->---skb =3D skb_unshare(skb, GFP_ATOMIC);

After doing this change, I do not see the issue anymore. At least not
for the test I'm doing right now.
After seeing all your comments today, it might be that other issues popup l=
ater.

BTW Are there any good sites (or books) that document this part of the
Linux kernel?

Best regards,
Ronny

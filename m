Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7060BDE3C8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 07:39:20 +1100 (EST)
In-Reply-To: <000001c87591$2b5a8740$6405a8c0@absolut>
References: <000001c87591$2b5a8740$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <E5A4895F-4CED-44C5-BFD1-9FD3E57F69CF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: NETdev driver question xxxx_type_trans()
Date: Fri, 22 Feb 2008 14:39:07 -0600
To: rmcguire@videopresence.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 22, 2008, at 14:26, Russell McGuire wrote:

> All,
>
> A general and specific question on the behavior of netdev devices =20
> before received sk_buff(s) get passed up to the kernel.
>
> I am almost done creating / testing an HDLC device driver for the =20
> 83xx.
>
>
> I have it working at a low level and was printing out skb_bufs =20
> before and after TX and RX, to ensure data integrity.
>
> Due to me having the print_skbbuf, AFTER the hdlc_type_trans(skb, =20
> ndev).
>
> I thought I was continuously losing 14 bytes of data, after a =20
> little digging I realized that the hdlc_type_trans() call
>
> was shifting the skb->data pointer forward by 14 bytes. ????????
>
> Is this corresponding to a 14 byte pad that the kernel stack adds =20
> before it sends it down?
>
> And why isn=92t the data length being shortened as a result after I =20=

> call hdlc_type_trans?
>
> Anyway=85 I guess I am confused as to what this function was intended =20=

> for, I see there are other calls for eth_type_trans, so I imagine =20
> their usage is similar.
>
> When are they needed?
>


They move the data pointer to point to the start of the L2 header.  =20
There's no need for the kernel to see the L1 header, and it doesn't =20
expect it to be there when it looks at the skb.

You shouldn't be using it for TX packets.  For TX, I believe the =20
kernel takes care of setting up the L1 header, though I'm not =20
familiar with the kernel's hdlc support.

Andy=

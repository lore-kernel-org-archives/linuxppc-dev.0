Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id AB9B2B7D48
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Apr 2010 03:55:04 +1000 (EST)
Received: by gyf2 with SMTP id 2so55321gyf.15
	for <linuxppc-dev@ozlabs.org>; Tue, 06 Apr 2010 10:55:03 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <7a42d507-bf50-40f3-a2a0-8de682b314d7@SG2EHSMHS017.ehs.local>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
	<1270502993.9013.36.camel@edumazet-laptop>
	<7a42d507-bf50-40f3-a2a0-8de682b314d7@SG2EHSMHS017.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 6 Apr 2010 11:54:42 -0600
Message-ID: <p2vfa686aa41004061054qad1495bbxdf6deb5d5d9dd4bf@mail.gmail.com>
Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
To: John Linn <John.Linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Dumazet <eric.dumazet@gmail.com>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, John Tyner <jtyner@cs.ucr.edu>,
	michal.simek@petalogix.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 5, 2010 at 3:33 PM, John Linn <John.Linn@xilinx.com> wrote:
> From: Eric Dumazet [mailto:eric.dumazet@gmail.com]
>> > +/* Align the IP data in the packet on word boundaries as MicroBlaze
>> > + * needs it.
>> > + */
>> > +
>> > =A0#define XTE_ALIGN =A0 =A0 =A0 32
>> > -#define BUFFER_ALIGN(adr) ((XTE_ALIGN - ((u32) adr)) % XTE_ALIGN)
>> > +#define BUFFER_ALIGN(adr) ((34 - ((u32) adr)) % XTE_ALIGN)
>> >
>>
>> Very interesting way of doing this, but why such convoluted thing ?
>
> Grant might have insight into why this started this way, I just updated t=
o help with MicroBlaze alignment.

It was that way in the code I received from Yoshio Kashiwagi and David
H. Lynch.  I have no problem with it being changed.

Personally I would probably write a followup patch to change this to
netdev_alloc_skb_ip_align(), just to keep changes logically separated.
 But I'm okay with it rolled into this patch also.

g.

Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-qy0-f170.google.com (mail-qy0-f170.google.com
	[209.85.216.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0F979B6F62
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 17:44:31 +1000 (EST)
Received: by qyg14 with SMTP id 14so2334849qyg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 00:44:28 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <4DF7BE43.1010407@freescale.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
	<4DF7BE43.1010407@freescale.com>
Date: Wed, 22 Jun 2011 09:44:28 +0200
Message-ID: <BANLkTi=iqT6_8XW7hNCn-Ezd0RfcEcfucQ@mail.gmail.com>
Subject: Re: Mapping an executable page
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 14, 2011 at 10:02 PM, Timur Tabi <timur@freescale.com> wrote:
> Thomas De Schampheleire wrote:
>
>> * However, if you jump to an address in that page, you'll have to make
>> sure that the entire code that executes is mapped (make map_size large
>> enough).
>
> Well, that seems obvious.

Agreed.

>
>> * When that range spanned multiple pages, I faced the issue of only
>> one page being actually mapped in the TLBs. My assumption is that the
>> call to __ioremap not necessarily updates the TLBs, but mainly some
>> kernel-internal tables. The actual TLB mapping presumably happens when
>> a data exception occurs.
>
> Hmmm.... I find that surprising. =A0Memory allocated via ioremap() is sup=
posed to
> be available in interrupt handlers, where TLB mappings can't be created
> on-the-fly. =A0I'm not sure that your observation is correct.
>
>> * Therefore, to make sure that the mapping I intended with __ioremap()
>> is actually reflected in the TLB tables, I added dummy reads of each
>> page in the TLB, prior to jumping to the boot code, as follows:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* make sure memory is read, once every =
4Kbyte is enough */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (p =3D vaddr; p < vaddr + map_size; =
p +=3D 0x1000) {
>
> You should at least use PAGE_SIZE instead of 0x1000.

Thanks, I fixed this.

Thomas

Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com
	[209.85.216.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2ABEAB6F9F
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 17:52:32 +1000 (EST)
Received: by qwi4 with SMTP id 4so411158qwi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 00:52:30 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <20110614152601.6258d3a6@schlenkerla.am.freescale.net>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
	<BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
	<20110614152601.6258d3a6@schlenkerla.am.freescale.net>
Date: Wed, 22 Jun 2011 09:52:29 +0200
Message-ID: <BANLkTi=e_Yy8ak17c53PHq8WzDMka3a9Qg@mail.gmail.com>
Subject: Re: Mapping an executable page
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Tabi Timur-B04825 <B04825@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 14, 2011 at 10:26 PM, Scott Wood <scottwood@freescale.com> wrot=
e:
> On Tue, 14 Jun 2011 10:56:31 +0200
> Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com> wrote:
>
>> * Therefore, to make sure that the mapping I intended with __ioremap()
>> is actually reflected in the TLB tables, I added dummy reads of each
>> page in the TLB, prior to jumping to the boot code, as follows:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* make sure memory is read, once every =
4Kbyte is enough */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (p =3D vaddr; p < vaddr + map_size; =
p +=3D 0x1000) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long dummy =3D =
*(volatile unsigned long *)p;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void)dummy;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> * After these changes (make sure all code is mapped + make sure to
>> read all pages so that the TLBs are updated), my scenario works fine.
>
> This is fragile -- you are assuming that it's possible to fit this
> set of pages in TLB0 all at once, and that none of them will be
> evicted/invalidated by the time you're done.

You're right. I think that disabling interrupts (which I can do
because I'm in a reset scenario) should fix this right? See also my
reply to Timur Tabi's post.

>
> If you really need to do this, I sugest using settlbcam() from
> arch/powerpc/mm/fsl_booke_mmu.c to create TLB1 entries with IPROT set.

Unfortunately, settlbcam is not exported to modules. Since I prefer to
be able to do all this from a kernel module, I cannot use that
function. Thanks for the suggestion though.

>
> Better still if you could live with whatever memory the kernel has alread=
y
> pinned.

In this case it is not possible. I need to jump to boot code which is
residing somewhere in physical RAM, outside the kernel memory ranges.

Best regards,
Thomas

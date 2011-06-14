Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com
	[209.85.218.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A2FEB6FB4
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 18:56:35 +1000 (EST)
Received: by yih10 with SMTP id 10so3710167yih.15
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2011 01:56:31 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
References: <BANLkTikd3ZtNRcz=ZWSsDL9OoeV0Wndy1g@mail.gmail.com>
	<BANLkTinOxqF=TcBxQOsfJSot-1XH3iErXA@mail.gmail.com>
Date: Tue, 14 Jun 2011 10:56:31 +0200
Message-ID: <BANLkTimhKOvY8XA=_20rjtkZ0Um45o2Bow@mail.gmail.com>
Subject: Re: Mapping an executable page
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
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

Hi,

On Sun, May 29, 2011 at 4:53 PM, Tabi Timur-B04825 <B04825@freescale.com> w=
rote:
> On Fri, May 27, 2011 at 8:25 AM, Thomas De Schampheleire
> <patrickdepinguin+linuxppc@gmail.com> wrote:
>
>> Although I realize that what I need to achieve is unconventional, what
>> is the correct way of mapping a certain address range into memory, and
>> be able to execute from it?
>
> Have you tried looking at the actual TLB entry for this page to see if
> it's correct? =A0Also, you might need to do some kind of instruction
> cache flushing before you jump to that page.

Sorry to have delayed this so long.
I had to do quite some experimentation to get it finally working. Here
are my findings:
* to map a page as executable, the following does indeed work:
void __iomem *vaddr =3D __ioremap(map_start, map_size, (_PAGE_BASE |
_PAGE_KERNEL_RWX));

* However, if you jump to an address in that page, you'll have to make
sure that the entire code that executes is mapped (make map_size large
enough).

* When that range spanned multiple pages, I faced the issue of only
one page being actually mapped in the TLBs. My assumption is that the
call to __ioremap not necessarily updates the TLBs, but mainly some
kernel-internal tables. The actual TLB mapping presumably happens when
a data exception occurs.
Unfortunately, since I left the Linux kernel and jumped to other
(boot) code that reassigns the exception vectors, the kernel-internal
tables are not used anymore, and the exception handler cannot update
the TLBs correctly.

* Therefore, to make sure that the mapping I intended with __ioremap()
is actually reflected in the TLB tables, I added dummy reads of each
page in the TLB, prior to jumping to the boot code, as follows:
                /* make sure memory is read, once every 4Kbyte is enough */
                for (p =3D vaddr; p < vaddr + map_size; p +=3D 0x1000) {
                        unsigned long dummy =3D *(volatile unsigned long *)=
p;
                        (void)dummy;
                }

* After these changes (make sure all code is mapped + make sure to
read all pages so that the TLBs are updated), my scenario works fine.

Best regards,
Thomas

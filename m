Subject: RE: New 745x errata
From: Adrian Cox <adrian@humboldt.co.uk>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <XFMail.20031114114053.pochini@shiny.it>
References: <XFMail.20031114114053.pochini@shiny.it>
Content-Type: text/plain
Date: 14 Nov 2003 11:00:41 +0000
Message-Id: <1068807642.23764.108.camel@newt>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-11-14 at 10:40, Giuliano Pochini wrote:

> > 1) The BTIC doesn't work reliably: it can cause execution of corrupted
> > instructions. (This is listed in the errata for the 7450 and 7457, but
> > not for the 7455. I'll only believe that the 7455 escaped this bug if I
> > hear confirmation out of Motorola.)
>
> Did you try to ask them about it ?

Yes, but an answer to this sort of question will normally take a few
days.  I thought it was worth raising the issue on the mailing list now.

> > 2) dcbt to protected addresses can cause spurious bus cycles. This could
> > potentially be exploited from userspace to lock up hardware.
>
> Hm, a 1-cycle window this is very small.  Anyway, if dc* instructions are
> used inside the kernel, we could keep them disabled in userspace only.

The kernel uses the dc* instructions in copy_page, and in prefetches
everywhere. These uses should all be safe, unless any driver prefetches
an unchecked userspace pointer. The only problem is that we don't
currently switch the value of HID0 when entering and leaving userspace.

- Adrian


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

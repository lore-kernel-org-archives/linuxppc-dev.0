To: randy@cnetia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cache init problems - (non multi-mimed mail ) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Apr 2003 13:52:54 +0900."
             <200304240452.h3O4qrq04070@www.cnetia.com>
Date: Thu, 24 Apr 2003 09:33:04 +0200
Message-Id: <20030424073309.4522EC5E29@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200304240452.h3O4qrq04070@www.cnetia.com> you wrote:
>
> I have a problem for porting PPC-BOOT to STT755EMC.

Do  not  spend  effort  for  PPCBoot.  PPCBoot  is  a  dead  project,
development  has  been  discontiuned  half a year ago. Please use the
successort project U-Boot instead.

You better post U-Boot related questions on the u-boot-users  mailing
list. Chances for helpful replies are better then.

> Here is the code i used.
>
>         /* icache_enable */
>         mfspr   r3, HID0
>         li      r5, HID0_ICFI|HID0_ILOCK
>         andc    r3, r3, r5
>         ori     r3, r3, HID0_ICE
>         ori     r5, r3, HID0_ICFI
>         mtspr   HID0, r5
>         mtspr   HID0, r3
>         isync
>
>  /* dcache_enable */
>         mfspr   r3,HID0
>         ori     r3,r3,HID0_DCE | HID0_DCFI
>         sync
>         mtspr   HID0,r3

Why don't you use the existing code which works fine on a  couple  of
systems?  The  dcache_enable  code you present here is different from
the code present in PPCboot and in U-Boot.  It  seems  you  tried  to
"optimize" it, but without understanding it.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If the facts don't fit the theory, change the facts.
                                                   -- Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

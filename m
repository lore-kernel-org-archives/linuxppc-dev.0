To: Leonard Ye <leonard_ye@ylez.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel support of MPC8XX series 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Apr 2001 17:00:22 +0800."
             <5.0.2.1.0.20010402165636.00b02008@pop.ylez.com>
Date: Mon, 02 Apr 2001 11:26:25 +0200
Message-Id: <20010402092630.6495428826@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Leonard,
in message <5.0.2.1.0.20010402165636.00b02008@pop.ylez.com> you wrote:
>
> Thanks for your information.  For the embedded system that I am going to
> develop, kernel 2.4 and PCMCIA is a must.  Have you get them working on
> MPC8XX platform, especially MPC855?  I have read the HOWTO, it just tell me
> MPC8XX is support without any specific information.

First, you can use the normal PCMCIA package, which has some  support
for  PCMCIA  on  the MPC8xx. Most probably you will have to make some
adjustments for your specific board, i. e. voltage switching etc.

For us, the majority  of  devices  are  memory  cards  like  SanDisk,
CompactFlash  or  IDE  harddisk  adapters.  On  one  side, the PCMCIA
package is a lot of overkill here; on the other  side  it  cannot  be
used  when  you  want to boot from such a device. That's why we added
low-level direct IDE support to the kernel.

It's much more restricted than the  full-blown  PCMCIA  package.  For
instance, removing or replacing a card while the system is running or
similar  events  are  not  handled  at  all.  But  for  the  embedded
applications we've seen so far that never has been a requirement.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
On a clear disk you can seek forever.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

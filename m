To: Jeff H Zhong <jeff@doremilabs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging using bdi2000, unable to proceed. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 18 Apr 2003 10:49:51 -0000."
             <3E9FD84F.2C40F0ED@doremilabs.com>
Date: Sat, 19 Apr 2003 00:22:12 +0200
Message-Id: <20030418222217.E5F71C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E9FD84F.2C40F0ED@doremilabs.com> you wrote:
>
> Wolfgang Denk wrote:
> >
> > in message <3E9FB7FD.93947BE5@doremilabs.com> you wrote:
> > >
> > > Could you give me a hand to help me figure out this issue on ebony?
> >
> > I've read your story before, but I cannot help.
> >
> > > If I use "bootp" or "tftp" to load kernel image(linuxppc_2_4_devel from
> > > BK) at address 0x01000000 and then issue "bootm", everything works fine.
> > > I have also programmed the image into flash at 0xffe00000, but each time
> > > when I issue "bootm 0xffe00000", it will get stuck at when trying to
> > > mount NFS.
> >
> > Technically there is absolutely no difference between both cases:  in
> > either  case  U-Boot  will  copy  and  uncompress  the  kernel to RAM
> > starting at physical adress 0x0000, and start it there.  I  have  not
> > the slightest idea whaty could cause a behaviour as described by you,
> > nor have I ever seen anything like that before.

Well, there _is_ one obvious difference: when you use "tftp" to  load
kernel  then  U-Boot  will  perform the initialization of the network
interface. You can perform a simple test for this:

Do a dummy TFTP download, and then try  to  "bootm"  the  image  from
flash. I bet it'll work.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

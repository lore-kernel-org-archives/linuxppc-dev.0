Date: Thu, 27 Jan 2000 10:31:42 -0500 (EST)
From: "Kevin M. Myer" <kevin_myer@elanco.k12.pa.us>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.3.40 + offb.c problem
Message-ID: <Pine.LNX.4.20.0001271014260.6226-100000@marble.elanco.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am trying to get the 2.3.X series running on my Apple Network Server.  I
made a few changes to the patches that Scott Emji has been maintaining for
the 2.2.X series and applied them.  One of those patches is a video driver
for the Cirrus 54m30 chip but that driver doesn't offer the full chip
functionality (i.e it can't do 1024x768 under linux).  I noticed Jeff
Garzik wrote a driver that encompasses that chipset (among other Cirrus
chipsets) and decided to try and use that instead.

Compilation goes along happily until I get to the video driver
section.  At that point, I get:

offb.c: In function `offb_init_driver':
offb.c:474: parse error before `{'
offb.c: At top level:
offb.c:479: parse error before `return'

which is the code section:

#ifdef CONFIG_FB_CLGEN
    if ((!strncmp(dp->name, "MacPicasso",10) ||
        (!strncmp(dp->name, "54m30",5)) {
       clgen_of_init(dp);
       return 1;
    }
#endif /* CONFIG_FB_CLGEN */

This is with the Open Firmware framebuffer option checked in the kernel
configuration.

I'm more than a little green when it comes to kernel hacking but there
doesn't seem to be anything wrong with that code snippet.  I thought at
first some of the changes I had made to incorporate the other cirrus54m30
driver were goofing things up so I grabbed a pristine source of 2.3.40 and
am still having the same problems.

Could someone point me in the right direction on this one?

Thanks,

Kevin

--
     ~        Kevin M. Myer
    . .       Network/System Administrator
    /V\       ELANCO School District
   // \\
  /(   )\
   ^`~'^


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

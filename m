Date: Wed, 16 Dec 1998 08:52:21 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
Reply-To: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: clgenfb
Message-ID: <Pine.BSI.3.96.981216084200.11954A-100000@usr08.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Well, I'm starting to get some success.  Thanks Geert, for all your help so
far.  This morning I was finally able to boot and get a login prompt with
the clgenfb framebuffer compiled into the kernel (and no VGA console at
all).  I now need to go back through and get rid of debug printks I've
sprinkled everywhere and get the colors to work with the logo (the penguin
had blue feet) and some other cleanup.  Most importantly, I figure it would
be a good idea to match my coding style with the rest of the modified file.

I have a couple questions now.
1) clgenfb.c has some code that will only work on the APUS (and/or m68k?) --
it expects a zorro2 board and uses the kernel_map() function -- and my
modifications assume the Motorola PowerStack memory layout, since I don't
know a way to find the video memory otherwise.  Because of this, I have some
#ifdef/#ifndef blocks.  Should I use CONFIG_PREP or CONFIG_APUS or something
else for these blocks?  (I'd prefer to use the same #ifdef everywhere).
Currently I'm using #ifdef/#ifndef CONFIG_PREP around the specified parts.

2) When I have something working that I'm comfortable with, what should I do
next?  I assume it would be good to have someone else using the clgenfb
driver use my version on APUS/wherever, and also get someone else on the
PowerStack?)  Any volunteers for this?  Is there a better way than others to
provide diffs?  (I'm going off the vger tree, so not sure what I should make
a diff against -- the main modifications are clgenfb.c, prep_setup.c, and a
couple Config.in files (so you can select the clgenfb driver on prep).

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

Date: Tue, 30 Nov 1999 15:06:17 -0700 (MST)
From: Stephen Edie <sedie@terraplex.com>
To: linuxppc-dev@lists.linuxppc.org, yellowdog-devel@lists.yellowdoglinux.com
Subject: Frame buffer / mmap() weirdness
Message-ID: <Pine.LNX.4.10.9911301456090.6524-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I have been noticing some strange behavior while working with Linux frame
buffer devices on PPC.  Perhaps I am just doing something stupid.  I open
the frame buffer using:

fbdev_handle = open("/dev/fb0", O_RDWR);

I can draw to the frame buffer using:

lseek(fbdev_handle, 0, SEEK_SET);
write(fbdev_handle, pixmap, size);

This part works fine.  What causes problems is attempting to memory map
the frame buffer using:

address = mmap(0, screen.height * screen.stride * screen.bpp / 8,
               PROT_READ | PROT_WRITE, MAP_SHARED, fbdev_handle, 0);

When doing this, address[0] points outside of the video memory and
strangely enough, address[512] points to the first pixel in memory!  So if
I do the following, everything works as expected:

address = (char *)(mmap(0, screen.height * screen.stride * screen.bpp / 8
                        + 512, PROT_READ | PROT_WRITE, MAP_SHARED,
                        fbdev_handle, 0)) + 512;

I don't think this is right!  Is this a kernel bug in the frame buffer
driver code?  (This is being tested using OFFB by the way)  Is there
something weird going on here with page alignment or something?

Thanks,
Stephen

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

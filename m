Message-ID: <19991123215733.22049.rocketmail@web306.mail.yahoo.com>
Date: Tue, 23 Nov 1999 13:57:33 -0800 (PST)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: need suggestions
To: Jim Chapman <jim.chapman@iname.com>, LiuTao <tliu@ict.ac.cn>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jim,

Here's yet another way to do it.  We used a section
called .gzimage, but you could just as easily add it
to .text instead.  Instead of using the
link/objcopy/compile/link method in the Makefile, do
this instead:


zvmlinux: $(OBJECTS) ../coffboot/vmlinux.gz
      $(OBJCOPY) $(OBJCOPY_ARGS) -R .gzimage gzimage.o
      $(OBJCOPY) $(OBJCOPY_ARGS) -R .comment
--add-section=.gzimage=../coffboot/vmlinux.gz
--set-section-flags=.gzimage=alloc,load,readonly,data
gzimage.o
      $(LD) $(ZLINKFLAGS) -o $@ $(OBJECTS)
     powerpc-elf-strip --strip-all $@

Create a dummy file called gzimage.c, where the zImage
data will be copied into section .gzimage:

/*
 * gzimage.c
 *
 * dummy file to allow a compressed zImage to be added
 * into a linker section, accessible by the boot code.
 */
char dummydummy;


Then add the following to the vmlinux.lds script, and
reference these symbols in your loader as extern
char[].  Modify the loader to load zImage data from
these addresses instead.  I think this method will
work for initrd as well.

/* For loader only: Put the zImage after everything
 * else
 */
  _gzstart = . ;
  .gzimage : { *(.gzimage) }
  _gzend = . ;



-Brian Kuschak


> ... had to find
> a way to put the
> image section inside the text segment so that the
> image data would be
> copied by the vxworks bootrom. There may be a clever
> way to do that
> using ld scripts...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

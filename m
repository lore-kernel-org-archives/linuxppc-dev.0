Message-ID: <39637BC3.17F2F09@mvista.com>
Date: Wed, 05 Jul 2000 11:17:39 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Matthew Locke <mlocke@jps.net>
CC: Matthias Fuchs <matthias.fuchs@esd-electronics.com>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: making kernel for ppc405gp from montavista sources
References: <NDBBJCEBJMJJJBIMCFBEGEAICEAA.mlocke@jps.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthew Locke wrote:
>
> I believe 'make mrproper' blows away .config and autoconf.h.  I don't know
> what the state of your tree is now, but try to
>
> copy the .config again
> "make 'your favorite config process'" (mine is xconfig) keep all defaults
> and 'save and exit'. this will create things like autoconf.h
> "make dep"
> "make 'your favorite image'"


Follow the directions on my web page in the section "Building the kernel:",

   http://www.mvista.com/products/405gp_status/main.html

(This URL is likely to change in the next few days, I'll send out an announcement when
it does.)

After getting the .config, you need to

  make oldconfig
  make dep
  make one of the kernel targets

Please use "make menuconfig" instead of "make xconfig".  The last time I checked,
make xconfig generates incorrect results for the 405gp.  Fixing it to work is on
my to-do list.

Note that the web page points you to the May 3 kernel.  There is a new kernel as of
June 29, but I haven't announced it yet since I haven't updated the web page.


> > -----Original Message-----
> > From: owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Matthias
> > Fuchs
> > Sent: Saturday, August 05, 2000 9:02 AM
> > To: linuxppc-embedded
> > Subject: making kernel for ppc405gp from montavista sources
> >
> >
> >
> > Hello,
> >
> > I downloaded the linux_tar.gz file from montavista and unpacked it ! I
> > copied the .config file from the same location to the kernel tree's
> > root. Before I did a "make mrproper".
> >
> > When I run a "make dep" I got an error ! Well, I could start to check
> > out if there is an error in the tree, but I think that there is a
> > general mistake I made !
> >
> > Does anybody know where the error comes from ? Here is the output of my
> > "make dep":
> >
> > ----------------------
> > mfuchs@pc-matthias:~/mvista_405_linux_new/linux > make dep
> > make -C arch/ppc/boot fastdep
> > make[1]: Entering directory
> > `/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/boot'
> > /home/mfuchs/mvista_405_linux_new/linux/scripts/mkdep *.[Sch] > .depend
> > make[1]: Leaving directory
> > `/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/boot'
> > make -C arch/ppc/chrpboot fastdep
> > make[1]: Entering directory
> > `/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/chrpboot'
> > /home/mfuchs/mvista_405_linux_new/linux/scripts/mkdep *.[Sch] > .depend
> > make[1]: Leaving directory
> > `/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/chrpboot'
> > make -C arch/ppc/treeboot fastdep
> > make[1]: Entering directory
> > `/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/treeboot'
> > /home/mfuchs/mvista_405_linux_new/linux/scripts/mkdep *.[Sch] > .depend
> > make[1]: Leaving directory
> > `/home/mfuchs/mvista_405_linux_new/linux/arch/ppc/treeboot'
> > scripts/mkdep init/*.c > .depend
> > scripts/mkdep `find /home/mfuchs/mvista_405_linux_new/linux/include/asm
> > /home/mfuchs/mvista_405_linux_new/linux/include/linux
> > /home/mfuchs/mvista_405_linux_new/linux/include/scsi
> > /home/mfuchs/mvista_405_linux_new/linux/include/net -follow -name \*.h !
> > -name modversions.h -print` > .hdepend
> > make _sfdep_kernel _sfdep_drivers _sfdep_mm _sfdep_fs _sfdep_net
> > _sfdep_ipc _sfdep_lib _sfdep_arch/ppc/kernel _sfdep_arch/ppc/mm
> > _sfdep_arch/ppc/lib _FASTDEP_ALL_SUB_DIRS="kernel drivers mm fs net ipc
> > lib arch/ppc/kernel arch/ppc/mm arch/ppc/lib"
> > make[1]: Entering directory `/home/mfuchs/mvista_405_linux_new/linux'
> > make -C kernel fastdep
> > make[2]: Entering directory
> > `/home/mfuchs/mvista_405_linux_new/linux/kernel'
> > make[2]: *** No rule to make target
> > `/home/mfuchs/mvista_405_linux_new/linux/include/linux/autoconf.h',
> > needed
> > by
> > `/home/mfuchs/mvista_405_linux_new/linux/include/linux/modules/sig
> > nal.ver'.
> > Stop.
> > make[2]: Leaving directory
> > `/home/mfuchs/mvista_405_linux_new/linux/kernel'
> > make[1]: *** [_sfdep_kernel] Error 2
> > make[1]: Leaving directory `/home/mfuchs/mvista_405_linux_new/linux'
> > make: *** [dep-files] Error 2
> > mfuchs@pc-matthias:~/mvista_405_linux_new/linux >
> > --------------------------------------
> >
> > thanks for advise
> > Matthias
> >
> > --
> > -------------------------------------------------
> > \ Matthias Fuchs                                 \
> >  \ esd electronic system design Gmbh              \
> >   \ Vahrenwalder Straße 205                        \
> >    \ D-30165 Hannover                               \
> >     \ email: matthias.fuchs@esd-electronics.com      \
> >      \ phone: +49-511-37298-0                         \
> >       \ fax:   +49-511-37298-68                        \
> >        --------------------------------------------------
> >
>


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

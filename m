To: "Rupesh S" <rupeshs@myw.ltindia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MC850 peripheral support in linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Mar 2004 09:24:16 +0530."
             <s063f6d1.092@EMAIL>
Date: Fri, 26 Mar 2004 12:55:49 +0100
Message-Id: <20040326115554.346D8C118A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <s063f6d1.092@EMAIL> you wrote:
>
> I plan to use the latest ELDK from DENX
> Is there any known problems in ELDK Distro?

Yes, a few.

* The static microwindows libraries were stripped and are useless
  for linking; updated RPM's are available.

* The index for the local RTC has changed in the NTPD source so you may
  need to adapt your /etc/ntp.conf file; documentation was updated at
  http://www.denx.de/twiki/bin/view/DULG/UseNTPToSynchronizeSystemTimeAgainstRTC

> I could see that the ELDK distro is well packed with all toolchains,
> kernel and applications.
> I could no find out the "target filesystem" ?

If you install for example the  "ppc_8xx"  packages  to  the  default
location   /opt/eldk,   then  /opt/eldk/ppc_8xx/  will  be  the  root
directory of your target filesystem. You can use this and  export  it
on a NFS server; see the detailed documentation in the DULG.

> Should the target filesystem be created manually from the directory
> into which I install all the application RPMs.? Is there any script
> files already available doing the same.

If you're talking about a standlone target filesystem you can use the
SELF package; eitehr by using the SELF source RPM and  modifying  the
build    script,    or    by    using   the   pre-build   images   in
/opt/eldk/ppc_8xx/images/ and modifying those as documented, see
http://www.denx.de/twiki/bin/view/DULG/HowToAddFiles and
http://www.denx.de/twiki/bin/view/DULG/HowToIncreaseSizeOfRamdisk

Or  you  can  start  from  scratch  using  the  standard  tools  like
genext2fs, mkcramfs, mkfs.jffs2, etc.

> How is the kernel and rotofs attachment done ?

We normally use U-Boot to boot LInux. Just read the DULG for details:
http://www.denx.de/twiki/bin/view/DULG/Manual

> Do I need o do it with my bootloader passing command line arguments to
> the kernel ? (I plan to use u-boot).

Read the DULG.

> > Don't expect too much of performance out of a 850;  the  tiny
> caches
> > a major pain.
>
> As far as performance is considered, I do not need very high.
> Out of curisity, what exactly is the problem ?

As I wrote: it's the tiny caches. Performance on RISC processors like
the PowerPC stands and falls witch cache size.  A  PowerPC  processor
with  only 2 kB Instruction Cache and 1 kB Data Cache like the MPC850
performs as castrated.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It's a small world, but I wouldn't want to paint it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

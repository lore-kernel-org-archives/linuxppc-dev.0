MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Re: Re: which is the best root File system in embed linux system?
Date: Thu, 22 Apr 2004 06:52:40 -0600
Message-ID: <8039970AF146314597457D3B51A68B382E0510@cossmgmbx02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: "linuxppc-embedded@lists.linuxppc" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just to add to Wolfgang's comments, turning off power without warning is not simply a file system problem.  It is a hardware problem that NO file system, no matter how "robust" it is, can survive.  The memory chips (flash, EEPROM, battery backed RAM) require a finite amount of time to actually perform the write operation.  If you shut down power at the wrong time (and it WILL happen even if the probabilities appear to be vanishingly small), the memory chip will scribble on an unintended location.

Voice of painful experience: the scribbling will be on an _UNINTENDED_ location at some point.  You cannot count on the write being a partial write to the INTENDED location.  It WILL overwrite something important at some point.  The probability may be very small, but it is NOT ZERO.

To prevent memory corruption, you need a power fail warning that gives you enough time to complete any write(s) in progress and get your software into a "no write" state.  If you have a writable file system, you will want to unmount the file system, which will take more time than the typical power fail holdup time.

Note that even battery backed RAM is vulnerable, and in some ways more vulnerable, even though (and because) they are so fast.  The classic problem with BB-RAM is that the processor doesn't get a clean reset and randomly strobes the write line with random garbage on the address and data bus, causing memory corruption.

The best solution is to have a software controlled power off switch: pushing the switch causes the processor to shut down in an orderly fashion including, as a last step, removing power.  This is the power switch methodology used by most or all PCs today (holding the switch for 6 seconds typically causes a hardware power removal in case the software is AFU).

The second-best solution is to have a power monitor on the raw power side plus enough energy stored in capacitors to give several milliseconds of operating time for the processor to tidy up things and go into an wait loop where it waits for the power monitor (you DO have a GOOD power monitor I hope) to reset it.  Note that the wait loop typically needs to monitor the input power so that, if power is restored, it restarts rather than being stuck in the wait loop.

gvb


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf
> Of Wolfgang
> Denk
> Sent: Thursday, April 22, 2004 5:40 AM
> To: jeffy
> Cc: linuxppc-embedded@lists.linuxppc
> Subject: Re: Re: Re: which is the best root File system in embed linux
> system?
>
>
>
> In message <20040422085859.C6134424CD@denx.de> you wrote:
> >
> > Because our board will be turned on and off frequently, so
> I think "high stability" is the important, and a R/W file
> system is prefer selection too!
> > Another  performances such as speed of booting is not the focus!
>
> How about speed when accessing (especially reading) files? What about
> memory footprint?
>
> > Now our system can runs ok, I use EXT2 FS as the root file
> system build in a 32M DOC2000, but it seems it's unstable!
>
> You asked adbout a filesystem for flash before - this is NOT the same
> as DOC or  even  CompacfFlash,  as  these  devices  use  an  internal
> controller  which  may  perfom certain operations like wear levelling
> etc. So what do you want  to  know  -  filesystems  for  plain  flash
> memory, or for DOC?
>
> The ext2 filesystem is extremley well tested and can be considered to
> be very stable. Howebver, it was not designed to  be  used  like  you
> attempt  to  do - i. e. just powering off the device. You must always
> unmount an ext2 filesystem  (or  at  least  remount  it  read-only_)_
> before shutting doen the system.
>
> > In any time when the linux is starting, you turn off the
> power, maybe the root file system will crash!
>
> Yes, this is the logical consequence of your mis-use.
>
> > I have serval questions want to be confirmed:
> > 1. Whether the DOC2000 is unstable?
>
> NO. It is working perfectly fine in many applications.
>
> > 2. Can I build a EXT2 FS in flash?
>
> Yes, you can. Both in flash memory and on a DOC device. BUt you  have
> to  be aware of the restrictions (i. e. ext2 requires to be unmounted
> before shutdown, and it does not implement any wear  levelling  which
> may be useful on writable flash filesystems).
>
> > 3. How to avoid the file system crash in embed linux system?
>
> Don't do things which  are  outside  of  the  specifications  of  the
> software.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> "I like your game but we have to change the rules."
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

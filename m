Date: Wed, 8 Mar 2000 13:44:34 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 850 - Open Firmware or not? and more on the ide byteswapgame...
In-Reply-To: <38C5643C.D9C2A4BD@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10003081046130.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 7 Mar 2000, David Monro wrote:

> Oh, I think it is properly set up etc; I just finally had a realization
> that since NT was running little-endian, it didn't have the overhead of
> swapping the disk in order to run the same way round as the partition
> table indicated it was running.

Actually I'm suspecting a bug in the firmware which has other
consequences, but it does not matter.

> It isn't really that bad - basically they picked one format for the
> parition table (which happened to be the NT one). Other OSs can do what
> they like as long as the firmware sees a valid little-endian FDISK
> partition table with a PReP boot partition in it (and then the OS has to
> make sure it doesn't stomp on the boot partition). This afternoon I had
> a look at an AIX disk and discovered it was partitioned with a 3M PReP
> partition starting 2M from the front of the disk and nothing else. So
> I'd imagine that AIX probably stores something in the first 2M, and then
> uses everything execpt the first 5M of the disk under its own scheme.

The partition table format has a fixed endianness. I just suspect that the
ARC firmware gets it wrong when it tries to load a big endian OS. But  it
does not matter (you don't read and parse the partition table often to
make it a performance problem).

>
> > BTW: big endian is the right way for PPC, you don't want to run a PPC
> > in niadne-elttil mode under any circumstance.
>
> Unless you are Micro$oft :-) For that matter, Workplace OS (ie OS/2 for
> ppc) ran little-endian. I would guess in both cases the compaines
> decided that the endian cleanup of the source wasn't worth the hassle.
> Actually, why does it matter which way up you run the CPU?

Because of a few tricks that help to make code more compact: all the
multiple register load/store don't work in little endian. And early
PPC processors would not perform misaligned little endian access so that
for my x86 emulator I found it much simpler to run the PPC in big
endian.

For example in LE lhzx from an odd address woould trap, but lhbrx
from an odd address in BE mode which has exactly the same effect simply
proceeds (on 601, 603, and 604). There are many misaligned accesses in
BIOSes because the design dates from the 8 bit 8088 data bus which  did
not care at all. Besides running in LE mode requires processor and host
bridge dependant code, while using {l,st}[hw]brx does not...

> According to the PREP spec Solaris/PPC was also little-endian!

Yes, and Workplace OS and others....

> Presumably they decided PReP machines looked more like PCs than sparcs.
> In which case the only OS that the PReP spec mentions which runs
> big-endian is AIX. (What was Taligent - something from Apple maybe? The
> name in mentioned in the spec, but all the slots in the tables under
> that heading are blank, and so is the appendix for it :-))

Taligent was an Apple+IBM thing which apparently (i.e. at least for
the general public) always stayed in the vapor phase and never
condensed...

AIX and linuxppc. I suspect that on some machines also the host bridge
can't be put in LE mode, so the only way to be portable across all PPC
machines is to run BE. (There are other problems which prevent from easily
mixing LE and BE mode processes on PPC, the 601 weird mode switching being
only the tip of the iceberg).

>
> [..]
> > At a time due to these problems, I had code in the kernel which could grok
> > a partition table in any endianness but the rest of the disk was in normal
> > order (even the extended partition tables).
>
> Have you still got this code anywhere? This is exactly what we need; to
> grok the primary partition table little-endian but everything else
> native. Then we just need to write an fdisk to work with it :-)

I think this was something different: at a time fdisk did not work
correctly on BE systems because it would write multibyte fields in BE
order. The code has also changed a lot since then :-(

In any case, the fix for 2.3 might be to patch fs/partitions/msdos.c
by inserting:
=============================================================================
#ifdef __powerpc__
		/* Some firmware insist on byte swapping the partition table
		 */
                if ((*(__u16 *) (bh->b_data+510)) ==
			cpu_to_be16(MSDOS_LABEL_MAGIC)) {
			int i, __u16 * p;
			for (i=0, p=(__u16 *) (bh->b_data+0x1be); i<33;
			     i++, p++)
				swab16s(p);
		}
#endif
=============================================================================
just before:
                if ((*(__u16 *) (bh->b_data+510)) != cpu_to_le16(MSDOS_LABEL_MAGIC))
                        goto done;


There is similar code in drivers/block/genhd.c in 2.2.x

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

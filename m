From: Ira K Weiny <iweiny@falcon.csc.calpoly.edu>
Message-Id: <199908301907.MAA01424@falcon.csc.calpoly.edu>
Subject: 2.2.10 will not boot on PowerMac 8500
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 30 Aug 1999 12:07:00 -0700 (PDT)
Cc: linuxppc-user@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I have been trying to get a 2.2.10 kernel up and running on my PowerMac.  I
have downloaded both the pre-compiled and source from Pauls directory on
dev.linuxppc.org.  I can compile the source but niether kernel will boot.  Here
is the error message I get from OF.  (I tried it with BootX and all I got was a
blank screen with a frozen cursor, and I don't normally have a MacOS drive
attached.)

After the boot:
starting at C
opening display /bandit@F2000000/gc@10/sixty6@1C000 ... failed
opening display /chaos@F0000000/control@B_

Then from the top of the screen:
...ok
copying OF device tree...done

That is the last thing printed to the console.  This happens with both my
compiled version and the pre-compiled version.  I have tried different
configurations, some without BootX support, but at best I just don't get the
copying OF device tree message so I assume they are not getting as far?

I have looked in head.S and I have a 2.2.6 kernel which panics but does get
past this point.  I have noticed from looking at the preprocessed assembly of
head.S (2.2.6) and head.S (2.2.10) they seem to have different addresses for
the KERNELBASE?

2.2.6:
in file ppc_defs.h
#define  KERNELBASE  -1073741824

in file head.S
#define TOPHYS(x) (x - KERNELBASE)

...

_start:
   .long TOPHYS (__start),0,0

2.2.10:
in file page.h
#define PAGE_OFFSET  0xc0000000
#define KERNELBASE   PAGE_OFFSET
 
if file head.S
#define TOPHYS(x) (x - KERNELBASE)

...

_start:
   .long TOPHYS (__start),0,0


I don't know what configuration I should use to correct for this, and I don't
know enough about the OF interface to start messing with the assembly.  I have
read the tech notes from apple on OF 1044 1061, and 1062 but they are really
for developers of PCI cards NOT OS's.

Any insight on this would be greatly appreciated.
Oh PowerMac 8500 OF 1.0.5

Thanks
Ira Weiny


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

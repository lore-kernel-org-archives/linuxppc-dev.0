Message-ID: <38A18940.2EF90077@ccrl.mot.com>
Date: Wed, 09 Feb 2000 09:35:28 -0600
From: Steve Rossi <srossi@ccrl.mot.com>
MIME-Version: 1.0
To: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CUSTOM MP860 PowerQuiccMH BOARD-Need help to program Flash
References: <20000209091331.4718.qmail@web207.mail.yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------5BB9B163679DEE76D035472C"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5BB9B163679DEE76D035472C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi -
I'm no expert on embedded linux - just learning myself, but
I have been working with the EST system for some time.
You're right the *.BIN file will not work. It assumes that it
is reading an ELF file and tries to parse out certain sections
and disregards the rest.
The vmlinux image is indeed and ELF image, but it only
has a small program section - which loads the real image into
memory and then decompresses it and boots the kernel.
(This may not be 100% accurate, but its how I understand it.)
The point is, the real kernal image is contained in a data section
of the vmlinux binary which EST's convert ignores.
I believe that what you really need to do is to get that ENTIRE vmlinux
binary into FLASH, bit for bit, as is - without any mangling
by EST's convert. I think (from what I've heard, not from experience)
that the bootloader is smart enough to relocate the kernal
image to RAM when it boots.
I've written a really simple stupid program that takes any binary
file (i.e. vmlinux) and converts it to a BIN file that EST can
use.
All it really does is add a header to a binary file so the EST tools
can recognize it and knows where to put it. The header simply
specifies the starting address of the data. In your case - your
starting address will be the beginning of FLASH. I've attached
the code for that. This may not get you all the way there - there
may be other issues with FLASH booting that I don't understand,
but this may help.

Steve




Sebastien Articlaux wrote:

> Hello all PPC man,
>
> I am a student working for MATRA SI in electronic
> section
> We want to run linuxppc on a custom MPC860
> PowerQuiccMH board diskless,networless
> with 64Mo DRAM and 4Mo Flash.
>
> We use EST VisionProbe to debbug and download files
> into Flash and RAM.
>
> Sebastien Tadeoni who worked before me had built
> vmlinuw.initrd with
> embedded 2.2.5 and now my job is to download it to the
> Flash and try to boot...
>
> our Flash start at 0x0 to 0x3FFFFF
>     RAM   start at 0x8000000
>
> But my problem is that when I convert vmlinux.initrd
> (1.11 Mega, ELF Format) to a  *.BIN
> (Our emulator EST Vision Probe convert it to a BIN
> format before downloading into the Flash)
> there is only 26K of program code in the Flash which
> start at 0x100000
>
> I try to add some BIAS before download but it's the
> same.
>
> Do you know what?
>
> How can be sure that my file vmlinux.initrd(ELF
> Format) and my .BIN are correct ?
>
> I think .BIN is not good but i'm not sure...
>
> What do you think about that?
>
> Thank you in advance for your help.
>
> Sebastien ARTICLAUX

--
-------------------------------------------------------
Steven K. Rossi                     srossi@ccrl.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------



--------------5BB9B163679DEE76D035472C
Content-Type: text/plain; charset=us-ascii;
 name="bin2bin.c"
Content-Disposition: inline;
 filename="bin2bin.c"
Content-Transfer-Encoding: 7bit

/*
 * this application adds an EST header to a binary file
 * to allow downloading straight binary files into
 * target ram
 */

#include <stdio.h>
#include <string.h>

typedef struct {
    char id[8];
	char startaddr[4];
	char endaddr[4];
	char reserved[16];
} ESTHEADER;

main(int argc, char **argv)
{
   FILE *theFile, *newFile;
   int byteCount = 0;
   unsigned char theByte;
   char newFileName[256];
   ESTHEADER newHeader;
   int address,i;

   if(argc != 3)
   {
       fprintf(stderr, "USAGE: bin2bin [filename] [address]\n");
	   exit(1);
   }

   if ( !(theFile = fopen(argv[1], "r")) )
   {
       fprintf(stderr, "Unable to open file %s\n", argv[1]);
	   exit(1);
   }

   while (fread(&theByte, 1, 1, theFile))
       byteCount++;

   fprintf(stdout, "File size: %d\n", byteCount);
   rewind(theFile);

   strcpy(newFileName, argv[1]);
   strcat(newFileName, ".bin");

   if ( !(newFile = fopen(newFileName, "w")) )
   {
       fprintf(stderr, "Unable to open file %s\n", newFileName);
	   exit(1);
   }

   strcpy(newHeader.id, "ESTFBINR");
   address = (int) strtol(argv[2], NULL, 16);
   fprintf(stdout, "Loading to location 0x%08X\n", address);

   newHeader.startaddr[0] = (char) (address >> 24);
   newHeader.startaddr[1] = (char) (address >> 16);
   newHeader.startaddr[2] = (char) (address >> 8);
   newHeader.startaddr[3] = (char) (address);

   address += byteCount;

   newHeader.endaddr[0] = (char) (address >> 24);
   newHeader.endaddr[1] = (char) (address >> 16);
   newHeader.endaddr[2] = (char) (address >> 8);
   newHeader.endaddr[3] = (char) (address);

   for(i=0; i<16; i++)
       newHeader.reserved[i] = 0;

   fwrite(&newHeader, sizeof(newHeader), 1, newFile);

   for(i=0; i<byteCount; i++)
   {
      if (!fread(&theByte, 1, 1, theFile))
	  {
	      fprintf(stderr, "Error reading input file at byte %d\n",i);
		  break;
	  }
	  if (!fwrite(&theByte, 1, 1, newFile))
	  {
	      fprintf(stderr, "Error writing output file at byte %d\n",i);
		  break;
	  }
   }

   fprintf(stdout,"Total bytes copied: %d\n", i);
   fclose(theFile);
   fclose(newFile);

}






--------------5BB9B163679DEE76D035472C--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <381EADDF.EC2B2287@fi.infn.it>
Date: Tue, 02 Nov 1999 10:24:47 +0100
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: Christian Zankel <chris@mvista.com>
CC: Matt Porter <mporter@eng.mcd.mot.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BUGboot 0.2 Patch
References: <19990930134513.C25664@fwrsl-11.phx.mcd.mot.com> <3802668E.C5A6BAC6@fi.infn.it> <19991014094024.A568@fwrsl-11.phx.mcd.mot.com> <3819E280.43C05759@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Christian,
I just tried your patch, it did not worked, but at least something more
seems to happen when I tried the boot.

I repeated all the steps that I already did the previous time. 
PPC4-Bug>nbh 0 0 ,,, res_data
Network Booting from: DEC21143, Controller 0, Device 0
[snip]
Residual-Data Located at: $01F78000
[snip]
PPC4-Bug>md $01F78000
01F78000  00006A0C 0001012C 20202020 20202020  ..j....,

So I have RESDATA_DEST = 01F78000 and RESDATA_SIZE = 6A0C; I put
everything in res_data with:
PPC4-Bug>niop
Controller LUN =00?
Device LUN     =00?
Get/Put        =G? P
File Name      =? res_data
Memory Address =00004000? 01F78000
Length         =00000000? 00006A0C

Bytes Sent     =&27148
Bytes/Second   =&27148, Elapsed Time =1 Second(s)

And thenI put all in bugboot-2.0/:
[root@pcwiz3 bugboot-0.2]# ls -l
-rw-r--r--   1 1000     1000        17992 Aug 31 18:10 COPYING
-rw-r--r--   1 1000     1000          537 Sep 30 22:29 ChangeLog
-rw-r--r--   1 root     1000          794 Nov  2 09:08 Makefile
-rw-r--r--   1 1000     1000         5136 Sep 30 22:42 README
-rwxr-xr-x   1 root     1000       622156 Nov  2 09:06 kernel_image*
-rw-r--r--   1 root     1000         5614 Nov  2 08:13 mkbugboot.c
-rw-r--r--   1 1000     1000          918 Aug 31 18:35 mkchksum.c
-rw-r--r--   1 1000     1000          974 Aug 31 19:04 ppc_asm.tmpl
-rw-r--r--   1 root     1000        27148 Nov  2 09:06 res_data
-rw-r--r--   1 root     1000         1885 Nov  2 09:09 romboot.S
-rw-r--r--   1 root     1000          104 Nov  2 09:11 romboot.bin
-rw-r--r--   1 root     1000          707 Nov  2 09:11 romboot.o

I used the board itself to compile putting the size on Makefile:
ZIMAGE_SIZE=622156
and the RESDATA_DEST and RESDATA_SIZE in bugboot.S:
#define RESDATA_DEST    0x1f78000
#define RESDATA_SIZE    0x6a0c
and then:
[root@vmesez1 bugboot-0.2]# make
bugboot.bin                                    
gcc -o mkbugboot
mkbugboot.c                                                    
gcc -c
\                                                                        
-DKERNEL_IMAGE=`wc -c <kernel_image | sed "s: ::g"`
\                           
-o romboot.o
romboot.S                                                          
objcopy --output-target=binary romboot.o
romboot.bin                            
./mkbugboot romboot.bin kernel_image res_data
bugboot.bin                       
Checksum =
0xa98                                                                

Then I restarted, get the file and put it in flash:
PPC4-Bug>niop                                                                   
Controller LUN
=00?                                                             
Device LUN    
=00?                                                             
Get/Put       
=G?                                                              
File Name     
=bugboot.bin?                                                    
Memory Address
=00004000?                                                       
Length        
=00000000?                                                       
Byte Offset   
=00000000?                                                       
                                                                                
Bytes Received =&649562, Bytes Loaded
=&649562                                  
Bytes/Second   =&324781, Elapsed Time =2
Second(s)                              

PPC4-Bug>pflash 4000:100000
ff000000                                            
Source Starting/Ending Addresses     
=00004000/00103FFF                        
Destination Starting/Ending Addresses
=FF000000/FF0FFFFF                        
Number of Effective Bytes             =00100000
(&1048576)                      
                                                                                
Program FLASH Memory (Y/N)?
y                                                   
Virtual-Device-Number   
=00                                                    
Manufacturer-Identifier 
=10001                                                 
Device-Identifier       
=22C422C4                                              
Virtual-Device-Number   
=01                                                    
Manufacturer-Identifier 
=10001                                                 
Device-Identifier       
=22C422C4                                              
Address-Mask            
=FF800000                                              
Erasing sector    
=$FF000000                                                   
Erasing sector    
=$FF040000                                                   
Erasing sector    
=$FF080000                                                   
Erasing sector    
=$FF0C0000                                                   
Programming sector
=$FF000000                                                   
Programming sector
=$FF040000                                                   
Programming sector
=$FF080000                                                   
Programming sector
=$FF0C0000                                                   
FLASH Memory Programming
Complete                                               
PPC4-Bug>env                                                                    
[snip]
ROM Boot Direct Starting Address =
FF000000?                                    
ROM Boot Direct Ending Address   =
FF000100?                                    
Network Auto Boot Enable [Y/N]           = N?
.                                 

But when I give the bot command what I get is:
PPC4-Bug>rb
;v                                                                  
                                                                                
ROMBoot about to Begin... Press <ESC> to Bypass, <SPC> to
Continue              
                                                                                
Direct Adr: FF000000 FF000100: Searching for ROMboot Module at:
FF000100        
ROM       : FF000104 FF7FFFFC: Searching for ROMboot Module at:
FF7FFFFC        
Local RAM : 00000000 01FFFFFC: Searching for ROMboot Module at: 00004000

it seems to look up to the end of the flash memory then hangs.
As in the previuos time I have in memory:
PPC4-Bug>md
ff000000:100                                                        
FF000000  424F4F54 14000000 5AE90900 4C494E55  BOOT....Z...LINU  
                   ^^^^     ^^^^
		this seems an endianess problem!!           
FF000010  58524F4D 3D20FF00 612900FC 3D600002  XROM=
..a)..=`..                 
FF000020  616B5F93 3D800000 618C4FFC 7D6903A6 
ak_.=...a.O.}i..                 
FF000030  85690004 956C0004 4200FFF8 3D20FF09  .i...l..B...=
..                 
FF000040  61297F48 3D600000 616B1A83 3D8001F7 
a).H=`..ak..=...                 
FF000050  618C7FFC 7D6903A6 85690004 956C0004 
a...}i...i...l..                 
FF000060  4200FFF8 3C6001F7 60638000 3DC00000 
B...<`..`c..=...                 
FF000070  61CE5400 7DC803A6 4E800020 00000000  a.T.}...N..
....                 
[all 00]
FF000100  48000400 00000000 00000000 00000000 
H...............                 
[all 00]
FF0002C0  02004101 124F0000 0000C004 00000000 
..A..O..........                 
FF0002D0  00000000 00000000 00000000 00000000 
................                 
FF0002E0  00000000 00000000 00000000 00000000 
................                 
FF0002F0  00000000 00000000 00000000 000055AA 
..............U.                 
FF000300  00040000 4C7E0900 00004C69 6E757800 
....L~....Linux.                 
FF000310  00000000 00000000 00000000 00000000 
................                 
[all 00]
FF000500  48000005 7C2802A6 38000000 9401FD8C 
H...|(..8.......                 
FF000510  BF410008 48000005 7FC802A6 801E0358 
.A..H..........X                 
[...]

Hi, and thanks for the help.
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

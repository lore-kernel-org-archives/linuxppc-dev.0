Message-ID: <37D3D77E.D22665E2@fi.infn.it>
Date: Mon, 06 Sep 1999 17:02:22 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: A question about zImage when booting from HD
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, 
after some time, I'm retrying to boot my board (a MVME2431) from the HD,
but still I have to use NFS. I partitioned the HD as:

Disk /dev/sda: 64 heads, 32 sectors, 8683
cylinders                             
Units = cylinders of 2048 * 512
bytes                                           
                                                                                
   Device Boot    Start       End    Blocks   Id 
System                        
/dev/sda1             1      8620   8826864   83 
Linux                         
/dev/sda2          8621      8680     61440   82  Linux
swap                    
/dev/sda3   *      8681      8683      3072   41  PPC PReP
Boot                 

then I create an image (make zImage) that is normally working when
booted by NFS (could be this the problem? there are some option to set
during the kernel compilation?) and copied it to /dev/sda3 using dd.

But when i tried to boot from the HD I obtain this:
PPC4-Bug>ioi                                                                    
I/O Inquiry
Status:                                                             
CLUN  DLUN  CNTRL-TYPE  DADDR  DTYPE  RM 
Inquiry-Data                          
   1     0  PC8477      0      $00    Y  
<None>                                
  10    50  NCR53C825   5      $00    N   SEAGATE  ST39140W        
1487        
PPC4-Bug>pboot 10 50
0                                                          
Booting from: NCR53C825, Controller 10, Drive
50                                
Device Name :
/pci@80000000/pci1000,3@10,0/harddisk@5,0                         
Loading: Operating
System                                                       
                                                                                
IPL Size Exceeds Free-Available
Memory:                                         
IPL Size              =AC444000
(&-1404813312)                                  
Free-Available Memory =01F74000
(&32980992)                                     

I looked both in /dev/sda3 and in
/usr/src/linux/arch/ppc/prepboot/zImage and what I get is (the results
were the same):

[root@vmesez1 /root]# od -N 10000 -Ad -tx /dev/sda3
0000000 48000400 00000000 00000000 00000000
0000016 00000000 00000000 00000000 00000000
*
0000432 00000000 00000000 00000000 00008000
0000448 02004101 124f0000 0000b004 00000000
0000464 00000000 00000000 00000000 00000000
*
0000496 00000000 00000000 00000000 000055aa 
0000512 00040000 6c5f0900 00004c69 6e757800
0000528 00000000 00000000 00000000 00000000
* 
0001024 48000005 7c2802a6 38000000 9401fd8c 
0001040 bf410008 48000005 7fc802a6 801e0358
...

and I cannot figure from where I get this IPL Size =AC444000. If I
understand right what is written in the PPCBug manual it seems that the
code start at 1024 (byte 512), and the lenght is 0x095f6c (byte 516),
nothing related to AC444000; I'm missing something in the partion? Or
I'm using a wrong image?

Thanks
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

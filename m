Message-ID: <374D8E2A.48871830@wanadoo.fr>
Date: Thu, 27 May 1999 20:25:46 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems with vger 2.3.3/4
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On my 6400/200, the 2.3.3 (now 2.3.4) kernel from the vger tree has
problems that started last Sunday:

The sources checked out on May 21 give a kernel that runs perfectly, but
starting from updates on May 22 and until right now, two problems showed
up whose origin I could not identify, although I spent time staring at
source files and cvs logs and trying things:

The first one is related to the IDE driver. At boot time, in the
partition check section, it gives me
   kernel: Partition
check:                                                      
   kernel:  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9
sda10              
   kernel:  sdb: sdb1 sdb2
sdb3                                                  
   kernel:  hda:hda: timeout waiting for
DMA                                     
   kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete
DataRequest } 
   kernel: hda: DMA
disabled                                                     
   kernel: ide0: reset:
success                                                  
   atd: atd startup
succeeded                                                    
   kernel:  hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11
hda12 hda13   
   kernel: VFS: Mounted root (ext2 filesystem) readonly. 
With the May 21 kernel, I get only, like always before,
   kernel: Partition
check:                                                           
   kernel:  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9
sda10                   
   kernel:  sdb: sdb1 sdb2
sdb3                                                       
   kernel:  hda: hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10
hda11 hda12 hda13    
   kernel: VFS: Mounted root (ext2 filesystem) readonly. 
The effect of this is that the HD is slower with the newer kernel: I use
hdparm -p /dev/hda to tune it and usually get 4.35 MB/sec instead of
1.88 MB/sec. With the new kernel, it stays at 1.88 MB/sec, whatever I
try.

The second problem: I have a one-line script in /etc/rc.d that
initializes the printer port:
   stty raw 57600 crtscts -echo < /dev/ttyS1
With the new kernel, the boot process hangs while trying to execute this
script, and I have to do a hard reboot. If I comment this line out, the
boot process succeeds. Afterwards, I can execute the script manually
without problem.

Any ideas?

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

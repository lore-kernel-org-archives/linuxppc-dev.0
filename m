Date: Mon, 6 Sep 1999 11:24:01 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Hank De Gregorio <hcd1@acpub.duke.edu>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: SCSI host detected, but not the drive
In-Reply-To: <Pine.SOL.3.91.990903172713.439A-100000@godzilla6.acpub.duke.edu>
Message-ID: <Pine.HPX.4.10.9909061009270.9440-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



	Hi,

For MVME people, I have set up a few files  on my server (vlab1.iram.es) a
couple of files which you might find useful: 

 zImage.nfsinstall-2.2.11
 mini-nfsroot.tgz

(although the 'mini' prefix is optimistic). It gives you a minimal
filesystem from which you can boot and will find boot into a shell.

Then you can remount you root file system rw, and start installing all
the rpms your need from LinuxPPC release 5 (not R4 please)! On the server,
you first have to pull the RPMS from an R5 mirror into
/mini-nfsroot/usr/src/redhat/... for example

I know at least one person who has already used it so setup his system.
The image can also be copied verbatim with cp -a onto an already
partitioned SCSI disk (I forgot to add fdisk/cfdisk to the mini-nfsroot).

However, note that I'm right now upgrading the server to LinuxPPC-R5 so it
might not be permanently online during the next few days. 

This is the list of rpms I have added to get a usable system (probably not
all are necessary):

rootfiles-5.2-5                                                                 
etcskel-2.0-1                                                                   
findutils-4.1-31                                                                
SysVinit-2.74-11                                                                
gzip-1.2.4-14                                                                   
tcp_wrappers-7.6-7                                                              
netkit-base-0.10-29a                                                            
telnet-0.10-27                                                                  
net-tools-1.52-1                                                                
slang-1.2.2-4                                                                   
util-linux-2.9o-13b     conficts with bash on a man page, use --force.  
rmt-0.4b4-7                                                                     
tar-1.12-9                                                                      
MAKEDEV-2.5-1                                                                   
less-340-1                                                                      
bzip2-0.9.0c-1                                                                  
ftp-0.10-22                                                                     
libstdc++-2.9.0-12c     }
gdbm-1.7.3-19           }
tcsh-6.08.00-5a         } These 5 packages are needed by man !
perl-5.00503-2          }
groff-1.11a-9           }
man-1.5g-2                                                                      
newt-0.40-9                                                                     
timeconfig-2.7-1                                                                
tmpwatch-1.7-1                                                                  
crontabs-1.7-6                                                                  
utempter-0.5-1                                                                  
pciutils-1.99.5-2                                                               
readline-2.2.1-5                                                                
python-1.5.1-10                                                                 
pythonlib-1.22-5                                                                
glint-2.6.2-1a                                                                  
gd-1.3-5                                                                        
procinfo-16-3                                                                   
psmisc-18-2                                                                     
time-1.7-9                                                                      
byacc-1.9-11                                                                    
m4-1.4-12                                                                       
autoconf-2.13-5                                                                 
automake-1.4-4                                                                  
binutils-2.9.1.0.990418-1c                                                      
bison-1.27-3                                                                    
diffstat-1.25-7                                                                 
diffutils-2.7-16                                                                
bash-doc-2.03-3a                                                                
man-pages-1.23-3                                                                
rhl-install-guide-en-6.0-2      To make installs easier next time ?
texinfo-3.12f-4                                                                 
vim-common-5.3-7                                                                
vim-minimal-5.3-7               Because it runs from /bin.
kbdconfig-1.9.2-1a              I have a Spanish keyboard !
passwd-0.58-1                   Install this.
authconfig-1.8-1                Install and run to use shadow passwords.
getty_ps-2.0.7j-7               Needed for serial console.
ntsysv-1.0.6-1
timetool-2.5-5                  Actually useless, clock is designed for PMACs
bind-utils-8.2-6
 
After this you'all at least have to change your initdefault to 3 in
/etc/fstab. You'll have other problems too but I forgot to write down
other steps while installing this system :-(.

Note that you can also edit files only from the server on nfsroot systems. 
Actually I plan to build minimal nfsroot systemns for farms of VME crates
used for data acquisition in a radiotelescope. But it's still a few weeks
in the future. 


	Regards,
	Gabriel.

On Fri, 3 Sep 1999, Hank De Gregorio wrote:

> 
> i am installing linuxppc-r4 with the redhat installer.
> 
> i get this message (and subsequently a frozen screen) *after* i have 
> chosen my root password and clicked ok to reboot:
> 
> VFS: Mounted root (ext2 filesystem) readonly.
> change_root: old root has d_count=2
> Trying to unmount old root ... <3>error -16
> Change root to /initrd: error -2
> Freeing unused kernel memory: 88k init 4k pmac 8k open firmware
> tty_io.c: process 1 (swapper) used obsolete /dev/cua1 - update software 
> to use /
> dev/ttyS1
> tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
> use /dev
> /ttyS1
> tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
> use /dev
> /ttyS1
> tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
> use /dev
> /ttyS1
> tty_io.c: process 1 (init) used obsolete /dev/cua1 - update software to 
> use /dev
> /ttyS1
> 
> does anyone have a clue what's going on with my system?
> 
> hank
> 
> 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

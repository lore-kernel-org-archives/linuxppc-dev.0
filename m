Message-Id: <199812161805.TAA14779@kieray1>
Date: Wed, 16 Dec 1998 19:05:31 +0100 (MET)
From: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Reply-To: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Subject: Re: Problems starting up system on a MPC823FADS
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>I try to get a linux system up and running on a Motorola MPC823FADS
 
I'm currently running linux on MPC860ADS and the MBX.

MBX: 
Works fine. 
I've succeeded loading linux from my floppydrive (yea!) and via ethernet. 

MPC860ADS:
I use MPC8BUG to set up some registers and load vmlinux.
today it runs linux from initrd. I've mounted nfs and it works fine.
But nfs as root doesn't.

I added some debug printouts to open() and nfs read() and compared 
nfs with initrd.

initrd:

VFS: Mounted root (ext2 filesystem).
open file '/dev/console' returns 0x00000000
open file '/etc/ld.so.preload' returns 0xfffffffe
open file '/etc/ld.so.cache' returns 0xfffffffe
open file '/lib/libtermcap.so.2' returns 0x00000003
open file '/lib/libc.so.6' returns 0x00000003
open file '/etc/nsswitch.conf' returns 0xfffffffe
open file '/lib/libnss_compat.so.1' returns 0xfffffffe
open file '/usr/lib/libnss_compat.so.1' returns 0xfffffffe
open file '/lib/libnss_files.so.1' returns 0xfffffffe
open file '/usr/lib/libnss_files.so.1' returns 0xfffffffe
open file '//.bashrc' returns 0xfffffffe
open file '//.bash_history' returns 0xfffffffe
open file '/etc/termcap' returns 0xfffffffe
bash#

nfs:

VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 36k init 28k prep
open file '/dev/console' returns 0x00000000
nfs: read(bin/sh, 128@0)
nfs: read(bin/sh, 160@52)
nfs: read(bin/sh, 13@244)
nfs: read(lib/ld.so.1, 128@0)
nfs: read(lib/ld.so.1, 96@52)
open file '/etc/ld.so.preload' returns 0xfffffffe
open file '/etc/ld.so.cache' returns 0xfffffffe
open file '/lib/libtermcap.so.2' returns 0x00000003
open file '/lib/libc.so.6' returns 0x00000003
open file '/etc/nsswitch.conf' returns 0xfffffffe
open file '/lib/libnss_compat.so.1' returns 0xfffffffe
open file '/usr/lib/libnss_compat.so.1' returns 0xfffffffe
open file '/lib/libnss_files.so.1' returns 0xfffffffe
open file '/usr/lib/libnss_files.so.1' returns 0xfffffffe
open file '' returns 0xfffffffe
open file '/usr/local/bin/' returns 0x00000003
reading 80 bytes from handle 0x00000003 - returned 4294967275
reading 1024 bytes from handle 0x00000003 - returned 4294967275

[nothing more]

>I switched from gcc-2.8.1 to egcs-1.1b as a cross compiler (x86 -->
>PPC), but without any success. 

I think I've got the same problem as you have.

I use egcs-2.91.57. It generates code that works on my MBX-board.

I've read the mbx-documentation several times, and I don't think
it tells us everything about the register-setups.

My guess is that our boot-code/script doesn't initialize everything.
Or the ethernetdriver assumes more than the ethernetaddress.

>Probably one of you can give me even the slightest hint, 
>how I could get any futher!

I suppose you've setup DER, ICR and ICTRL correctly?

I know that Dan Malek has got boot-code for the FADS, right Dan?

Another thing:

There seem to be quit a lot of people around hacking embedded linux.

Why not create a board.h file?

board.h:

#if defined(CONFIG_MBX)
#include <mbx.h>
#elif defined(CONFIG_FADS)
#include <fads.h>
#elif defined(CONFIG_ADS)
#include <ads.h>
#else
#error "No board"
#endif

Cheers /

Magnus


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

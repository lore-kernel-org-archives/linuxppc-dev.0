Date: Sun, 28 Mar 1999 18:24:43 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Samba and shared mem trouble
Message-ID: <Pine.LNX.4.04.9903281816160.17542-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


samba 2.0.3 seems not to work on glibc-2.1 and kernel 2.2.4 vger.

This appears to be related to shared memory somehow.. Does anyone have
any ideas on what's going on? I'd like to have some suggestions on where
to look before I go off on a wild goose chase bug hunt.

FYI, I patched the maximum shared memory size in shmparam.h from the
original (small) value to
#define SHMMAX 0x1000000
so that cdrecord would be happy. Is there a reason this is still so small?

Following are the errors that occur startup and when I try to connect to
the server using smbclient.

[1999/03/28 17:42:03, 1] smbd/server.c:main(614)
  smbd version 2.0.3 started.
  Copyright Andrew Tridgell 1992-1998
[1999/03/28 17:42:03, 0] printing/pcap.c:pcap_printer_fn(349)
  Unable to open printcap file /etc/printcap for read!
[1999/03/28 17:42:03, 1] smbd/files.c:file_init(219)
  file_init: Information only: requested 10000 open files, 1014 are
available.
[1999/03/28 17:42:33, 0] locking/shmem.c:smb_shm_open(930)
  ERROR smb_shm_open : mmap failed with code Invalid argument
[1999/03/28 17:42:33, 0] locking/locking.c:locking_init(169)
  ERROR: Failed to initialise share modes!
[1999/03/28 17:42:33, 0] locking/shmem.c:smb_shm_open(930)
  ERROR smb_shm_open : mmap failed with code Invalid argument
[1999/03/28 17:42:33, 0] locking/locking.c:locking_init(169)
  ERROR: Failed to initialise share modes!  


(smbstatus also doesn't work...)

[root@altus samba]# smbstatus
Couldn't open status file /var/lock/samba/STATUS..LCK 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]

Message-Id: <m0zsJO4-001C3VC@shell.rmi.net>
From: tph@rmi.net (Tom Harrington)
Subject: mousemode.c ADB Reset patch
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 21 Dec 1998 21:25:35 -0700 (MST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Below is a patch for mousemode.c that I hacked up.  It adds an "ADB
reset" option to the code.  I don't know if it's useful to anyone
not hacking ADB code (and occasionally causing devices to stop responding),
but feel free to use it if you like it.

What happens is, if you do "mousemode -1", the address is caught.  Rather
than try to use the address, the new reset_adb() function is called.

Tom Harrington

--- Cut here ---
5a6,9
>  * ADB Reset option added by Tom Harrington (tph@rmi.net).  Also changed
>  * "asm/adb.h" to "asm/adb_mouse.h", which seems to be necessary with
>  * LinuxPPC R4.
>  *
18c22,23
< #include <asm/adb.h>
---
> /*#include <asm/adb.h>*/
> #include <asm/adb_mouse.h>
109a115,131
> void
> reset_adb(void) 
> {
>       /* I don't know if this'll be useful to anyone not hacking ADB code, but you never know. */
>       unsigned char y[15];
>       y[0] = ADB_PACKET;
>       y[1] = ADB_BUSRESET;
>       send(y,2);
>       listen(y);
> 
>       /* My Apple Extended Keyboard II needs flushing after a reset or it'll start sending repeated CRs.
>        * Don't know if this is universal, or even common, but it shouldn't hurt. (tph@rmi.net)  */
>       y[1] = ADB_FLUSH(2);
>       send(y,2);
>       listen(y);
> }
> 
120a143
>       printf(" With addr=-1 and no handler, reset the ADB chain.\n");
136a160,163
>     } else if(addr == -1) {
>         /* Send a reset */
>       printf("Resetting ADB chain\n");
>       reset_adb();
--- Cut here ---


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

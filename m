Date: Tue, 22 Dec 1998 23:08:05 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
cc: apenwarr@foxnet.net, eric@aib.com
Subject: workaround for broken 'make xconfig' on ppc
Message-ID: <Pine.LNX.4.04.9812222301100.28200-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After using make xconfig on i386 earlier today, I finally decided to
figure out why it's broke on PPC. I found that there's something not
working right in scripts/tkgen.c where 'global CONFIG_SOUND' isn't being
put into the tk script in the 'update_mainmenu' function.

This cause the script to bomb with a 'can't find variable $CONFIG_SOUND'
error.

This doesn't show up on i386 since CONFIG_SOUND isn't the last item, like
it is on PPC.

By adding the following to linux/arch/ppc/, make xconfig now works:

-----

mainmenu_option next_comment
comment 'make Xconfig is broken'
bool 'Xconfig is broken' CONFIG_BROKEN_XCONFIG
endmenu  

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]

From: "G. Guével" <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: MMU problems on MPC860P
Date: Fri, 15 Sep 2000 18:40:09 +0200
Message-ID: <000101c01f33$a5f58ca0$2901a8c0@none>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a MBX MPC860 board and a montavista linux kernel 2.2.13 which works
very well.

I want to port this kernel on a MPC860P proprietary board called pLines.
I can execute my kernel init until the last execve command which launches
the sh command.
I can get my ip address from a bootp server and mount a network file system.

When the execve is run the following functions are called :
do_load_elf_binary - flush_old_exec - exec_mmap - new_page_tables -
SET_PAGE_DIR
This last function calls an asm instruction, ie "mtspr M_TWB 1DF00".
On the MBX board it is "mtspr M_TWB 1DE00".

This instruction sets the tablewalk level one base value.

If I comment this instruction, I can have the ash application which crashes
when calling other applications.
If I uncomment this instruction I have nothing.

If I add an infinitely printk loop after the mtspr, printk works during 2 to
3 s then cpu crashes.
But printk seems not to be sure while page manipulation.

Any help on this subject will be welcome.

Thanks to all
Sorry for my poor english language, je suis français.

Bye
Gerard Guevel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

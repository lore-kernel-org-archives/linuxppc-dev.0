Mime-Version: 1.0
Message-Id: <p05100300b8c18bf409e9@[66.26.75.241]>
Date: Fri, 22 Mar 2002 20:43:32 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: 2.4.19pre4 boot crash
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


6500 again, only change on default config is to make tulip a module.

During boot, I get a crash during the setting of the Linux keycodes.
The only mon trace I can get is:

pc=c01b39f0, lr = c01b4690
msr = 9032, sp = c5de5da0 [c5de5cf0]
dsr = ffffffed. Dsisr =  20000000
current = c5de4000, pid = 34, comm = grep

I note that there is a line in setting the keycodes:

	if grep -i "MacRISC" /proc/cpuinfo >/dev/null; then

which is where it must be crashing, but I can't think of why...

System.map-2.4.19pre4 snippets:

c011aefc t vgacon_font_op
c011b018 t vgacon_scrolldelta
c011b1b0 t vgacon_set_origin
c011b278 t vgacon_save_screen
c011b2e8 t vgacon_scroll
c011b5b0 t vgacon_dummy
c011b5b8 t fbmem_read_proc
c011b6b4 t fb_read
c011b830 t fb_write
c011b9b8 t try_to_load


System.map has nothing near as high as the c5dexxxx addresses.



Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

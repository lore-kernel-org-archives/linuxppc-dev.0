From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.19pre4 boot crash
Date: Sun, 24 Mar 2002 13:28:27 +0100
Message-Id: <20020324122827.27423@smtp.wanadoo.fr>
In-Reply-To: <p05100300b8c18bf409e9@[66.26.75.241]>
References: <p05100300b8c18bf409e9@[66.26.75.241]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>During boot, I get a crash during the setting of the Linux keycodes.
>The only mon trace I can get is:
>
>pc=c01b39f0, lr = c01b4690
>msr = 9032, sp = c5de5da0 [c5de5cf0]
>dsr = ffffffed. Dsisr =  20000000
>current = c5de4000, pid = 34, comm = grep

Yes, there is something wrong with pmac /proc/cpuinfo code, I'm
looking into it.
Could actually be "mbname" NULL in pmac_show_cpuinfo, try eventually
adding if (mbname == NULL) mbname = "Unknown"; in it.

>I note that there is a line in setting the keycodes:
>
>	if grep -i "MacRISC" /proc/cpuinfo >/dev/null; then
>
>which is where it must be crashing, but I can't think of why...
>
>System.map-2.4.19pre4 snippets:

Look for c01bxxx not c011bxx ...

>c011aefc t vgacon_font_o
>c011b018 t vgacon_scrolldelta
>c011b1b0 t vgacon_set_origin
>c011b278 t vgacon_save_screen
>c011b2e8 t vgacon_scroll
>c011b5b0 t vgacon_dummy
>c011b5b8 t fbmem_read_proc
>c011b6b4 t fb_read
>c011b830 t fb_write
>c011b9b8 t try_to_load


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

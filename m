Message-ID: <016f01c034ef$3cf52220$0a00010a@airvent.it>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: outb_p(0xc, 0x3f2) with _IO_BASE remapped!
Date: Fri, 13 Oct 2000 10:26:07 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I discovered that my kernel hangs into 'drivers/block/ll_rw_blk.c', in
function 'blk_dev_init', at the instruction outb_p(0xc, 0x3f2), if i remap
_IO_BASE to 0xfe0000000 (to use m8xx_pcmcia).

I think that this instruction simply wrote something to the memory (if
_IO_BASE was 0 and wasn't ioremapped), but now it shouldn't do nothing
(nothing is at that address).

But why is it needed? What is supposed to do that instruction? Why not
writing that value to the memory instead of using outb_p instruction?

This is really a problem to me... i need to remap _IO_BASE to use
m8xx_pcmcia!

- may the pinguin b with u -

Have a nice day,
Paolo Scaffardi.
AIRVENT SAM s.p.a. - RIMINI - ITALY


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

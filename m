Message-ID: <B164B53F5BD6D511888D009027732E1A02498D@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: BDI2000 PTEs
Date: Wed, 28 Nov 2001 14:49:32 +1100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all

I am trying to do module debugging. Module is loaded atvirtual address
0xC500004C. At the moment I have memory translation enabled in BDI2000.
PTBASE is set to 0xf0 and this entry is cleared. This works for kernel
debugging, but memory translation fails when I try to do dynamically loaded
module debugging.
I guess I have to set PTE pointers for BDI2000.

First I put value 0xC00000F4 into physical address 0xF0 (BDI2000 PTBASE).

>From Linux Jernel Book, I understood that PTE pointer is at variable called
"swapper_pg_dir". I tried to write its address into BDI2000 PTE kernel
pointer (physical address 0xF4).

Does not work.
I think that PTEs have to updated dynamically, but I have no ideas where to
get them from.

Can anyone explain how to get the values for the PTE kernel and user
pointers?

I am using kernel 2.4.4. I looked at the later kernels that have BDI2000
support. Unfortunately, support is only 8xx CPUs, not 8260. (I looked into
files /arch/ppc/head.S. and /arch/ppc/head_8xx.S). It is difficult for me to
update corresponding 8260 code mainly because I am not sure what this code
does and I am not very familiar with PPC assembly.

Any help is appreciated,
Thanks.

Rudolf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

Message-ID: <389092CE.60034142@pop.agri.ch>
Date: Thu, 27 Jan 2000 19:47:45 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Backtrace interpretation?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
finally I managed to get my kernel backtrace out of the box into a file.
--> serial_console

Now I have some basic question how to interpret the log.

are there limitations or other topics I have to pay attention to?
- e.g. ix86 vs. ppc
- little/big endian
can I operate with ksyms or nm without any problems(topics above)

For example the log below:

---
Caused by (from msr): regs c4db77f0 Unknown values in msr
NIP: C83363F8 XER: 00000000 LR: C83363E4 REGS: c4db77f0 TRAP: 0200
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c4db6000[467] 'cardmgr' mm->pgd c4db5000 Last syscall: 54
last math 00000000
GPR00: C83363E4 C4DB78A0 C4DB6000 FFFFFFFF 00000001 C01E8180 C01B0000 C01B0000
GPR08: C01B0000 00000000 000010F6 C4DB77E0 24242422 10021974 00000001 00000000
GPR16: 00000000 00000001 FFFFFFFF 00000016 00009032 0000000E 00000000 C0003B78
GPR24: C51EAB60 1002C7B0 00000000 00000000 00000001 C01B0000 C5D22800 00000118
Entering xmon kernel debugger.
Unable to handle kernel paging request at virtual address efcf0000
(error 42000000)
NIP: C01D2264 XER: 00000000 LR: C01D21E0 REGS: c4db7500 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c4db6000[467] 'cardmgr' mm->pgd c4db5000 Last syscall: 54
last math 00000000
GPR00: 00000000 C4DB75B0 C4DB6000 C0236000 FFFFFFFF 00000000 00000000 00000000
GPR08: 00000000 00000000 00000000 00000000 C4DB75A8 10021974 00000001 00000000
GPR16: 00000000 00000001 FFFFFFFF 00000016 00001032 04DB77E0 00000000 C0003B78
GPR24: 00000000 FFFFFFFF 00000000 00000000 C01D2A30 C0236000 C01D2A31 EFCF0000
---
The log continues, I only snipped the first two entries to find out if I
understand it correct.

- the NIP: C83363F8 is this the address of my break?
if so, I can find out which part, in my case a module, is responsible for.
When I do ksyms -m | sort, I get a module name with an address lower
than my NIP. From here I try to find out the offset where my module is
loaded, when I got it I can now try to find which function is the
responsible with 'nm module.o | sort'

Is this more or less correct or am I totally wrong? I have neither
experience on ix86 nor on ppc interpreting backlogs. I try to follow
some ix86 dbg techniques.

Are there other interpreting techniques?
The bad thing is, my machine blocks totally and I can't interpret the
bug just after the crash, I have to reboot first.

Any lights and hints would be great

Thanks a lot

Andreas
--
| Andreas Tobler
| CH-8004 Zuerich
| E-Mail:   a.tobler@schweiz.ch
-----------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

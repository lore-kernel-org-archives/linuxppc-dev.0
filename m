From: Ruedi.Hofer@ascom.ch
Date: Thu, 09 Dec 1999 11:06:48 +0100 (CET)
Subject: fadsrom -> mkrombin
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FMG00K37XFTD5@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_3pAdkIEiiU5H78nvp/QEqw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_3pAdkIEiiU5H78nvp/QEqw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

After some little changes I'm now able to compile fadsrom.

(I had to define __fswab16, __fswab32 and ffz)



Next problem: mkrombin doesn't work. It fails with an output message of

"something wrong with file fadsrom" in line 63

I compiled mkrombin with debug options and had a look why it fails.

It expects a value of 2 for nscns but it gets:

(gdb) print nscns
$3 = 512
(gdb) 

whereas nscns is basically a copy of ehp->e_phnum

(gdb) print *ehp
$1 = {e_ident = "\177ELF\001\002\001\000\000\000\000\000\000\000\000", 
e_type = 512, e_machine = 5120, e_version = 16777216, e_entry = 254, 
e_phoff = 872415232, e_shoff = 3837985280, e_flags = 0, e_ehsize = 13312, 
e_phentsize = 8192, e_phnum = 512, e_shentsize = 10240, e_shnum = 2560, 
e_shstrndx = 1792}
(gdb) 



Any ideas? Is cross-"mkrombin" a problem? (We develop on Intel)

Ruedi


--Boundary_(ID_3pAdkIEiiU5H78nvp/QEqw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

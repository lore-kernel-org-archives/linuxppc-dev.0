Date: Tue,  1 Jun 2004 14:26:07 +0200
Message-Id: <HYMQJJ$DB139D8346BA71079DA28B09963E10CA@scarlet.be>
Subject: PPC601 MQ patch
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_=__=_XaM3_.1086092767.2A.358336.42.9024.52.42.007.1759519632"
From: "Stef Simoens" <stef.simoens@pi.be>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--_=__=_XaM3_.1086092767.2A.358336.42.9024.52.42.007.1759519632
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I wanted to use gcc's -mcpu=3D601 to optimize code for my processor; I no=
ticed the code had problems with certain instructions (the ones which use=
 the POWER MQ register).

With some help of benh I'd like to share this patch. Unlike benh asked, i=
t is still for 2.4 (I will provide the 2.6 patch as soon I'm sure it work=
s as expected).

I used the assembler 'hiding' techniques as used for VRSAVE, to know wher=
e to save/restore MQ I looked where the XER register was saved/restored..=
.

ppc-stub.c is used for debugging. I added MQ, but I didn't test this. Esp=
ecially, I don't know if my changes interfere with other machines (includ=
e/asm-ppc/ptrace.h states mq is used to hold IPL on APUS)
Also note, I didn't enable CONFIG_PPC601_SYNC_FIX while testing (my machi=
ne doesn't appear to need it...)

Files changed:
 arch/ppc/config.in
	- rearrange PPC601 options
	- CONFIG_PPC601_MQ configure option
 arch/ppc/kernel/cputable.cx
	- add CPU_FTR_MQ to 601 features
 arch/ppc/kernel/entry.S
	- saving and restoring of MQ register
 arch/ppc/kernel/head.S
	- saving of MQ register
 arch/ppc/kernel/ppc-stub.c
	- we use mq now :)
 arch/ppc/kernel/process.c
	- show the MQ register
 Documentation/Configure.help
	- document CONFIG_PPC601_MQ
 include/asm-ppc/cputable.h
	- define CPU_FTR_MQ
 include/asm-ppc/processor.h
	- define SPRN_MQ
 include/asm-ppc/ptrace.h
	- delete the '(not used at present)' comment
=0A=0A---------------------------------------------------------=0AWith Sc=
arlet ADSL your upload speed could reach 384 Kbits=0AMore info at http://=
www.scarlet.be/nl/consumer/adsl/
--_=__=_XaM3_.1086092767.2A.358336.42.9024.52.42.007.1759519632
Content-Type: application/x-gzip-compressed;
	name="=?iso-8859-1?Q?linux-2.4.26-mq.diff.gz?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="=?iso-8859-1?Q?linux-2.4.26-mq.diff.gz?="

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
b9ijCZFB/pP9L1I04DdmHwAA

--_=__=_XaM3_.1086092767.2A.358336.42.9024.52.42.007.1759519632--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

From: "Alan Wang" <wung_y@sina.com>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem when read internal memory
Date: Thu, 12 Apr 2001 09:39:14 +0800
Message-ID: <GEEHLABKDEENGODIMGHAEEGNCAAA.wung_y@sina.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daris,
  thank you for ur suggestion. yes, i have the loader set the IMMR as 0xff000000 too.
and i don't think the machine check exception is caused by TLB problem. If the tlb
entry mapping internal memory doesn't exist, it's a data tlb missing exception. If the
operation violates the storage protection, i think a tlb error exception should be
generated.
  i found that when access a physical addr that doesn't exist will cause a MC exception.
some other reasons to cause MC are in term of bus error. and more? Thx.

A.W.



-----Original Message-----
From: Daris A Nevil [mailto:dnevil@snmc.com]
Sent: Thursday, April 12, 2001 1:07 AM
To: Alan Wang
Cc: Linuxppc-EmbeddedMaillist
Subject: Re: problem when read internal memory


Alan,

It sounds as though you have already changed the value of IMAP_ADDR in
the header file for your specific board (found in linux/include/asm).
You must also make sure that your processor's boot code sets the IMMR
register to this same value before booting the Linux kernel.  Your boot
code should also setup an MMU entry for the IMMR's address by writing to
the MD_EPN register (MMU Data Effective Page Number Reg) of the PPC.
For an example of how this is done you can refer to the boot code for
the QS850 (MPC850-based board).  The source is located at
ftp://qslinux.org.  Once you uncompress the tarball you can go to
snmc/qslinux/qs850boot and view the file init_qs850.s.  Hope this helps.

Regards,
Daris Nevil
SNMC

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

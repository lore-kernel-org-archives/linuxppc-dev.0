Message-Id: <200001101455.JAA10125@hoover.gilbarco.com>
From: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Patch for qspan_pci.c problem with GCC 2.95.2
Date: Mon, 10 Jan 2000 09:55:44 -0500
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Anyone trying to build in pci support to the kernel using GCC 2.95.2 may
find this patch helpful.

It seems that in the inline-assembly in qspan_pci.c the compiler doesn't
recognize that the first argument to the assembly may be modified.  This
resulted in a register getting trashed where it shouldn't have.  To fix the
problem I modified the in-line assembly to tell the compiler that this
register has been changed.

86c86
<               : "=r"(x) : "r"(addr) : "%0")
---
>               : "=r"(x) : "r"(addr))

Jason <jwohlgem@mindspring.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/

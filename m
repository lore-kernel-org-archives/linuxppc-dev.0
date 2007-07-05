Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0540DDDEB6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 07:55:40 +1000 (EST)
Message-ID: <468D68D4.4050704@freescale.com>
Date: Thu, 05 Jul 2007 16:55:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: Executing from readablee, no-exec pages
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

As revealed by the recent "Prevent data exception in kernel space" 
patch, versions of glibc prior to 2.4[1] assume that, on powerpc32, they 
can execute out of any readable mapping, regardless of whether it is 
marked for execution.  This happens in the elf_machine_load_address() 
function.

To maintain compatibility with these versions, we could change the test 
in do_page_fault() to include VM_READ as well as VM_EXEC on targets that 
don't have a separate exec-bit in hardware (are there any powerpc mmus 
that do?).  However, Segher suggested on IRC that we may want to drop 
compatibility with those old versions of glibc, and that I should seek 
your input.

Personally, I'd rather stick the VM_READ in there, partially for selfish 
reasons (our root filesystems are based on older glibcs), and because it 
seems a little too soon to deprecate glibc 2.3, but also because in the 
absence of hardware support, the VM_EXEC check will be nondeterministic, 
kicking in only when the first fault for a page is to execute.

-Scott

[1] It's possible that there are other instances of this in 2.4 and that 
the actual version is newer; I ran into obnoxious cross compilation 
issues trying to try it.  However,

<rant>
Glibc already has target-specific code/headers; if you need to know 
something that you'd otherwise need a runs-on-the-target autoconf test 
for, why not just stick it in such a target-specific header?  In this 
case, it was trying to figure out the size of "long double".
</rant>

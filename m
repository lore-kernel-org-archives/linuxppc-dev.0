Return-Path: <jdomogala@acmepacket.com>
Received: from acmepacket.com (host10.216.41.24.conversent.net [216.41.24.10])
	by ozlabs.org (Postfix) with ESMTP id 520172BE83
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Nov 2004 15:04:38 +1100 (EST)
From: "Jeff Domogala" <jdomogala@acmepacket.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 11 Nov 2004 22:36:23 -0500
Message-ID: <NFBBJCNFKLFMBACPKDKCCEANELAA.jdomogala@acmepacket.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20041111211549.3B221C14B3@atlas.denx.de>
Subject: PowerPC MMU questions
Reply-To: jdomogala@acmepacket.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Folks,

I am dealing with a PowerPC 7455.  Here is my understanding regarding the
MMU translation order:  If the address is covered in a BAT, that BAT
translation is in effect.  If there is no BAT entry, then the page tables
are used to translate the address.  If there is no page table entry, an
exception is thrown and the exception handler for the miss needs to add a
new PTE.  So, correct me if I'm wrong in my translation.

Now, The system starts up with BAT entries to get the system off the ground.
I have equivalent BAT entries for the instruction and data sides.  I also
have the L1 I and D caches on as well as the L2 cache (I and D mode).  The
reason for using the BATs is to create non-cached I/O regions until the MMU
PTEs are populated.  Once the MMU PTEs are setup, the caches are flsuhed and
disabled, the MMU is disabled, the BATS disabled, the MMU re-enabled and the
caches re-enabled.  So here are my questions:

1. Is it ok to have the same I and D BAT entries?
2. Is it ok to setup the initial MMU PTEs with the BATs enabled or should
the caches be disabled and MMU disabled during the PTE setup?
3. Is there some other esource out there (mailing list or otherwise) that I
should be addressing these questions to?

Thanks,

Jeff Domogala

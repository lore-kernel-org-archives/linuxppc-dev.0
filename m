Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5DfK1NfSzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 23:41:13 +1000 (AEST)
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 635B215559
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 13:41:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-204-33.brq.redhat.com
 [10.40.204.33])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u4CDf9Nx001109
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 09:41:10 -0400
To: linuxppc-dev@lists.ozlabs.org
From: Florian Weimer <fweimer@redhat.com>
Subject: ppc64 sbrk returns executable heap in 32-bit emulation mode
Message-ID: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
Date: Thu, 12 May 2016 15:41:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We noticed that on ppc64, the sbrk system call in the 32-bit subsystem 
returns executable memory.  I assume it is related to this, in 
arch/powerpc/include/asm/page.h:

/*
  * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
  * and needs to be executable.  This means the whole heap ends
  * up being executable.
  */
#define VM_DATA_DEFAULT_FLAGS32 (VM_READ | VM_WRITE | VM_EXEC | \
                                  VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)


What is the rationale for this?  This comment must be *really* old, 
because ld.so in glibc should make sure that the PLT is executable.  And 
for current binaries, .bss is *not* executable, contrary to what the 
comment suggests.

Is this comment about pre-ELF binaries?  If yes, would it possible to 
change the default for ELF binaries?

Thanks,
Florian

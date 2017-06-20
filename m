Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsHj85dVmzDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:18:36 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K6E7Xs090377
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:18:34 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b69tvqc88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 02:18:34 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 16:18:30 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K6IRF157540750
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:18:27 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K6IQUD002624
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:18:27 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v2 11/12]Documentation: Documentation updates.
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-12-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com
Date: Tue, 20 Jun 2017 11:48:23 +0530
MIME-Version: 1.0
In-Reply-To: <1497671564-20030-12-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <eb2c2bf1-4881-aeb8-1a01-8ba11f69f18a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2017 09:22 AM, Ram Pai wrote:
> The Documentaton file is moved from x86 into the generic area,
> since this feature is now supported by more than one archs.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  Documentation/vm/protection-keys.txt  | 110 ++++++++++++++++++++++++++++++++++
>  Documentation/x86/protection-keys.txt |  85 --------------------------

I am not sure whether this is a good idea. There might be
specifics for each architecture which need to be detailed
again in this new generic one.

>  2 files changed, 110 insertions(+), 85 deletions(-)
>  create mode 100644 Documentation/vm/protection-keys.txt
>  delete mode 100644 Documentation/x86/protection-keys.txt
> 
> diff --git a/Documentation/vm/protection-keys.txt b/Documentation/vm/protection-keys.txt
> new file mode 100644
> index 0000000..b49e6bb
> --- /dev/null
> +++ b/Documentation/vm/protection-keys.txt
> @@ -0,0 +1,110 @@
> +Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
> +found in new generation of intel CPUs on PowerPC CPUs.
> +
> +Memory Protection Keys provides a mechanism for enforcing page-based
> +protections, but without requiring modification of the page tables
> +when an application changes protection domains.

Does resultant access through protection keys should be a
subset of the protection bits enabled through original PTE
PROT format ? Does the semantics exactly the same on x86
and powerpc ?

> +
> +
> +On Intel:
> +
> +It works by dedicating 4 previously ignored bits in each page table
> +entry to a "protection key", giving 16 possible keys.
> +
> +There is also a new user-accessible register (PKRU) with two separate
> +bits (Access Disable and Write Disable) for each key.  Being a CPU
> +register, PKRU is inherently thread-local, potentially giving each
> +thread a different set of protections from every other thread.
> +
> +There are two new instructions (RDPKRU/WRPKRU) for reading and writing
> +to the new register.  The feature is only available in 64-bit mode,
> +even though there is theoretically space in the PAE PTEs.  These
> +permissions are enforced on data access only and have no effect on
> +instruction fetches.
> +
> +
> +On PowerPC:
> +
> +It works by dedicating 5 page table entry to a "protection key",
> +giving 32 possible keys.
> +
> +There is a user-accessible register (AMR) with two separate bits
> +(Access Disable and Write Disable) for each key.  Being a CPU
> +register, AMR is inherently thread-local, potentially giving each
> +thread a different set of protections from every other thread.

Small nit. Space needed here.

> +NOTE: Disabling read permission does not disable
> +write and vice-versa.
> +
> +The feature is available on 64-bit HPTE mode only.
> +
> +'mtspr 0xd, mem' reads the AMR register
> +'mfspr mem, 0xd' writes into the AMR register.
> +
> +Permissions are enforced on data access only and have no effect on
> +instruction fetches.
> +
> +=========================== Syscalls ===========================
> +
> +There are 3 system calls which directly interact with pkeys:
> +
> +	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
> +	int pkey_free(int pkey);
> +	int pkey_mprotect(unsigned long start, size_t len,
> +			  unsigned long prot, int pkey);
> +
> +Before a pkey can be used, it must first be allocated with
> +pkey_alloc().  An application calls the WRPKRU instruction
> +directly in order to change access permissions to memory covered
> +with a key.  In this example WRPKRU is wrapped by a C function
> +called pkey_set().
> +
> +	int real_prot = PROT_READ|PROT_WRITE;
> +	pkey = pkey_alloc(0, PKEY_DENY_WRITE);
> +	ptr = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> +	ret = pkey_mprotect(ptr, PAGE_SIZE, real_prot, pkey);
> +	... application runs here
> +
> +Now, if the application needs to update the data at 'ptr', it can
> +gain access, do the update, then remove its write access:
> +
> +	pkey_set(pkey, 0); // clear PKEY_DENY_WRITE
> +	*ptr = foo; // assign something
> +	pkey_set(pkey, PKEY_DENY_WRITE); // set PKEY_DENY_WRITE again
> +
> +Now when it frees the memory, it will also free the pkey since it
> +is no longer in use:
> +
> +	munmap(ptr, PAGE_SIZE);
> +	pkey_free(pkey);
> +
> +(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
> + An example implementation can be found in
> + tools/testing/selftests/x86/protection_keys.c)
> +
> +=========================== Behavior ===========================
> +
> +The kernel attempts to make protection keys consistent with the
> +behavior of a plain mprotect().  For instance if you do this:
> +
> +	mprotect(ptr, size, PROT_NONE);
> +	something(ptr);
> +
> +you can expect the same effects with protection keys when doing this:
> +
> +	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
> +	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, pkey);
> +	something(ptr);
> +
> +That should be true whether something() is a direct access to 'ptr'
> +like:
> +
> +	*ptr = foo;
> +
> +or when the kernel does the access on the application's behalf like
> +with a read():
> +
> +	read(fd, ptr, 1);
> +
> +The kernel will send a SIGSEGV in both cases, but si_code will be set
> +to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
> +the plain mprotect() permissions are violated.

I guess the right thing would be to have three files

* Documentation/vm/protection-keys.txt

	- Generic interface, system calls
	- Signal handling, error codes
	- Semantics of programming with an example

* Documentation/x86/protection-keys.txt

	- Number of active protections keys inside an address space
	- X86 protection key instruction details
	- PTE protection bits placement details
	- Page fault handling
	- Implementation details a bit ?

* Documentation/powerpc/protection-keys.txt

	- Number of active protections keys inside an address space
	- Powerpc instructions details
	- PTE protection bits placement details
	- Page fault handling
	- Implementation details a bit ?

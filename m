Return-Path: <dave.hansen@intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W3Pd6bHlzF35L
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 03:03:17 +1000 (AEST)
Subject: Re: [PATCH v14 22/22] selftests/vm: test correct behavior of pkey-0
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-23-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <2963bd69-55bf-c557-ea24-deb56219cbb7@intel.com>
Date: Wed, 18 Jul 2018 10:03:11 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-23-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> Ensure pkey-0 is allocated on start.  Ensure pkey-0 can be attached
> dynamically in various modes, without failures.  Ensure pkey-0 can be
> freed and allocated.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |   66 +++++++++++++++++++++++++-
>  1 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 569faf1..156b449 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -999,6 +999,67 @@ void close_test_fds(void)
>  	return *ptr;
>  }
>  
> +void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
> +{
> +	int i, err;
> +	int max_nr_pkey_allocs;
> +	int alloced_pkeys[NR_PKEYS];
> +	int nr_alloced = 0;
> +	int newpkey;
> +	long size;
> +
> +	assert(pkey_last_malloc_record);
> +	size = pkey_last_malloc_record->size;
> +	/*
> +	 * This is a bit of a hack.  But mprotect() requires
> +	 * huge-page-aligned sizes when operating on hugetlbfs.
> +	 * So, make sure that we use something that's a multiple
> +	 * of a huge page when we can.
> +	 */
> +	if (size >= HPAGE_SIZE)
> +		size = HPAGE_SIZE;
> +
> +
> +	/* allocate every possible key and make sure key-0 never got allocated */
> +	max_nr_pkey_allocs = NR_PKEYS;
> +	for (i = 0; i < max_nr_pkey_allocs; i++) {
> +		int new_pkey = alloc_pkey();
> +		assert(new_pkey != 0);

Missed these earlier.  This needs to be pkey_assert().  We don't want
these tests to ever _actually_ crash.

> +	/* attach key-0 in various modes */
> +	err = sys_mprotect_pkey(ptr, size, PROT_READ, 0);
> +	pkey_assert(!err);
> +	err = sys_mprotect_pkey(ptr, size, PROT_WRITE, 0);
> +	pkey_assert(!err);
> +	err = sys_mprotect_pkey(ptr, size, PROT_EXEC, 0);
> +	pkey_assert(!err);
> +	err = sys_mprotect_pkey(ptr, size, PROT_READ|PROT_WRITE, 0);
> +	pkey_assert(!err);
> +	err = sys_mprotect_pkey(ptr, size, PROT_READ|PROT_WRITE|PROT_EXEC, 0);
> +	pkey_assert(!err);

This is all fine.

> +	/* free key-0 */
> +	err = sys_pkey_free(0);
> +	pkey_assert(!err);

This part is called out as undefined behavior in the manpage:

>        An application should not call pkey_free() on any protection key
>        which has been assigned to an address range by pkey_mprotect(2) and
>        which is still in use.  The behavior in this case is undefined and
>        may result in an error.

I don't think we should be testing for undefined behavior.

> +	newpkey = sys_pkey_alloc(0, 0x0);
> +	assert(newpkey == 0);
> +}
> +
>  void test_read_of_write_disabled_region(int *ptr, u16 pkey)
>  {
>  	int ptr_contents;
> @@ -1144,10 +1205,10 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
>  void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
>  {
>  	int err;
> -	int i = get_start_key();
> +	int i;
>  
>  	/* Note: 0 is the default pkey, so don't mess with it */
> -	for (; i < NR_PKEYS; i++) {
> +	for (i=1; i < NR_PKEYS; i++) {
>  		if (pkey == i)
>  			continue;

This seems to be randomly reverting earlier changes.

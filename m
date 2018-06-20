Return-Path: <dave.hansen@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419pN83MlMzDrcd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 01:17:12 +1000 (AEST)
Subject: Re: [PATCH v13 19/24] selftests/vm: associate key on a mapped page
 and detect access violation
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-20-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
Date: Wed, 20 Jun 2018 08:16:44 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-20-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> +void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
> +		u16 pkey)
> +{
> +	int ptr_contents;
> +
> +	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n",
> +				pkey, ptr);
> +	ptr_contents = read_ptr(ptr);
> +	dprintf1("reading ptr before disabling the read : %d\n",
> +			ptr_contents);
> +	read_pkey_reg();
> +	pkey_access_deny(pkey);
> +	ptr_contents = read_ptr(ptr);
> +	dprintf1("*ptr: %d\n", ptr_contents);
> +	expected_pkey_fault(pkey);
> +}

Looks fine to me.  I'm a bit surprised we didn't do this already, which
is a good thing for this patch.

FWIW, if you took patches like this and put them first, you could
probably get it merged now.  Yes, I know it would mean redoing some of
the later code move and rename ones.

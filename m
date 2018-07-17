Return-Path: <dave.hansen@intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VSb13lzSzF3Hh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 03:54:19 +1000 (AEST)
Subject: Re: [PATCH v13 08/24] selftests/vm: fix the wrong assert in
 pkey_disable_set()
To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-9-git-send-email-linuxram@us.ibm.com>
 <3c441309-1d35-eead-0c5d-1d7d20018219@intel.com>
 <20180717155848.GA5790@ram.oc3035372033.ibm.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <07869e1f-5022-92e3-416d-15c5f52d3b41@intel.com>
Date: Tue, 17 Jul 2018 10:53:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180717155848.GA5790@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2018 08:58 AM, Ram Pai wrote:
> On Wed, Jun 20, 2018 at 07:47:02AM -0700, Dave Hansen wrote:
>> On 06/13/2018 05:44 PM, Ram Pai wrote:
>>> If the flag is 0, no bits will be set. Hence we cant expect
>>> the resulting bitmap to have a higher value than what it
>>> was earlier
>> ...
>>>  	if (flags)
>>> -		pkey_assert(read_pkey_reg() > orig_pkey_reg);
>>> +		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
>>>  	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
>>>  		pkey, flags);
>>>  }
>> This is the kind of thing where I'd love to hear the motivation and
>> background.  This "disable a key that was already disabled" operation
>> obviously doesn't happen today.  What motivated you to change it now?
> On powerpc, hardware supports READ_DISABLE and WRITE_DISABLE.
> ACCESS_DISABLE is basically READ_DISABLE|WRITE_DISABLE on powerpc.
> 
> If access disable is called on a key followed by a write disable, the
> second operation becomes a nop. In such cases, 
>        read_pkey_reg() == orig_pkey_reg
> 
> Hence the code above is modified to 
> 	pkey_assert(read_pkey_reg() >= orig_pkey_reg);

Makes sense.  Do we have a comment for that now?

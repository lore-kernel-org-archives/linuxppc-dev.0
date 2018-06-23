Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41CdwJ0nn5zF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 01:02:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 Ulrich.Weigand@de.ibm.com, luto@kernel.org, msuchanek@suse.de
Subject: Re: [PATCH v2 0/6] powerpc/pkeys: fixes to pkeys
In-Reply-To: <20180621181045.GL5294@ram.oc3035372033.ibm.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <8812c879-5761-ef62-dd15-3ceef46d9653@redhat.com>
 <874lhzx84e.fsf@concordia.ellerman.id.au>
 <34669c66-ce2f-e8a0-1d18-43086bad3faa@redhat.com>
 <878t78fn6o.fsf@concordia.ellerman.id.au>
 <20180621181045.GL5294@ram.oc3035372033.ibm.com>
Date: Sun, 24 Jun 2018 01:02:50 +1000
Message-ID: <87in69eeat.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:
> On Thu, Jun 21, 2018 at 08:28:47PM +1000, Michael Ellerman wrote:
>> Florian Weimer <fweimer@redhat.com> writes:
>> > On 06/19/2018 02:40 PM, Michael Ellerman wrote:
>> >>> I tested the whole series with the new selftests, with the printamr.c
>> >>> program I posted earlier, and the glibc test for pkey_alloc &c.  The
>> >>> latter required some test fixes, but now passes as well.  As far as I
>> >>> can tell, everything looks good now.
>> >>>
>> >>> Tested-By: Florian Weimer<fweimer@redhat.com>
>> >> Thanks. I'll add that to each patch I guess, if you're happy with that?
>> >
>> > Sure, but I only tested the whole series as a whole.
>> 
>> Yeah OK. We don't have a good way to express that, other than using a
>> merge which I'd prefer to avoid.
>> 
>> So I've tagged them all with your Tested-by. If any of them turn out to
>> have bugs you can blame me :)
>
> I just tested the patches incrementally using the pkey selftests.
>
> So I feel confident these patches are not bugs. I will take the blame
> if the blame lands on Mpe  :)

Did you run core-pkey and ptrace-pkey?

The pkey selftests that are in tools/testing/selftests/powerpc/ptrace ?

Because those are failing for me:

  test: core_pkey
  tags: git_version:c899d94
  [FAIL] Test FAILED on line 245
  [Core Read (Running)]          AMR: 3fcfffffffffffff IAMR: 1105555555555555 UAMOR: 33cfffffffffffff
  failure: core_pkey
  
  test: ptrace_pkey
  tags: git_version:c899d94
  [FAIL] Test FAILED on line 214
  [Ptrace Read (Running)]        AMR: 3fcfffffffffffff IAMR: 1105555555555555 UAMOR: 33cfffffffffffff
  [User Write (Running)]         AMR: 3fffffffffffffff pkey1: 3 pkey2: 4 pkey3: 5
  failure: ptrace_pkey


Some of which is presumably test case bugs, but there's at least one
kernel bug with the UAMOR handling.

So this series will have to wait until next week :/

cheers

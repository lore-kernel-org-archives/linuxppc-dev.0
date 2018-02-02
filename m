Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXgtK5M6rzDqhc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 13:29:44 +1100 (AEDT)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: davem@davemloft.net, dave.hansen@linux.intel.com, aarcange@redhat.com,
 akpm@linux-foundation.org, allen.pais@oracle.com, anthony.yznaga@oracle.com,
 arnd@arndb.de, babu.moger@oracle.com, benh@kernel.crashing.org,
 bob.picco@oracle.com, bsingharora@gmail.com, corbet@lwn.net,
 dan.j.williams@intel.com, dave.jiang@intel.com, david.j.aldridge@oracle.com,
 elena.reshetova@intel.com, glx@linutronix.de, gregkh@linuxfoundation.org,
 hannes@cmpxchg.org, hillf.zj@alibaba-inc.com, hpa@zytor.com, hughd@google.com,
 imbrenda@linux.vnet.ibm.com, jack@suse.cz, jag.raman@oracle.com,
 jane.chu@oracle.com, jglisse@redhat.com, jroedel@suse.de,
 khalid@gonehiking.org, khandual@linux.vnet.ibm.com,
 kirill.shutemov@linux.intel.com, kstewart@linuxfoundation.org,
 ktkhai@virtuozzo.com, liam.merwick@oracle.com, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net, me@tobin.cc,
 mgorman@suse.de, mgorman@techsingularity.net, mhocko@suse.com,
 mike.kravetz@oracle.com, minchan@kernel.org, mingo@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, nadav.amit@gmail.com,
 nagarathnam.muthusamy@oracle.com, nborisov@suse.com, n-horiguchi@ah.jp.nec.com,
 nick.alcock@oracle.com, nitin.m.gupta@oracle.com, ombredanne@nexb.com,
 pasha.tatashin@oracle.com, paulus@samba.org, pombredanne@nexb.com,
 punit.agrawal@arm.com, rob.gardner@oracle.com, ross.zwisler@linux.intel.com,
 shannon.nelson@oracle.com, shli@fb.com, sparclinux@vger.kernel.org,
 steven.sistare@oracle.com, tglx@linutronix.de, thomas.tai@oracle.com,
 tklauser@distanz.ch, tom.hromatka@oracle.com, vegard.nossum@oracle.com,
 vijay.ac.kumar@oracle.com, willy@infradead.org, x86@kernel.org,
 zi.yan@cs.rutgers.edu
References: <cover.1517497017.git.khalid.aziz@oracle.com>
Date: Thu, 01 Feb 2018 20:29:14 -0600
In-Reply-To: <cover.1517497017.git.khalid.aziz@oracle.com> (Khalid Aziz's
 message of "Thu, 1 Feb 2018 11:01:08 -0700")
Message-ID: <87wozwi0p1.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v11 00/10] Application Data Integrity feature introduced
 by SPARC M7
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Khalid Aziz <khalid.aziz@oracle.com> writes:

> V11 changes:
> This series is same as v10 and was simply rebased on 4.15 kernel. Can
> mm maintainers please review patches 2, 7, 8 and 9 which are arch
> independent, and include/linux/mm.h and mm/ksm.c changes in patch 10
> and ack these if everything looks good?

I am a bit puzzled how this differs from the pkey's that other
architectures are implementing to achieve a similar result.

I am a bit mystified why you don't store the tag in a vma
instead of inventing a new way to store data on page out.

Can you please use force_sig_fault to send these signals instead
of force_sig_info.  Emperically I have found that it is very
error prone to generate siginfo's by hand, especially on code
paths where several different si_codes may apply.  So it helps
to go through a helper function to ensure the fiddly bits are
all correct.  AKA the unused bits all need to be set to zero before
struct siginfo is copied to userspace.

Eric

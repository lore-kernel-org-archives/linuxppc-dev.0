Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTmFv4hJQzDsFv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Sep 2016 00:34:59 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-ima-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Eric Richter <erichte@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <bsingharora@gmail.com>
References: <1472579105-26296-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <8760q7lswz.fsf@x220.int.ebiederm.org>
Date: Wed, 07 Sep 2016 09:19:40 -0500
In-Reply-To: <8760q7lswz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
 message of "Wed, 07 Sep 2016 08:51:24 -0500")
Message-ID: <871t0vlrlv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v4 0/5] kexec_file: Add buffer hand-over for the next
 kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
>
>> Hello,
>>
>> The purpose of this new version of the series is to fix a small issue that
>> I found, which is that the kernel doesn't remove the memory reservation
>> for the hand-over buffer it received from the previous kernel in the
>> device tree it sets up for the next kernel. The result is that for each
>> successive kexec, a stale hand-over buffer is left behind, wasting memory.
>>
>> This is fixed by changes to kexec_free_handover_buffer and
>> setup_handover_buffer in patch 2. The other change is to fix checkpatch
>> warnings in the last patch.
>
> This is fundamentally broken.  You do not increase the integrity of a
> system by dropping integrity checks.
>
> No. No. No. No.
>
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

To be constructive the way we have handled similiar situations in the
past (hotplu memory) is to call kexec_load again.

Eric

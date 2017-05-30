Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcVcX4GHzzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 20:45:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Colin Ian King <colin.king@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/fadump: return error when fadump registration
 fails
In-Reply-To: <e1caa0a3-50a0-aff3-3687-2ef31841e587@linux.vnet.ibm.com>
References: <20170527154615.29684-1-msuchanek@suse.de>
 <e1caa0a3-50a0-aff3-3687-2ef31841e587@linux.vnet.ibm.com>
Date: Tue, 30 May 2017 20:45:13 +1000
Message-ID: <87bmqa62ti.fsf@concordia.ellerman.id.au>
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

Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> writes:

> On 05/27/2017 09:16 PM, Michal Suchanek wrote:
>>  - log an error message when registration fails and no error code listed
>>  in the switch is returned
>>  - translate the hv error code to posix error code and return it from
>>  fw_register
>>  - return the posix error code from fw_register to the process writing
>>  to sysfs
>>  - return EEXIST on re-registration
>>  - return success on deregistration when fadump is not registered
>>  - return ENODEV when no memory is reserved for fadump
>
> Why do we need this ?

Because that's how we do error handling.

> Userspace can always read back the fadump registration status from
> /sys/kernel/fadump_registered (after echo 1 to it) to find out
> whether fadump registration succeeded or not.

That's a terrible API.

If we followed that example, open() wouldn't return a value, you'd have
to do another syscall to check if it worked.

I'd appreciate if someone could test this and give me a Tested-by.

cheers

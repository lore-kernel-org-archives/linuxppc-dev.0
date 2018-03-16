Return-Path: <dave.hansen@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4030dg2nvGzDr2b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 09:35:03 +1100 (AEDT)
Subject: Re: [PATCH v12 22/22] selftests/vm: Fix deadlock in protection_keys.c
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0c82a148-3f10-66f4-a7d7-cace557ff038@intel.com>
Date: Fri, 16 Mar 2018 15:34:52 -0700
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> 
> The sig_chld() handler calls dprintf2() taking care of setting
> dprint_in_signal so that sigsafe_printf() won't call printf().
> Unfortunately, this precaution is is negated by dprintf_level(), which
> has a call to fflush().
> 
> This function acquires a lock, which means that if the signal interrupts an
> ongoing fflush() the process will deadlock. At least on powerpc this is
> easy to trigger, resulting in the following backtrace when attaching to the
> frozen process:

Ugh, yeah, I've run into this too.

Acked-by: Dave Hansen <dave.hansen@intel.com>

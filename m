Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D0bL6sm8zF1rw
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 01:04:14 +1100 (AEDT)
In-Reply-To: <1522348331-30753-1-git-send-email-mauricfo@linux.vnet.ibm.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: Fix to clear security feature flags
Message-Id: <40D0bL4ntgz9s1r@ozlabs.org>
Date: Sun,  1 Apr 2018 01:04:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-03-29 at 18:32:11 UTC, Mauricio Faria de Oliveira wrote:
> The H_CPU_BEHAV_* flags should be checked for in the 'behaviour' field
> of 'struct h_cpu_char_result' -- 'character' is for H_CPU_CHAR_* flags.
> 
> Found it by playing around with QEMU's implementation of the hypercall:
> 
> Example: 
>   H_CPU_CHAR=0xf000000000000000
>   H_CPU_BEHAV=0x0000000000000000
> 
>   This clears H_CPU_BEHAV_FAVOUR_SECURITY and H_CPU_BEHAV_L1D_FLUSH_PR
>   so pseries_setup_rfi_flush() disables 'rfi_flush'; and it also clears
>   H_CPU_CHAR_L1D_THREAD_PRIV flag.  So there is no RFI flush mitigation
>   at all for cpu_show_meltdown() to report; but currently it does:
> 
>   Original kernel:
> 
>     # cat /sys/devices/system/cpu/vulnerabilities/meltdown
>     Mitigation: RFI Flush
> 
>   Patched kernel:
> 
>     # cat /sys/devices/system/cpu/vulnerabilities/meltdown
>     Not affected
> 
> Example:
>   H_CPU_CHAR=0x0000000000000000
>   H_CPU_BEHAV=0xf000000000000000
> 
>   This sets H_CPU_BEHAV_BNDS_CHK_SPEC_BAR so cpu_show_spectre_v1() should
>   report vulnerable; but currently it doesn't:
> 
>   Original kernel:
> 
>     # cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
>     Not affected
> 
>   Patched kernel:
> 
>     # cat /sys/devices/system/cpu/vulnerabilities/spectre_v1
>     Vulnerable
> 
> Fixes: f636c14790ea ("powerpc/pseries: Set or clear security feature flags")
> Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0f9bdfe3c77091e8704d2e510eb7c2

cheers

Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	by ozlabs.org (Postfix) with ESMTP id EBE3FDDFF4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jun 2008 01:13:07 +1000 (EST)
To: linuxppc-embedded@ozlabs.org
Subject: Re: FP and signal 4
In-Reply-To: <200806051029.36558.sr@denx.de>
Date: Thu, 05 Jun 2008 09:28:01 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1K4GRd-00057d-GL@jdl.com>
Cc: sr@denx.de, reynekejunk@hotmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Also sprach Zarathustra und Stefan Roese:
>
> I hope "-b 0" is set by default in recent dtc versions.

Und Git antwortete:

commit 548767f42eb00a2bac6f2a1361b7fd49f7b76908
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Fri May 16 13:22:57 2008 +1000

    dtc: Rework handling of boot_cpuid_phys
    
    Currently, dtc will put the nonsense value 0xfeedbeef into the
    boot_cpuid_phys field of an output blob, unless explicitly given
    another value with the -b command line option.  As well as being a
    totally unuseful default value, this also means that dtc won't
    properly preserve the boot_cpuid_phys field in -I dtb -O dtb mode.
    
    This patch reworks things to improve the boot_cpuid handling.  The new
    semantics are that the output's boot_cpuid_phys value is:
        the value given on the command line if -b is used
    otherwise
        the value from the input, if in -I dtb mode
    otherwise
        0
    
    Implementation-wise we do the following:
        - boot_cpuid_phys is added to struct boot_info, so that
    structure now contains all of the blob's semantic information.
        - dt_to_blob() and dt_to_asm() output the cpuid given in
    boot_info
        - dt_from_blob() fills in boot_info based on the input blob
        - The other dt_from_*() functions just record 0, but we can
    change this easily if e.g. we invent a way of specifying the boot cpu
    in the source format.
        - main() overrides the cpuid in the boot_info between input
    and output if -b is given
    
    We add some testcases to check this new behaviour.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

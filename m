Return-Path: <linuxppc-dev+bounces-17845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44575FCC07C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 21:17:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSK3t0h60z2xTh;
	Sat, 07 Mar 2026 08:17:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772831834;
	cv=none; b=EqKFFgAsZRrpbbiGKJwoQaa7gozsQX7lUWgnLVXoYSQBWz2BzspYtCC4RO6zw2MAT/aAm+6ILPuBAuBZ9SKA0k+PpXqvCKk4h72RfCGelYF4KzO/m9kUTY1rPun9Ldf+yggRijffc6Q6X8mQdR21rmLyITXTukdxECQYJmylmzVBt3SS8Q2iycBIjMvC/nzosB6N4GNpdgb6on4MwGDQy6PZVW3ZPuVj2kj2mbVO19MmgeG03ha9QPymHK3T9u8H/ck0MgsG+Z2Fg1f3tF2eN12mq3s2AaQCn2httFGNO1GTCiNtHIwSPhcJ+y5+RO9XnWr2EJH/akd99x2Hmv2UJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772831834; c=relaxed/relaxed;
	bh=xOW6tUsh0cgra+EJompGu1/odZ9bo9P3/PuZBOWPsIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=au0+ElqBXhZizwOZ5vMVZ0+pqEZMfvEoH7z05Z+6zRcs33GPMvA+TwBpOcu0duH02tazuUYFMP43WMkKSPsPlpflmPvE8IbvTTjTvtQbPB1lrnPYSGT1wxo+20AzMn1xCTjCiyolyGdiDLaHcKvKiOHLqJolRye3I2BFLxDms2C8XAn7iQyjjnz1aWHL4zGYaEfGyuZgDmBnc7weu5GpNEbnn525k+juZBL/mz2UWh5MqkQK1wr5/IEU1N0LIglOF52htJddhZCXPG8les0PeC7OL3tQWkmpvL3mEpgVBiqRY5b5PhPc+lWzGQ5fAo6AeL6NXhfd7al8frJbervb1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGh6Kltd; dkim-atps=neutral; spf=pass (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YGh6Kltd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSK3p3Spxz2xT4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2026 08:17:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772831831; x=1804367831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uZuCakPLyV0YhkoEiRG1KRnO5yknVI+iOX2e2p0KbCI=;
  b=YGh6KltduSNqopz08OYHSpjcDR2/smbGcXmzqbyHXWxKPD3QYufcPuy3
   LiNg/THo3BcmAdglGgeiqdDhwtXNVQp0JSu9JtikOyo9eIGJJmBoUO81O
   yETxck/BfqfZWt1ZZ6QsAvhkhk23hr0KJWGInVHL5EKW9P9AguHjE85bf
   kd6C0h1t1Hj3GZkiWjuXe5REYPSKMtojWSwWkEgL/DFQPorC9EXK9S5z2
   0K03mDw5nu8oh8aGpWJUN6utwalBIDxZFcJj1X20Gz2WztraD24a5ydwV
   lKgQUvnN5KnKTF4rCi5hTMzL/PExqhqYfi06ALZTSx7A6yEXtNuyEG9O9
   g==;
X-CSE-ConnectionGUID: Lb2Af3dKT9iBbBtClbgHHw==
X-CSE-MsgGUID: haRmlQ+qSlOogGyYFpLZAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73864528"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73864528"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 13:17:03 -0800
X-CSE-ConnectionGUID: sLCBQ4W5SDmWOS6uvkx/UQ==
X-CSE-MsgGUID: udzCn7C5Rlef9WYbwV9VVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="219065605"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Mar 2026 13:16:55 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vycXT-000000001Nx-1b5J;
	Fri, 06 Mar 2026 21:16:51 +0000
Date: Sat, 7 Mar 2026 05:16:00 +0800
From: kernel test robot <lkp@intel.com>
To: Vasily Gorbik <gor@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>, Coiby Xu <coxu@redhat.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 1/1] s390/ipl: Fix missing arch_get_secureboot()
 prototype warning
Message-ID: <202603070500.3pafeTNF-lkp@intel.com>
References: <p01-01.g9ec0a81d34d1.ttbfdx5@ub.hpns>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p01-01.g9ec0a81d34d1.ttbfdx5@ub.hpns>

Hi Vasily,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc2]
[also build test ERROR on linus/master]
[cannot apply to next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasily-Gorbik/s390-ipl-Fix-missing-arch_get_secureboot-prototype-warning/20260305-230453
base:   v7.0-rc2
patch link:    https://lore.kernel.org/r/p01-01.g9ec0a81d34d1.ttbfdx5%40ub.hpns
patch subject: [PATCH 1/1] s390/ipl: Fix missing arch_get_secureboot() prototype warning
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260307/202603070500.3pafeTNF-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260307/202603070500.3pafeTNF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603070500.3pafeTNF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/s390/kernel/ipl.c:24:10: fatal error: 'linux/secure_boot.h' file not found
      24 | #include <linux/secure_boot.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +24 arch/s390/kernel/ipl.c

  > 24	#include <linux/secure_boot.h>
    25	#include <asm/asm-extable.h>
    26	#include <asm/machine.h>
    27	#include <asm/diag.h>
    28	#include <asm/ipl.h>
    29	#include <asm/smp.h>
    30	#include <asm/setup.h>
    31	#include <asm/cpcmd.h>
    32	#include <asm/ebcdic.h>
    33	#include <asm/sclp.h>
    34	#include <asm/checksum.h>
    35	#include <asm/debug.h>
    36	#include <asm/abs_lowcore.h>
    37	#include <asm/os_info.h>
    38	#include <asm/sections.h>
    39	#include <asm/boot_data.h>
    40	#include "entry.h"
    41	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


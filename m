Return-Path: <robherring2@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 082571A089C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 03:03:20 +1000 (AEST)
Received: by wiwd19 with SMTP id d19so28106265wiw.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2015 10:03:16 -0700 (PDT)
MIME-Version: 1.0
Sender: robherring2@gmail.com
In-Reply-To: <20150604102032.DF5B4140280@ozlabs.org>
References: <1433308225-13874-1-git-send-email-robh@kernel.org>
 <20150604102032.DF5B4140280@ozlabs.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Jun 2015 12:02:55 -0500
Message-ID: <CAL_JsqKTNiVqZoPHn-UCPXMkddruNbywwiA2nwLkfbzaziXFBg@mail.gmail.com>
Subject: Re: of: clean-up unnecessary libfdt include paths
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux-MIPS <linux-mips@linux-mips.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>,
 Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 4, 2015 at 5:20 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Wed, 2015-03-06 at 05:10:25 UTC, Rob Herring wrote:
>> With the latest dtc import include fixups, it is no longer necessary to
>> add explicit include paths to use libfdt. Remove these across the
>> kernel.
>
> What are the "latest dtc import include fixups" ?

Changing the scripts/dtc/libfdt/libfdt.h includes from <> to "". The
import script does this now and the recent import in my for-next tree
has this. I'll clarify this in the commit message.

>
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index c1ebbda..c16e836 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -2,7 +2,6 @@
>>  # Makefile for the linux kernel.
>>  #
>>
>> -CFLAGS_prom.o                = -I$(src)/../../../scripts/dtc/libfdt
>>  CFLAGS_ptrace.o              += -DUTS_MACHINE='"$(UTS_MACHINE)"'
>>
>>  subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks.

Rob

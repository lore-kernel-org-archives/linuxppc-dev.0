Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsbN92LzkzDqf5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 14:04:41 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2S33fr4135185
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 23:04:29 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ffjx830v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 23:04:29 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 28 Mar 2017 13:04:26 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2S34FB843646980
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 14:04:23 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2S33nna026113
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 14:03:51 +1100
Subject: Re: [kernel-hardening] [PATCH v5 1/4] gcc-plugins: Add the initify
 gcc plugin
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
References: <1485894263-91051-1-git-send-email-keescook@chromium.org>
 <1485894263-91051-2-git-send-email-keescook@chromium.org>
 <851a0c99-db08-c3a8-f5c6-2e567971e2eb@au1.ibm.com>
Cc: Emese Revfy <re.emese@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Josh Triplett <josh@joshtriplett.org>, pageexec@freemail.hu,
 yamada.masahiro@socionext.com, minipli@ld-linux.so,
 linux@armlinux.org.uk, catalin.marinas@arm.com,
 linux@rasmusvillemoes.dk, david.brown@linaro.org,
 benh@kernel.crashing.org, tglx@linutronix.de,
 akpm@linux-foundation.org, jlayton@poochiereds.net, sam@ravnborg.org,
 kernel-hardening@lists.openwall.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 28 Mar 2017 14:03:24 +1100
MIME-Version: 1.0
In-Reply-To: <851a0c99-db08-c3a8-f5c6-2e567971e2eb@au1.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <1a252726-5b0f-1cd9-708e-71844df82386@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/03/17 18:38, Andrew Donnellan wrote:
> On 01/02/17 07:24, Kees Cook wrote:
>> From: Emese Revfy <re.emese@gmail.com>
>>
>> The kernel already has a mechanism to free up code and data memory that
>> is only used during kernel or module initialization.  This plugin will
>> teach the compiler to find more such code and data that can be freed
>> after initialization.
>
> Currently checking whether we can wire this up for powerpc without too
> many problems...

Added "select HAVE_GCC_PLUGIN_INITIFY_INIT_EXIT if GCC_PLUGINS" to 
arch/powerpc/Kconfig and have successfully compiled and booted a modular 
and non-modular powernv_defconfig, it looks like we handle the .exit 
sections correctly.

Could this be folded in for further testing when you get around to v6, Kees?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

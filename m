Return-Path: <SRS0=5lCP=YT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CB3CA9EB9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 15:57:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C49252070B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Oct 2019 15:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="FFKWug3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C49252070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 470lxL4g47zDqkL
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Oct 2019 02:57:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="FFKWug3F"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 470ltM5fqczDqrq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2019 02:55:05 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 470ltB4SKwzB09b0;
 Sat, 26 Oct 2019 17:54:58 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=FFKWug3F; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id UmHFfUH-gsGH; Sat, 26 Oct 2019 17:54:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 470ltB3Ff2zB09Zy;
 Sat, 26 Oct 2019 17:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1572105298; bh=C1+CJgUT+MIl2Jojxx6v80nffsccKebrJplMCoRuAgY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=FFKWug3FlOjVFrivm7EapfZOLfGysXPq211Dy3P506Bw10tg/zbjjkif1lrOytCrL
 MZHFw/ZCaURPQ2GeK5x0NqCIeQk/d76hZzCYsr1mkN+R/HcloUxO+tgPNwsSDBJLCd
 vTigoc7pR1PbUGPsRhxg/bT3mItnP6cvIwNmSwmA=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AC5B8B7AD;
 Sat, 26 Oct 2019 17:55:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id UVuk8qEKxv9d; Sat, 26 Oct 2019 17:55:00 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E17C8B787;
 Sat, 26 Oct 2019 17:54:59 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
To: Andy Lutomirski <luto@kernel.org>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
 <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
 <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr>
 <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr>
 <CALCETrWEKrE6nhu2F9+V_8EhWKqyuq5Qit05Uj9V_TeBKZNJsw@mail.gmail.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1d685415-2550-fc16-2675-b344a5496099@c-s.fr>
Date: Sat, 26 Oct 2019 17:54:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWEKrE6nhu2F9+V_8EhWKqyuq5Qit05Uj9V_TeBKZNJsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/10/2019 à 15:55, Andy Lutomirski a écrit :
> On Tue, Oct 22, 2019 at 6:56 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>>
>>>>> The performance is rather disappoiting. That's most likely all
>>>>> calculation in the C implementation are based on 64 bits math and
>>>>> converted to 32 bits at the very end. I guess C implementation should
>>>>> use 32 bits math like the assembly VDSO does as of today.
>>>>
>>>>> gettimeofday:    vdso: 750 nsec/call
>>>>>
>>>>> gettimeofday:    vdso: 1533 nsec/call
>>>
>>> Small improvement (3%) with the proposed change:
>>>
>>> gettimeofday:    vdso: 1485 nsec/call
>>
>> By inlining do_hres() I get the following:
>>
>> gettimeofday:    vdso: 1072 nsec/call
>>
> 
> A perf report might be informative.
> 

Not sure there is much to learn from perf report:

With the original RFC:

     51.83%  test_vdso  [vdso]             [.] do_hres
     24.86%  test_vdso  [vdso]             [.] __c_kernel_gettimeofday
      7.33%  test_vdso  [vdso]             [.] __kernel_gettimeofday
      5.77%  test_vdso  test_vdso          [.] main
      1.55%  test_vdso  [kernel.kallsyms]  [k] copy_page
      0.67%  test_vdso  libc-2.23.so       [.] _dl_addr
      0.55%  test_vdso  ld-2.23.so         [.] do_lookup_x

With vdso_calc_delta() optimised as suggested by Thomas + inlined do_hres():

     68.00%  test_vdso  [vdso]             [.] __c_kernel_gettimeofday
     12.59%  test_vdso  [vdso]             [.] __kernel_gettimeofday
      6.22%  test_vdso  test_vdso          [.] main
      2.07%  test_vdso  [kernel.kallsyms]  [k] copy_page
      1.04%  test_vdso  ld-2.23.so         [.] _dl_relocate_object
      0.89%  test_vdso  ld-2.23.so         [.] do_lookup_x

I've tried 'perf annotate', but I have not found how to tell perf to use 
vdso32.so.dbg file for annotate [vdso].

Test app:

#include <dlfcn.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/time.h>

static int (*gettimeofday_vdso)(struct timeval *tv, struct timezone *tz);

int main(int argc, char **argv)
{
	void *handle = dlopen("linux-vdso32.so.1", RTLD_NOW | RTLD_GLOBAL);
	struct timeval tv;
	struct timezone tz;
	int i;

	(void)dlerror();

	gettimeofday_vdso = dlsym(handle, "__kernel_gettimeofday");
	if (dlerror())
		gettimeofday_vdso = NULL;

	for (i = 0; i < 100000; i++)
		gettimeofday_vdso(&tv, &tz);
}


Christophe

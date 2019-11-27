Return-Path: <SRS0=SG0q=ZT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A273C432C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 07:34:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB012053B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 07:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="NkdOCTCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB012053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47NCG80ntpzDqGb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Nov 2019 18:34:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="NkdOCTCD"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47NC9m2xb3zDqjW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2019 18:30:49 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47NC9c3dGGz9tykX;
 Wed, 27 Nov 2019 08:30:44 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=NkdOCTCD; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0lG1PMTvBala; Wed, 27 Nov 2019 08:30:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47NC9c1bgrz9tykW;
 Wed, 27 Nov 2019 08:30:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1574839844; bh=NJQssQkYeJeEjKGMaEMr+bjTGOX9h1XeXNPNHApes7k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=NkdOCTCDvC0Kndz+ltBeOQvVocuXPNtP0aJg9+YY+8GqDvUIdB91/nP31kmMHRcap
 WFsCPGX0tZVfMzN09DlYpkejbUT9sXpvf1l1b9Ph1Ec4woz7r/DhkUfWLUnzu69vZb
 Hwy/pEaiRyDrEYOMc3lH+ZhmYVlh8Y7gK+BzYF5o=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F33098B842;
 Wed, 27 Nov 2019 08:30:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OkqU2WrIISZx; Wed, 27 Nov 2019 08:30:44 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 339598B770;
 Wed, 27 Nov 2019 08:30:43 +0100 (CET)
Subject: Re: [PATCH v2 26/35] powerpc/64: system call: Fix sparse warning
 about missing declaration
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>
References: <cover.1574798487.git.msuchanek@suse.de>
 <d0a6b5235c4e1544f4c253724a5b8f2106cc43bd.1574798487.git.msuchanek@suse.de>
 <20191126214441.4wziibsax2mvpl3p@ltop.local>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <35062751-0d90-ce2d-76ad-ea6566668d93@c-s.fr>
Date: Wed, 27 Nov 2019 08:30:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191126214441.4wziibsax2mvpl3p@ltop.local>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, David Howells <dhowells@redhat.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>, Christian Brauner <christian@brauner.io>,
 Breno Leitao <leitao@debian.org>, Michael Neuling <mikey@neuling.org>,
 Nicolai Stange <nstange@suse.de>, Diana Craciun <diana.craciun@nxp.com>,
 Firoz Khan <firoz.khan@linaro.org>, Allison Randal <allison@lohutok.net>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Jagadeesh Pagadala <jagdsh.linux@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dmitry Vyukov <dvyukov@google.com>, Daniel Axtens <dja@axtens.net>,
 Gustavo Romero <gromero@linux.ibm.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Brajeswar Ghosh <brajeswar.linux@gmail.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/11/2019 à 22:44, Luc Van Oostenryck a écrit :
> On Tue, Nov 26, 2019 at 09:13:40PM +0100, Michal Suchanek wrote:
>> Sparse warns about missing declarations for these functions:
>>
>> +arch/powerpc/kernel/syscall_64.c:108:23: warning: symbol 'syscall_exit_prepare' was not declared. Should it be static?
>> +arch/powerpc/kernel/syscall_64.c:18:6: warning: symbol 'system_call_exception' was not declared. Should it be static?
>> +arch/powerpc/kernel/syscall_64.c:200:23: warning: symbol 'interrupt_exit_user_prepare' was not declared. Should it be static?
>> +arch/powerpc/kernel/syscall_64.c:288:23: warning: symbol 'interrupt_exit_kernel_prepare' was not declared. Should it be static?
>>
>> Add declaration for them.
> 
> I'm fine with this patch but, just FYI, lately people seems to
> prefer to add '__visible' to the function definition instead
> of creating such header files.

AFAIU, that's not exactly the purpose of '__visible', see 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9add850c2

Christophe

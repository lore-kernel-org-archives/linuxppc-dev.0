Return-Path: <SRS0=ZMG4=T3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B94FC04AB3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 10:55:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AF920859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 10:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AF920859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CDQK3n7fzDqJS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 May 2019 20:55:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=rjwysocki.net
 (client-ip=79.96.170.134; helo=cloudserver094114.home.pl;
 envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=rjwysocki.net
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45CDNr4d0yzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 May 2019 20:53:47 +1000 (AEST)
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO
 kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 3e9dcd1393346651; Mon, 27 May 2019 12:53:42 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v2] powerpc/power: Expose pfn_is_nosave prototype
Date: Mon, 27 May 2019 12:53:41 +0200
Message-ID: <1929721.iDiXxTFbjN@kreacher>
In-Reply-To: <20190524104418.17194-1-malat@debian.org>
References: <20190523114736.30268-1-malat@debian.org>
 <20190524104418.17194-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Len Brown <len.brown@intel.com>, linux-s390@vger.kernel.org,
 linux-pm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Pavel Machek <pavel@ucw.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Friday, May 24, 2019 12:44:18 PM CEST Mathieu Malaterre wrote:
> The declaration for pfn_is_nosave is only available in
> kernel/power/power.h. Since this function can be override in arch,
> expose it globally. Having a prototype will make sure to avoid warning
> (sometime treated as error with W=1) such as:
> 
>   arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]
> 
> This moves the declaration into a globally visible header file and add
> missing include to avoid a warning on powerpc. Also remove the
> duplicated prototypes since not required anymore.
> 
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: As suggestion by christophe remove duplicates prototypes
> 
>  arch/powerpc/kernel/suspend.c | 1 +
>  arch/s390/kernel/entry.h      | 1 -
>  include/linux/suspend.h       | 1 +
>  kernel/power/power.h          | 2 --
>  4 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/suspend.c b/arch/powerpc/kernel/suspend.c
> index a531154cc0f3..9e1b6b894245 100644
> --- a/arch/powerpc/kernel/suspend.c
> +++ b/arch/powerpc/kernel/suspend.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/mm.h>
> +#include <linux/suspend.h>
>  #include <asm/page.h>
>  #include <asm/sections.h>
>  
> diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
> index 20420c2b8a14..b2956d49b6ad 100644
> --- a/arch/s390/kernel/entry.h
> +++ b/arch/s390/kernel/entry.h
> @@ -63,7 +63,6 @@ void __init startup_init(void);
>  void die(struct pt_regs *regs, const char *str);
>  int setup_profiling_timer(unsigned int multiplier);
>  void __init time_init(void);
> -int pfn_is_nosave(unsigned long);
>  void s390_early_resume(void);
>  unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
>  
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 6b3ea9ea6a9e..e8b8a7bede90 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -395,6 +395,7 @@ extern bool system_entering_hibernation(void);
>  extern bool hibernation_available(void);
>  asmlinkage int swsusp_save(void);
>  extern struct pbe *restore_pblist;
> +int pfn_is_nosave(unsigned long pfn);
>  #else /* CONFIG_HIBERNATION */
>  static inline void register_nosave_region(unsigned long b, unsigned long e) {}
>  static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 9e58bdc8a562..44bee462ff57 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -75,8 +75,6 @@ static inline void hibernate_reserved_size_init(void) {}
>  static inline void hibernate_image_size_init(void) {}
>  #endif /* !CONFIG_HIBERNATION */
>  
> -extern int pfn_is_nosave(unsigned long);
> -
>  #define power_attr(_name) \
>  static struct kobj_attribute _name##_attr = {	\
>  	.attr	= {				\
> 

With an ACK from the powerpc maintainers, I could apply this one.





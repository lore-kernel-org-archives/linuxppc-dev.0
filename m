Return-Path: <SRS0=sLSx=7Q=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75157C433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 23:06:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD51720829
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2020 23:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD51720829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cl0J5JfPzDqg5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 09:06:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.56; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0056.hostedemail.com
 [216.40.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cky00FZ1zDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 09:04:37 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 45F56837F24D;
 Wed,  3 Jun 2020 23:04:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: basin86_280ffd426d92
X-Filterd-Recvd-Size: 3564
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf17.hostedemail.com (Postfix) with ESMTPA;
 Wed,  3 Jun 2020 23:04:32 +0000 (UTC)
Message-ID: <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 03 Jun 2020 16:04:31 -0700
In-Reply-To: <202006031539.4198EA6@keescook>
References: <202006031539.4198EA6@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-06-03 at 15:40 -0700, Kees Cook wrote:
> The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> lead to skipping this code.
> 
> Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/pwm/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 9973c442b455..6b3cbc0490c6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
>  		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
>  		trace_pwm_get(pwm, &pwm->state);
>  
> -		if (IS_ENABLED(PWM_DEBUG))
> +		if (IS_ENABLED(CONFIG_PWM_DEBUG))
>  			pwm->last = pwm->state;
>  	}
>  
> -- 
> 2.25.1
> 

more odd uses (mostly in comments)

$ git grep -P -oh '\bIS_ENABLED\s*\(\s*\w+\s*\)'| \
  sed -r 's/\s+//g'| \
  grep -v '(CONFIG_' | \
  sort | uniq -c | sort -rn
      7 IS_ENABLED(DEBUG)
      4 IS_ENABLED(DRM_I915_SELFTEST)
      4 IS_ENABLED(cfg)
      2 IS_ENABLED(opt_name)
      2 IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
      2 IS_ENABLED(config)
      2 IS_ENABLED(cond)
      2 IS_ENABLED(__BIG_ENDIAN)
      1 IS_ENABLED(x)
      1 IS_ENABLED(STRICT_KERNEL_RWX)
      1 IS_ENABLED(PWM_DEBUG)
      1 IS_ENABLED(option)
      1 IS_ENABLED(ETHTOOL_NETLINK)
      1 IS_ENABLED(DEBUG_RANDOM_TRIE)
      1 IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)

STRICT_KERNEL_RWX is misused here in ppc

---

Fix pr_warn without newline too.

 arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 51e3c15f7aff..dd60c5f2b991 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
 		 */
-		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
+		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
 		    (unsigned long)_stext % 0x1000000) {
 			if (mmu_psize_defs[MMU_PAGE_16M].shift)
-				pr_warn("Kernel not 16M aligned, "
-					"disabling 16M linear map alignment");
+				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
 			aligned = false;
 		}
 




Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F4741A0260
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 16:28:33 +1000 (AEST)
Received: by widdq5 with SMTP id dq5so7468230wid.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 23:28:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 21 Aug 2015 08:28:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 3/8] jump_label: introduce
 DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
Message-ID: <20150821062826.GA566@gmail.com>
References: <1440072876-8321-1-git-send-email-haokexin@gmail.com>
 <1440072876-8321-4-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440072876-8321-4-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kevin Hao <haokexin@gmail.com> wrote:

> These are used to define a static_key_{true,false} array.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  include/linux/jump_label.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 7f653e8f6690..5c1d6a49dd6b 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -267,6 +267,12 @@ struct static_key_false {
>  #define DEFINE_STATIC_KEY_FALSE(name)	\
>  	struct static_key_false name = STATIC_KEY_FALSE_INIT
>  
> +#define DEFINE_STATIC_KEY_TRUE_ARRAY(name, n)	\
> +	struct static_key_true name[n] = { [0 ... n - 1] = STATIC_KEY_TRUE_INIT }
> +
> +#define DEFINE_STATIC_KEY_FALSE_ARRAY(name, n)	\
> +	struct static_key_false name[n] = { [0 ... n - 1] = STATIC_KEY_FALSE_INIT }

I think the define makes the code more obfuscated and less clear, the open-coded 
initialization is pretty dense and easy to read to begin with.

Thanks,

	Ingo

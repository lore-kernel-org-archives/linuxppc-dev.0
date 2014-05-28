Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0051.hostedemail.com
 [216.40.44.51])
 by lists.ozlabs.org (Postfix) with ESMTP id DEBA11A0590
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 10:49:47 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id B2E8828F933
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 00:44:35 +0000 (UTC)
Message-ID: <1401237869.20587.12.camel@joe-AO725>
Subject: Re: [PATCH 11/16] byteorder: provide a linux/byteorder.h with
 {be,le}_to_cpu() and cpu_to_{be,le}() macros
From: Joe Perches <joe@perches.com>
To: Cody P Schafer <dev@codyps.com>
Date: Tue, 27 May 2014 17:44:29 -0700
In-Reply-To: <1401236684-10579-12-git-send-email-dev@codyps.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
 <1401236684-10579-12-git-send-email-dev@codyps.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-05-27 at 17:22 -0700, Cody P Schafer wrote:
> Rather manually specifying the size of the integer to be converted, key
> off of the type size. Reduces duplicate size info and the occurance of
> certain types of bugs (using the wrong sized conversion).
[]
> diff --git a/include/linux/byteorder.h b/include/linux/byteorder.h
[]
> @@ -0,0 +1,34 @@
> +#ifndef LINUX_BYTEORDER_H_
> +#define LINUX_BYTEORDER_H_
> +
> +#include <asm/byteorder.h>
> +
> +#define be_to_cpu(v) \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), be16_to_cpu(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), be32_to_cpu(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), be64_to_cpu(v), \
> +		(void)0))))

probably better to use BUILD_BUG instead of these 0 returns

> +
> +#define le_to_cpu(v) \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), le16_to_cpu(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), le32_to_cpu(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), le64_to_cpu(v), \
> +		(void)0))))
> +
> +#define cpu_to_le(v) \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), cpu_to_le16(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), cpu_to_le32(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), cpu_to_le64(v), \
> +		(void)0))))
> +
> +#define cpu_to_be(v) \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint8_t) , v,	\
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint16_t), cpu_to_be16(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint32_t), cpu_to_be32(v), \
> +	__builtin_choose_expr(sizeof(v) == sizeof(uint64_t), cpu_to_be64(v), \
> +		(void)0))))
> +
> +#endif

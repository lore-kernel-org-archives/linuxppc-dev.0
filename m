Return-Path: <tommusta@gmail.com>
Received: from mail-yh0-x22a.google.com (mail-yh0-x22a.google.com
 [IPv6:2607:f8b0:4002:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C18862C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 01:05:18 +1100 (EST)
Received: by mail-yh0-f42.google.com with SMTP id z6so8817100yhz.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Dec 2013 06:05:14 -0800 (PST)
Received: from [9.10.80.74] (rchp4.rochester.ibm.com. [129.42.161.36])
 by mx.google.com with ESMTPSA id h66sm68032078yhb.7.2013.12.02.06.05.12
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 02 Dec 2013 06:05:12 -0800 (PST)
Message-ID: <529C9397.9050704@gmail.com>
Date: Mon, 02 Dec 2013 08:05:11 -0600
From: Tom Musta <tommusta@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: fix xmon disassembler for little-endian
References: <1385975412-25869-1-git-send-email-felix@linux.vnet.ibm.com>
In-Reply-To: <1385975412-25869-1-git-send-email-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/2/2013 3:10 AM, Philippe Bergheaud wrote:
> This patch fixes the disassembler of the powerpc kernel debugger xmon,
> for little-endian.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index af9d346..6c27804 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -171,7 +171,11 @@ extern void xmon_leave(void);
>  #define REG		"%.8lx"
>  #endif
>  
> +#ifdef __LITTLE_ENDIAN__
> +#define GETWORD(v)	(((v)[3] << 24) + ((v)[2] << 16) + ((v)[1] << 8) + (v)[0])
> +#else
>  #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
> +#endif
>  
>  #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
>  			 || ('a' <= (c) && (c) <= 'f') \
> 

Philippe:  Wouldn't it be better to just do a 32-bit load and let the endianness be worked out
by the hardware?  i.e.

#define GETWORD(v) (*(u32 *)v)


Tom

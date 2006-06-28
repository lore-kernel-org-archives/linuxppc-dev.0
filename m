Return-Path: <mbligh@google.com>
Message-ID: <44A29582.7050403@google.com>
Date: Wed, 28 Jun 2006 07:43:14 -0700
From: "Martin J. Bligh" <mbligh@google.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org>
	<20060628034748.018eecac.akpm@osdl.org>
In-Reply-To: <20060628034748.018eecac.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: jeremy@goop.org, drfickle@us.ibm.com, linux-kernel@vger.kernel.org,
	mbligh@mbligh.org, linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:
> On Wed, 28 Jun 2006 03:42:15 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>his is caused by the vsprintf() changes.  Right now, if you do
>>
>>	snprintf(buf, 4, "1111111111111");
>>
>>the memory at `buf' gets [31 31 31 31 00], which is not good.
>>
>>This'll plug it, but I didn't check very hard whether it still has any
>>off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..

Aha, you're a genius! How the hell did you figure that one out?

Andy / Steve ... any chance one of you could kick this through the
harness? Against -git10 or so, I'd think

Thanks,

M.

> That diff was against an older kernel and doesn't apply.  This is against
> mainline:
> 
> --- a/lib/vsprintf.c~vsnprintf-fix
> +++ a/lib/vsprintf.c
> @@ -259,7 +259,9 @@ int vsnprintf(char *buf, size_t size, co
>  	int len;
>  	unsigned long long num;
>  	int i, base;
> -	char *str, *end, c;
> +	char *str;		/* Where we're writing to */
> +	char *end;		/* The last byte we can write to */
> +	char c;
>  	const char *s;
>  
>  	int flags;		/* flags to number() */
> @@ -283,12 +285,12 @@ int vsnprintf(char *buf, size_t size, co
>  	}
>  
>  	str = buf;
> -	end = buf + size;
> +	end = buf + size - 1;
>  
>  	/* Make sure end is always >= buf */
> -	if (end < buf) {
> +	if (end < buf - 1) {
>  		end = ((void *)-1);
> -		size = end - buf;
> +		size = end - buf + 1;
>  	}
>  
>  	for (; *fmt ; ++fmt) {
> @@ -494,7 +496,6 @@ int vsnprintf(char *buf, size_t size, co
>  	/* the trailing null byte doesn't count towards the total */
>  	return str-buf;
>  }
> -
>  EXPORT_SYMBOL(vsnprintf);
>  
>  /**
> _
> 

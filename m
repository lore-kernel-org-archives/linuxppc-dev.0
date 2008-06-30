Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18536.38684.384039.662264@cargo.ozlabs.ibm.com>
Date: Mon, 30 Jun 2008 18:19:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Eric B Munson <ebmunson@us.ibm.com>
Subject: Re: [PATCH V2] Keep 3 high personality bytes across exec
In-Reply-To: <20080628000813.GA19960@us.ibm.com>
References: <20080628000813.GA19960@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric B Munson writes:

> --- a/include/asm-powerpc/elf.h
> +++ b/include/asm-powerpc/elf.h
> @@ -257,7 +257,8 @@ do {								\
>  	else							\
>  		clear_thread_flag(TIF_ABI_PENDING);		\
>  	if (personality(current->personality) != PER_LINUX32)	\
> -		set_personality(PER_LINUX);			\
> +		set_personality(PER_LINUX |			\
> +			(current->personality & PER_INHERIT));	\

Couldn't we use ~PER_MASK here instead of PER_INHERIT?  That would
mean we wouldn't have to modify include/linux/personality.h, and we
wouldn't have to keep updating PER_INHERIT as more flags get added.

(Nice patch description, BTW.  Thanks.)

Paul.

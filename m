Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: mjw@us.ibm.com, Michael Wolf <mjw@linux.vnet.ibm.com>
Subject: Re: powerpc/ptrace: Fix bug in signal handling
In-reply-to: <1298406645.9824.3.camel@w500>
References: <1298406645.9824.3.camel@w500>
Date: Thu, 24 Feb 2011 11:02:11 +1100
Message-ID: <10535.1298505731@neuling.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mike,

> Subject: powerpc/ptrace: Fix bug in signal handling

Maybe something more descriptive here like:
  powerpc/ptrace: remove BUG_ON when full register set not available

> In some cases during a threaded core dump not all 
> the threads will have a full register set.  This
> will cause problems when the sigkill is sent to
> the thread

Please add a description for how you are solving this.  Something like
"Solve this by putting poison values in the registers".  Similar inline
comments would be good too.

Also, I'm not convinced this is the right solution... not that I have a
have a better one to suggest :-)

<snip>

> +static inline int user_regset_copyout_poison(unsigned int *pos,
> +					   unsigned int *count,
> +					   void **kbuf, void __user **ubuf,
> +					   const int start_pos,
> +					   const int end_pos)
> +{
> +	long poison_data[17] = { [0 ... 16] = 0xdeadbeefdeadbeefUL };

Why only poison 17 registers?

Mikey

Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CEFA72C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2013 05:17:21 +1100 (EST)
Message-ID: <1358273835.2782.5.camel@pasglop>
Subject: Re: [PATCH] powerpc: added DSCR support to ptrace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 16 Jan 2013 05:17:15 +1100
In-Reply-To: <1357885749-14042-1-git-send-email-aik@ozlabs.ru>
References: <1357885749-14042-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-01-11 at 17:29 +1100, Alexey Kardashevskiy wrote:
> +static unsigned long get_user_dscr(struct task_struct *task)
> +{
> +       return -EIO;
> +}
> +

Does it make sense to return an error here ? ptrace_get_reg() doesn't
seem to have provisions for returning errors, it just return register
values, there's no way to differenciate an error code from a register
value as far as I can tell...

I'll apply your patch anyway because this is an existing problem with
that function (it already returns -EIO in other circumstances), but I
would like if you could submit a followup patch that changes it to
return the register by value and return a real error code, which can be
then handled properly in the two call sites (ptrace.c and ptrace32.c).

Cheers,
Ben.

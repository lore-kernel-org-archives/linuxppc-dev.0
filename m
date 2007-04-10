Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070410111508.GA2969@localhost.localdomain>
References: <20070410111508.GA2969@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca57c91a479a78be2f0004a40695f1ba@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 3/3] cell: prevent alignment interrupt on local store
Date: Tue, 10 Apr 2007 14:52:33 +0200
To: Akinobu Mita <mita@fixstars.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> An Alignment interrupt occurs when the instruction is lmw, stmw, lswi, 
> lswx,
> stswi, or stswx, and the operand is in local store.
>
> GCC generated such instructions to handle memcpy() instead of kernel
> defined memcpy() without -mno-string option.

> +# An Alignment interrupt occurs when the instruction is lmw, stmw, 
> lswi, lswx,
> +# stswi, or stswx, and the operand is in local store.
> +CFLAGS_run.o := -mno-string
> +CFLAGS_file.o := -mno-string

NAK.  Please use memcpy_fromio() and friends instead,
that's what they're there for.  I believe Arnd was working
on this?

Your patch is only a partial solution, you'd need -mno-multiple
-mno-algebraic -mno-dcbz too (and two of those don't even
exist).


Segher

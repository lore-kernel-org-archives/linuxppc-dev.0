Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D5551B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 20:50:22 +1000 (EST)
Message-ID: <4A61A48D.8060601@ru.mvista.com>
Date: Sat, 18 Jul 2009 14:31:41 +0400
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: HongWoo Lee <hongwoo7@gmail.com>
Subject: Re: Simple question about powerpc asm.
References: <4A6194D8.9090602@gmail.com>
In-Reply-To: <4A6194D8.9090602@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

HongWoo Lee wrote:
> Hi all,
> 
> I was reading kernel level source and found this macro.
> 
> #define SET_REG_TO_LABEL(reg, label)                \
>    lis     reg,(label)@highest;                    \
>    ori     reg,reg,(label)@higher;                 \
>    rldicr  reg,reg,32,31;                          \
>    oris    reg,reg,(label)@h;                      \
>    ori     reg,reg,(label)@l;
> 
> But, I couldn't find any clue related with @highest, @higher, @h, @l.
> 
> If anybody know about this directives(?), please explain it.
> Or just let me know the keyword, so I can search with those keyword.
> 

PowerPC instructions are 32-bit long. So, there are only 16 bits 
available within the instruction for constant values. Since address can 
be up to 64 bits, we have to load it a piece at a time. The "@" within 
the assembler instruct it to give a specially-processed form of a symbol 
value:

@highest -- refers to bits 48-63 of a constant
@higher -- refers to bits 32-47 of a constant
@h -- refers to bits 16-31 of a constant
@l -- refers to bits 0-15 of a constant

> Thanks in advance.
> 
> HongWoo.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

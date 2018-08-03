Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0249.hostedemail.com
 [216.40.44.249])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hXDj3VvSzF2D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 13:13:24 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave03.hostedemail.com (Postfix) with ESMTP id B9A0718002057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 01:23:34 +0000 (UTC)
Message-ID: <f6d9bc125a4b8e6cd4358c5dd9656730a7716b23.camel@perches.com>
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
From: Joe Perches <joe@perches.com>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Christophe LEROY
 <christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Balbir Singh
 <bsingharora@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Cyril Bur <cyrilbur@gmail.com>, "Eric W . Biederman"
 <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael
 Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, Paul
 Mackerras <paulus@samba.org>, Simon Guo <wei.guo.simon@gmail.com>, Sukadev
 Bhattiprolu <sukadev@linux.vnet.ibm.com>, "Tobin C . Harding"
 <me@tobin.cc>,  linuxppc-dev@lists.ozlabs.org, Segher Boessenkool
 <segher@kernel.crashing.org>
Date: Thu, 02 Aug 2018 18:22:29 -0700
In-Reply-To: <20180803004201.GA5891@kermit-br-ibm-com>
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
 <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
 <20180803004201.GA5891@kermit-br-ibm-com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-02 at 21:42 -0300, Murilo Opsfelder Araujo wrote:
> > > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
[]
> > > @@ -1299,6 +1299,46 @@ static void show_instructions(struct pt_regs *regs)
> > >   	pr_cont("\n");
> > >   }
> > > +void show_user_instructions(struct pt_regs *regs)
> > > +{
> > > +	int i;
> > > +	const char *prefix = KERN_INFO "%s[%d]: code: ";
> > > +	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
> > > +					sizeof(int));
> > > +
> > > +	printk(prefix, current->comm, current->pid);
> > 
> > Why not use pr_info() and remove KERN_INFO from *prefix ?
> 
> Because it doesn't compile:
> 
>   arch/powerpc/kernel/process.c:1317:10: error: expected ‘)’ before ‘prefix’
>     pr_info(prefix, current->comm, current->pid);
>             ^
>   ./include/linux/printk.h:288:21: note: in definition of macro ‘pr_fmt’
>    #define pr_fmt(fmt) fmt
>                      ^

What being suggested is using:

	pr_info("%s[%d]: code: ", current->comm, current->pid);

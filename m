Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBpMQ62DrzDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 13:18:42 +1000 (AEST)
Date: Tue, 25 Apr 2017 12:18:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 3/7] kprobes: validate the symbol name length
Message-Id: <20170425121831.2868474af583522facd73981@kernel.org>
In-Reply-To: <1492962128.c0nhtlqdo4.astroid@naverao1-tp.none>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170419233750.8552f5de8ce1ed1398807284@kernel.org>
 <1492619420.q0fv2gslsy.astroid@naverao1-tp.none>
 <20170421224236.d1c53002f0b3c4750fd6f664@kernel.org>
 <1492962128.c0nhtlqdo4.astroid@naverao1-tp.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 23 Apr 2017 15:44:32 +0000
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> >> >> +bool is_valid_kprobe_symbol_name(const char *name)
> >> > 
> >> > This just check the length of symbol_name buffer, and can contain
> >> > some invalid chars.
> >> 
> >> Yes, I kept the function name generic incase we would like to do more 
> >> validation in future, plus it's shorter than 
> >> is_valid_kprobe_symbol_name_len() ;-)
> > 
> > OK, if this is enough general, we'd better define this in
> > kernel/kallsyms.c or in kallsyms.h. Of course the function
> > should be called is_valid_symbol_name(). :-)
> 
> I actually think this should be done in kprobes itself. The primary 
> intent is to perform such validation right when we first obtain the 
> input from the user. In this case, however, kallsyms_lookup_name() is 
> also an exported symbol, so I do think some validation there would be 
> good to have as well.

IMHO, it is natural that kallsyms will know what is valid symbols.
Providing validation function by kprobes means kprobes also knows
that, and I concerns that may lead a double standard.

Thanks,

> >> >> +{
> >> >> +	size_t sym_len;
> >> >> +	char *s;
> >> >> +
> >> >> +	s = strchr(name, ':');
> >> 
> >> Hmm.. this should be strnchr(). I re-factored the code that moved the 
> >> strnlen() above this below. I'll fix this.
> >> 
> >> >> +	if (s) {
> >> >> +		sym_len = strnlen(s+1, KSYM_NAME_LEN);
> >> > 
> >> > If you use strnlen() here, you just need to ensure sym_len < KSYM_NAME_LEN.
> >> 
> >> Hmm.. not sure I follow. Are you saying the check for sym_len <= 0 is 
> >> not needed?
> > 
> > You can check sym_len != 0, but anyway, here we concern about
> > "longer" string (for performance reason), we can focus on
> > such case.
> > (BTW, could you also check the name != NULL at first?)
> > 
> > So, what I think it can be;
> > 
> > if (strnlen(s+1, KSYM_NAME_LEN) == KSYM_NAME_LEN ||
> >     (size_t)(s - name) >= MODULE_NAME_LEN)
> > 	return false;
> 
> Sure, thanks. I clearly need to refactor this code better!
> 
> - Naveen
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

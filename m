From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14729.3482.592712.436379@argo.linuxcare.com.au>
Date: Thu, 3 Aug 2000 16:13:46 +1000 (EST)
To: Keith Owens <kaos@ocs.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Where does ppc define __start___ksymtab?
In-Reply-To: <28827.965112049@ocs3.ocs-net>
References: <28827.965112049@ocs3.ocs-net>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have been trying to find where ppc defines __start___ksymtab and
> __stop___ksymtab symbols.  These delimit the __ksymtab entries for
> module symbols.  On every other architecture that supports modules,
> arch/xxx/vmlinux.lds contains lines like this
>
>   __start___ksymtab = .;	/* Kernel symbol table */
>   __ksymtab : { *(__ksymtab) }
>   __stop___ksymtab = .;
>
> I can find no equivalent lines for ppc in a stock 2.4.0-test5 source
> tree yet ppc obviously defines them somewhere.  But where?

I think they must be defined automagically by the linker.  They aren't
defined explicitly anywhere but we still end up with a __ksymtab
section with the __start___ksymtab and __stop___ksymtab symbols
defined at the beginning and end of it.

We can add those lines if you like, that's no problem.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

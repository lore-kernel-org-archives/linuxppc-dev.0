Message-ID: <41091EAD.8010302@acm.org>
Date: Thu, 29 Jul 2004 10:58:37 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch for debug setcontext
References: <41090F9A.8000901@mvista.com>
In-Reply-To: <41090F9A.8000901@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I misspoke a little.  Consider the following code in entry.S:

 #ifdef CONFIG_4xx
    /* Check whether this process has its own DBCR0 value */
    lwz    r0,PTRACE(r2)
    andi.    r0,r0,PT_PTRACED
    bnel-    load_4xx_dbcr0
 #endif

Do we need to add the book E define to this, too?

-Corey

Corey Minyard wrote:

>
> Kumar Gala wrote:
>
> > I'm guessing, this should really be #if defined(CONFIG_4xx) ||
> > defined(CONFIG_BOOKE)
> > There are a number of similar cases later in this code as well.
>
> That may be the case, but it is very confusing in entry.S.  The dbcr0
> register seems to only be defined on 4xx processor, not on book E.
> Look, for instance, at load_4xx_dbcr0:, it is only defined if 4xx is
> enabled, not if book E is enabled.
>
> -Corey
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/

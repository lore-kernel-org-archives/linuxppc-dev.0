Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id BA834DDDFE
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 10:30:16 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so483758anc
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:30:15 -0800 (PST)
Message-ID: <fa686aa40711301530k6001d563mb910f10b0d95503c@mail.gmail.com>
Date: Fri, 30 Nov 2007 16:30:15 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] Add a device_initcall to machdep_calls
In-Reply-To: <1196463486.13230.116.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071130225043.12499.86364.stgit@trillian.secretlab.ca>
	<1196463486.13230.116.camel@pasglop>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/30/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Fri, 2007-11-30 at 15:51 -0700, Grant Likely wrote:
> >
> > Add a device_initcall hook to machdep_calls so that platform code
> > doesn't
> > need to register device_initcalls that must first check what platform
> > it is running on.
> >
> > This should (slightly) speed boot time on kernels that support a lot
> > of
> > boards and make device_initcall hooks slightly simpler to implement
> > because the platform doesn't need to be tested when called.
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> >
> > Please comment; I think this is a good change, but I'd like some
> > feedback.
>
> Hrm... I'm not too sure about it...
>
> My initial idea for dealing with that issue was more along the lines of
> defining a set of
>
> machine_xxx_initcall(mach, function)
>
> Where xxx is (arch,core,subsys,fs,device, whatever...)
>
> Those could, at first be implemented as a simple macro wrapper that
> expands to a function that tests machine_is() and calls the function,
> and later one, we can do more fancy things, such as ELF sections with
> function pointers in them.

Is that level of sophistication really warranted for this scenario?
When I'm writing platform code (and granted I'm focused on the
embedded cases) then I've already tested for the board type and I
already know if I want to run that code.  Typically that code is all
contained within a single board file anyway.

I'd rather start with the initcall unregistered and register it when
the board is probed instead of registering by default and testing for
exclusion.

In other words it sound like an O(1) problem being solved with an O(n) solution.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

Return-Path: <satyam.sharma@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.236])
	by ozlabs.org (Postfix) with ESMTP id AB0BBDDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 20:03:56 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so1954552wra
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 03:03:54 -0700 (PDT)
Message-ID: <a781481a0705150303y587ea18dt435f2fc45a671226@mail.gmail.com>
Date: Tue, 15 May 2007 15:33:50 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [PATCH 1/2] kbuild: Add "Section mismatch" warning whitelist for
	powerpc
In-Reply-To: <989B956029373F45A0B8AF0297081890B76040@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <a781481a0705141717v2669805aoa590bfd54da7856b@mail.gmail.com>
	<989B956029373F45A0B8AF0297081890B76040@zch01exm26.fsl.freescale.net>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/15/07, Li Yang-r58472 <LeoLi@freescale.com> wrote:
> > [...]
> > Actually, once __init_refok comes in, would we need any other
> > whitelisting mechanism at all? I think the exception patterns in
> > secref_whitelist() and those two other whitelisting functions
> > (init_section_ref_ok and exit_section_ref_ok) could all be
> > subsumed and made redundant if / when __init_refok is used
> > in the actual sources.
>
> I don't think so.  __init_refok can be used to mark special functions
> which are legitimate to reference .init.text/.init.data

But I have slightly different (reversed) semantics for __init_refok
in mind. Basically, we use __init_refok to annotate _callees_
and not _callers_. In short, __init_refok is a _type_ of __init
section that other sections can freely reference to, without
modpost complaining about this. [ had suggested this in some
previous thread earlier ]

The __init_refok-for-callees mechanism could be useful to
reduce duplication, having to mark lesser number of functions,
and also make most of those exception patterns in modpost.c
redundant.

Ultimately, we want modpost to shut up for some known false
positives. Currently we have 9 exception patterns, 'n' number
of special sections hard-coded in modpost.c, 3 whitelisting
functions and also the __init_refok thing that can be used
directly to mark functions in the sources. But modpost
doesn't really care _how_ a particular case got whitelisted.

Using _only_ the __init_refok (easily greppable in the sources)
annotation for callees could help keep all such special cases
manageable and in control, compared to several different ways
to dodge modpost warnings.

> but cannot be used to mark special sections.

Yes, so mark the special _callees_ as __init_refok.

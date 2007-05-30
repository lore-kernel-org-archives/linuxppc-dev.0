Return-Path: <zseries9@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 6860ADDFB1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:48:10 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id c2so193247ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 05:48:09 -0700 (PDT)
Message-ID: <feaf5ed90705300548v57bba9c7v157e01c3af07cf9c@mail.gmail.com>
Date: Wed, 30 May 2007 21:48:08 +0900
From: "Hiroyuki Machida" <Hiroyuki.Mach@gmail.com>
Sender: zseries9@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: Saving to 32 bits of GPRs in signal context
In-Reply-To: <91D21C34-3D3C-4A1F-9B2E-08F336B7EFC4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<18012.61822.197988.279764@cargo.ozlabs.ibm.com>
	<ADB2DAF4-B25F-462D-B552-531D706F57BE@kernel.crashing.org>
	<1180525484.19517.266.camel@localhost.localdomain>
	<91D21C34-3D3C-4A1F-9B2E-08F336B7EFC4@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Steve Munroe <sjmunroe@us.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Reply-To: Hiroyuki.Mach@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2007/5/30, Kumar Gala <galak@kernel.crashing.org>:
>
> On May 30, 2007, at 6:44 AM, Benjamin Herrenschmidt wrote:
>
> > On Wed, 2007-05-30 at 00:32 -0500, Kumar Gala wrote:
> >>> I think actually it would be useful to have the saving/restoring of
> >>> the high 32 bits controlled by a prctl, so that programs have to ask
> >>> explicitly for the new behaviour (and programs that don't want to
> >> use
> >>> the high 32 bits don't incur the extra overhead).
> >>
> >> I like this, it means we can error if HW doesn't support it and
> >> requires applications to do something specific to enable the feature.
> >
> > Yeah well.... I liked the prctl at first.. but then, I though
> > twice :-)
> >
> > Thing is, a typical usage pattern would be some library having a hand
> > optimized tigh loop or something like that using 64 bits registers. An
> > example, would be some memcpy-type thing in glibc.
> >
> > You don't want those things to do prctl's all over the place on behalf
> > of the host application.
>
> Yeah, I can see that being a pain.  However, how would the AT_HWCAP
> make this any easier on the library to detect?  (I might have missed
> that discussion of that magic in the thread).
>

I think same framework as proposed at follwoing URLs,  works.
http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
http://sources.redhat.com/ml/libc-alpha/2006-01/msg00094.html

Hiroyuki..

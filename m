Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 9EA63DDE03
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 04:34:27 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so660934anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 04 Feb 2008 09:34:25 -0800 (PST)
Message-ID: <fa686aa40802040934r7e6782cev43ee88f93beed10a@mail.gmail.com>
Date: Mon, 4 Feb 2008 10:34:25 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bernhard Reiter" <bernhard@intevation.de>,
	"David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
In-Reply-To: <200802041126.21989.bernhard@intevation.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200802031729.12069.bernhard@intevation.de>
	<20080204095121.GA18167@powerlinux.fr>
	<200802041126.21989.bernhard@intevation.de>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/4/08, Bernhard Reiter <bernhard@intevation.de> wrote:
> On Monday 04 February 2008 10:51, Sven Luther wrote:
> > You should normally not need to build the 4xx bootloader part. Make sure
> > that, i don't know why this happens. Can you look into
> > arch/powerpc/boot/Makefile, to see what option enables the 4xx build,
> > and make sure it is disabled in the main config ?
>
> I have tried to do this, but it looks like it is just hardcoded into the
> Makefile  as you can see from the patch. There is probably more that I do not
> understand - thus my report with on the workaround.

The policy decision was made early on to build all of the bootwrapper
bits regardless of whether they are needed by the configured platform
or not.  AFAIK the reason for this is to increase the variety of
platforms and compilers for with the bootwrapper bits are tested on.
Unfortunately, there are bits of 4xx bootwrappers which require
processor specific instructions for manipulating the cache and DCR.

If we're supporting compilers which don't have 440 support, then we'll
need to disable the build of those bits when they aren't needed, but I
don't know the best way to go about this.  David, thoughts?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

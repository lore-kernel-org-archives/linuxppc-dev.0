Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BE93E1007D1
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2010 01:18:42 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 2/3] powerpc: Add support for creating FIT uImages
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40912301457l704c324bk511a207d07218525@mail.gmail.com>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-3-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301457l704c324bk511a207d07218525@mail.gmail.com>
Date: Fri, 01 Jan 2010 15:18:40 +0100
Message-Id: <20100101141840.D6C273F6FF@gemini.denx.de>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kbuild@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant,

In message <fa686aa40912301457l704c324bk511a207d07218525@mail.gmail.com> you wrote:
>
> Unfortunately, the wrapper script is also being used to do things that
> are completely unrelated to creating wrapper binaries.  FIT images
> (and uImages) don't use any of the wrapper bits at all.  In fact, as
> seen in this patch, generating them involves bailing out of the
> wrapper script early to avoid linking the wrapper bits.  I think for
> all types of uImages, the wrapper script is being misused and I don't
> like the extra complexity that it adds.

Agreed.

> Rather than adding new paths to arch/powerpc/boot/wrapper, I would
> rather see a new script used for generating FIT image that isn't
> complicated by all the current wrapper cruft.  Also, the Makefile rule
> doesn't need to depend on $(wrapperbits) which means faster build
> times when only building uImages.
> 
> Bonus points if you also convert the uImage target to use the new
> script; but I'm not demanding that you do that yet.

I think if this is handles in a separate script, the legacy uImage
support must be handled in this new script, too. Otherwise it would be
too difficult to understanmd the relation of the two image formats.

> Finally, you need to add documentation about the new target to
> Documentation/powerpc/bootwrapper.txt.

Let's keep in mind that the uImage formats (both the old legacy and
the new FIT format) are inherently architecture independent. We want
to use this same mechanism for example on ARM, and on other
architectures as well.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
How many Unix hacks does it take to change a light bulb?  Let's  see,
   can you use a shell script for that or does it need a C program?

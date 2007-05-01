Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id C39D6DDFD0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 17:16:35 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so8917ugf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 01 May 2007 00:16:33 -0700 (PDT)
Message-ID: <528646bc0705010016i75b8c48fr5368d07b7ffcbe1b@mail.gmail.com>
Date: Tue, 1 May 2007 01:16:33 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: [PATCH 2/5] [PPC] Merge common virtex header files
In-Reply-To: <4636C377.4070101@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
	<87d51sac8l.fsf@sleipner.barco.com>
	<528646bc0704271149w211bd5cbscb467123ab962703@mail.gmail.com>
	<87slai5vz3.fsf@sleipner.barco.com>
	<528646bc0704292141n322c145cmc3d2606b13b0b053@mail.gmail.com>
	<4636C377.4070101@dlasys.net>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/30/07, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> There are a plethora of bd_info's in the kernel tree. I think that
> u-boot is probably the most common,
> but the u-boot one is huge and full of cruft.

Be realistic; we're talking about 124 bytes (vs 64 bytes for the pico
bd_t).  If memory consumption is a concern, there are far more
interesting targets.  ppcboot.h is butt-ugly, but at least it's
somewhat common.

> There are also likely to be any number for board/loader combinations
> that are not in the kernel.

If its not in mainline, then I'm not concerned about it because then
you're patching anyway.  I made sure it is easy to patch in a new bd_t
so nobody is screwed.

When those board ports are pushed for mainline inclusion, then we can
add the appropriate conditionals to virtex.h, but in the mean time
it's a moot point.

> But I would prefer that if there is a bd_info struct that it be defined
> by the board not virtex.h or virtex.c.

Understood, but  I do not want to encourage that approach between now
and when we jump to arch/powerpc (legacy bootloader support, yadda,
yadda).

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

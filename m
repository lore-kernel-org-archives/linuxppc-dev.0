Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F3FFBB7B98
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 08:39:04 +1100 (EST)
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Endian/__BYTE_ORDER question
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.005CF730@transmode.se>
References: <OF43B135B0.EF8D9CB9-ONC12576C7.00588245-C12576C7.00598135@transmode.se>
	<20100211163328.GC16348@lisas.de>
	<OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.005CF730@transmode.se>
Date: Thu, 11 Feb 2010 22:39:00 +0100
Message-Id: <20100211213900.CF5ECE8CCE4@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Joakim Tjernlund,

In message <OF918AA866.3ED427EB-ONC12576C7.005CBEE4-C12576C7.005CF730@transmode.se> you wrote:
>
> > I have no idea how it is actually done in the kernel code... but gcc
> > defines it:
> >
> > gcc -dM -E -x c - <<<'' | grep ENDIAN
> > #define __BIG_ENDIAN__ 1
> > #define _BIG_ENDIAN 1
> 
> That doesn't define __BYTE_ORDER. Try the same gcc command
> on a file that #includes <stdlib.h> and you will get both
> __BIG_ENDIAN and __LITTLE_ENDIAN

For me this appears to work:

On x86:

	$ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
	#define _ENDIAN_H 1
	#define PDP_ENDIAN __PDP_ENDIAN
	#define __PDP_ENDIAN 3412
	#define BIG_ENDIAN __BIG_ENDIAN
	#define __BYTE_ORDER __LITTLE_ENDIAN
	#define __LITTLE_ENDIAN 1234
	#define __BIG_ENDIAN 4321
	#define LITTLE_ENDIAN __LITTLE_ENDIAN

On PowerPC:

	$ echo '#include <stdlib.h>' | gcc -dM -E -x c - | grep ENDIAN
	#define __BIG_ENDIAN__ 1
	#define __PDP_ENDIAN 3412
	#define __LITTLE_ENDIAN 1234
	#define BIG_ENDIAN __BIG_ENDIAN
	#define _BIG_ENDIAN 1
	#define __BYTE_ORDER __BIG_ENDIAN
	#define _ENDIAN_H 1
	#define __BIG_ENDIAN 4321
	#define PDP_ENDIAN __PDP_ENDIAN
	#define LITTLE_ENDIAN __LITTLE_ENDIAN

In both cases __BYTE_ORDER is set to a sane value.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Copy from one, it's plagiarism; copy from two, it's research.

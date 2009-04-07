Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from pophost.sonytel.be (vervifontaine.sonytel.be [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 0BF41DDFAE
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 22:19:02 +1000 (EST)
Date: Tue, 7 Apr 2009 14:19:01 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Fix oops when loading modules
In-Reply-To: <18906.50854.952483.793456@drongo.ozlabs.ibm.com>
Message-ID: <alpine.LRH.2.00.0904071418430.24773@vixen.sonytel.be>
References: <18906.50854.952483.793456@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 7 Apr 2009, Paul Mackerras wrote:
> This fixes a problem reported by Sean MacLennan where loading any
> module would cause an oops.  We weren't marking the pages containing
> the module text as having hardware execute permission, due to a bug
> introduced in commit 8d1cf34e ("powerpc/mm: Tweak PTE bit combination
> definitions"), hence trying to execute the module text caused an
> exception on processors that support hardware execute permission.
> 
> This adds _PAGE_HWEXEC to the definitions of PAGE_KERNEL_X and
> PAGE_KERNEL_ROX to fix this problem.
> 
> Reported-by: Sean MacLennan <smaclennan@pikatech.com>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Tested-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
(on Sequoia)

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010

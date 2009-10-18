Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D0BAEB7B78
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Oct 2009 00:10:06 +1100 (EST)
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Mixing hard and soft floating point?
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <OFEFBDE7C9.DA9D5B8B-ONC1257653.003E3DC6-C1257653.003F0B37@transmode.se>
References: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
	<20091017181224.97FFBF15432@gemini.denx.de>
	<OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.00651551@transmode.se>
	<20091017193454.7978FF15432@gemini.denx.de>
	<OFEFBDE7C9.DA9D5B8B-ONC1257653.003E3DC6-C1257653.003F0B37@transmode.se>
Date: Sun, 18 Oct 2009 15:10:02 +0200
Message-Id: <20091018131002.B851B3F6F0@gemini.denx.de>
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

In message <OFEFBDE7C9.DA9D5B8B-ONC1257653.003E3DC6-C1257653.003F0B37@transmode.se> you wrote:
>
> > If the application is really using FP instructions a lot, then there
> > is a huge difference between using soft-float and MATH_EMU; I
> > remember test cases where soft-float was faster by factors of
> > 500...1000.
> 
> Ouch, I had no idea that it could be that much.

Well, consider really simple operations, like FP add or similar, and
compare the library code for the soft-FP implementationagainst the
cost for a trap into the kernel. Or even worse - a consider simple
assignment ("float x, foo; x = foo"); with soft-float: "lis 9,x@ha;
stw 3,x@l(9)" = 2 instructions, with MATH_EMU "lis 9,x@ha; stfs
1,x@l(9)" = 1 insn plus a kernel trap.

For real numbers, run a benchmark that models your real use case.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Little known fact about Middle Earth:   The Hobbits had a very sophi-
sticated computer network!   It was a Tolkien Ring...

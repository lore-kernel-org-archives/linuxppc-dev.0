Return-Path: <dave.anglin@bell.net>
Received: from blu0-omc4-s8.blu0.hotmail.com (blu0-omc4-s8.blu0.hotmail.com
 [65.55.111.147]) by ozlabs.org (Postfix) with ESMTP id D819FB6FB9
 for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2012 10:27:54 +1000 (EST)
Message-ID: <BLU0-SMTP3215D3E80BA82F3C6A654197190@phx.gbl>
From: John David Anglin <dave.anglin@bell.net>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1337179563.2985.80.camel@dabdike.int.hansenpartnership.com>
Subject: Re: Build regressions/improvements in v3.4-rc7
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337179563.2985.80.camel@dabdike.int.hansenpartnership.com>
Content-Type: text/plain; charset="US-ASCII"; format=flowed; delsp=yes
MIME-Version: 1.0 (Apple Message framework v936)
Date: Wed, 16 May 2012 20:27:35 -0400
Cc: Parisc List <linux-parisc@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org,
 James Morris <jmorris@namei.org>, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Dmitry Kasatkin <dmitry.kasatkin@intel.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16-May-12, at 10:46 AM, James Bottomley wrote:

> Wow, lib/mpi/ is a complete horror: it's full of hand crafted asm  
> code.
> The error in this case appears to be that umul_ppm() is implemented as
> an xmpyu instruction.  That's a floating point instruction.  We
> deliberately compile the kernel with floating point disabled because  
> we
> don't want to save and restore the floating point register file on  
> each
> context switch, hence the operand constraints are unsatisfiable.

I haven't tried this but I think the parisc implementation of umul_ppmm
can be deleted.  There is a generic version in the file.

Dave
--
John David Anglin	dave.anglin@bell.net

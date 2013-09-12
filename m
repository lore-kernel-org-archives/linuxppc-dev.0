Return-Path: <murzin.v@gmail.com>
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com
 [IPv6:2a00:1450:4010:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62F1F2C0396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 12:53:21 +1000 (EST)
Received: by mail-la0-f47.google.com with SMTP id eo20so8154753lab.34
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 19:53:16 -0700 (PDT)
Date: Thu, 12 Sep 2013 04:52:45 +0200
From: Vladimir Murzin <murzin.v@gmail.com>
To: Matt Evans <matt@ozlabs.org>
Subject: Re: [PATCH] powerpc: net: filter: fix DIVWU instruction opcode
Message-ID: <20130912025241.GA1869@hp530>
References: <1378915410-2262-1-git-send-email-murzin.v@gmail.com>
 <7012.1378945979@ale.ozlabs.ibm.com>
 <79BD1567-A588-4977-BF11-C03045B55884@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
In-Reply-To: <79BD1567-A588-4977-BF11-C03045B55884@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 12, 2013 at 10:28:03AM +0930, Matt Evans wrote:
> On 12 Sep 2013, at 10:02, Michael Neuling <mikey@neuling.org> wrote:
> 
> > Vladimir Murzin <murzin.v@gmail.com> wrote:
> > 
> >> Currently DIVWU stands for *signed* divw opcode:
> >> 
> >> 7d 2a 4b 96    divwu   r9,r10,r9
> >> 7d 2a 4b d6    divw    r9,r10,r9
> >> 
> >> Use the *unsigned* divw opcode for DIVWU.
> > 
> > This looks like it's in only used in the BPF JIT code.  
> > 
> > Matt, any chance you an ACK/NACK this?
> 
> Sure, that looks sensible, thanks Vladimir. 
> 
> Acked-by: Matt Evans <matt@ozlabs.org>
> 

Thanks!

Vladimir

> > 
> > Mikey
> > 
> >> 
> >> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> >> ---
> >> arch/powerpc/include/asm/ppc-opcode.h |    2 +-
> >> 1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
> >> index d7fe9f5..c91842c 100644
> >> --- a/arch/powerpc/include/asm/ppc-opcode.h
> >> +++ b/arch/powerpc/include/asm/ppc-opcode.h
> >> @@ -218,7 +218,7 @@
> >> #define PPC_INST_MULLW            0x7c0001d6
> >> #define PPC_INST_MULHWU            0x7c000016
> >> #define PPC_INST_MULLI            0x1c000000
> >> -#define PPC_INST_DIVWU            0x7c0003d6
> >> +#define PPC_INST_DIVWU            0x7c000396
> >> #define PPC_INST_RLWINM            0x54000000
> >> #define PPC_INST_RLDICR            0x78000004
> >> #define PPC_INST_SLW            0x7c000030
> >> -- 
> >> 1.7.10.4
> >> 

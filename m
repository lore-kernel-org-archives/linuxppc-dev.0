Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 00707DE0A1
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 23:53:49 +1000 (EST)
Date: Mon, 15 Oct 2007 08:59:45 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Add 1TB workaround for PA6T
Message-ID: <20071015135945.GA13417@lixom.net>
References: <20071012064942.GB30829@lixom.net>
	<18194.62797.632192.458851@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18194.62797.632192.458851@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 03:06:21PM +1000, Paul Mackerras wrote:
> Olof Johansson writes:
> 
> > @@ -367,7 +368,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
> >  #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | \
> >  	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
> >  	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
> > -	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
> > +	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
> >  #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | \
> >  	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
> >  
> > @@ -375,7 +376,8 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
> >  #define CPU_FTRS_POSSIBLE	\
> >  	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
> >  	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
> > -	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_1T_SEGMENT)
> > +	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_1T_SEGMENT |	\
> > +	    CPU_FTR_NO_SLBIE_B)
> >  #else
> >  enum {
> >  	CPU_FTRS_POSSIBLE =
> 
> I don't think the second hunk there is necessary, since
> CPU_FTRS_POSSIBLE will already get CPU_FTR_NO_SLBIE_B via
> CPU_FTRS_PA6T.

Oh, you're right. I just tacked it on with the 1T_SEGMENT.

I'll respin today. Ben wanted me to add some comments to the _switch
code as well regarding the slbie.


-Olof

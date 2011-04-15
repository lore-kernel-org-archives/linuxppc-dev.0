Return-Path: <ml@stefan-roese.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.160])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E74A9B6FF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 17:22:53 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: FTrace on MPC8xx
Date: Fri, 15 Apr 2011 09:22:42 +0200
References: <201104131632.21350.ml@stefan-roese.de>
	<OF71C64301.E54A0A3C-ONC1257872.005BD121-C1257872.005C754F@transmode.se>
	<OFDD77B7E3.D5C79015-ONC1257872.0069E657-C1257872.006A5415@transmode.se>
In-Reply-To: <OFDD77B7E3.D5C79015-ONC1257872.0069E657-C1257872.006A5415@transmode.se>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201104150922.43093.ml@stefan-roese.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joakim,

On Thursday 14 April 2011 21:21:23 Joakim Tjernlund wrote:
> > hmm, I guess 8xx really maps kernel RO as RO :) Try
> > 
> > changing in pte-8xx.h:
> >  - #define _PAGE_KERNEL_RO   (_PAGE_SHARED)
> >  + #define _PAGE_KERNEL_RO   (_PAGE_RW |_PAGE_SHARED)
> 
> hmm, I wonder if not this is the problem(in pte-common.h)
> #if defined(CONFIG_KGDB) || defined(CONFIG_XMON) ||
> defined(CONFIG_BDI_SWITCH) ||\ defined(CONFIG_KPROBES)
> #define PAGE_KERNEL_TEXT	PAGE_KERNEL_X
> #else
> #define PAGE_KERNEL_TEXT	PAGE_KERNEL_ROX
> #endif
> 
> What is PAGE_KERNEL_TEXT for you?
> I think it must be PAGE_KERNEL_X, otherwise kernel text will be readonly.

Yes, that's it! Its PAGE_KERNEL_ROX right now. We need to add CONFIG_FTRACE or 
at least CONFIG_DYNAMIC_FTRACE to the #if statement above.

Do you want to send a patch (since you detected the real problem)? Or should I 
do this?

Thanks.

Best regards,
Stefan

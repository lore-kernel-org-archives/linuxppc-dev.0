Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414ltm3j5YzF4DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 20:07:41 +1000 (AEST)
Date: Tue, 12 Jun 2018 12:07:37 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Bharat Bhushan <bharat.bhushan@nxp.com>
Cc: Diana Madalina Craciun <diana.craciun@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "oss@buserror.net" <oss@buserror.net>, Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 3/3] powerpc/fsl: Implement cpu_show_spectre_v1/v2
 for NXP PowerPC Book3E
Message-ID: <20180612120737.31efff1c@naga.suse.cz>
In-Reply-To: <AM5PR0401MB2545BC30FB194E4D4E42ADA89A7F0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
 <1528721608-15443-4-git-send-email-diana.craciun@nxp.com>
 <AM5PR0401MB2545BC30FB194E4D4E42ADA89A7F0@AM5PR0401MB2545.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jun 2018 02:59:11 +0000
Bharat Bhushan <bharat.bhushan@nxp.com> wrote:

> Hi Diana,
> 
> > -----Original Message-----
> > From: Diana Craciun [mailto:diana.craciun@nxp.com]
> > Sent: Monday, June 11, 2018 6:23 PM
> > To: linuxppc-dev@lists.ozlabs.org
> > Cc: mpe@ellerman.id.au; oss@buserror.net; Leo Li
> > <leoyang.li@nxp.com>; Bharat Bhushan <bharat.bhushan@nxp.com>;
> > Diana Madalina Craciun <diana.craciun@nxp.com>
> > Subject: [PATCH v2 3/3] powerpc/fsl: Implement
> > cpu_show_spectre_v1/v2 for NXP PowerPC Book3E  
> 
> Please add some description

To me the subject is self-explanatory. It implements a kernel interface
that was already described elsewhere.

What are you missing here?

Thanks

Michal

> 
> > 
> > Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
> > ---
> >  arch/powerpc/Kconfig           |  2 +-
> >  arch/powerpc/kernel/security.c | 15 +++++++++++++++
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig index
> > 940c955..a781d60 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -170,7 +170,7 @@ config PPC
> >  	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
> >  	select GENERIC_CMOS_UPDATE
> >  	select GENERIC_CPU_AUTOPROBE
> > -	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
> > +	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
> > || PPC_FSL_BOOK3E
> >  	select GENERIC_IRQ_SHOW
> >  	select GENERIC_IRQ_SHOW_LEVEL
> >  	select GENERIC_SMP_IDLE_THREAD
> > diff --git a/arch/powerpc/kernel/security.c
> > b/arch/powerpc/kernel/security.c index 797c975..aceaadc 100644
> > --- a/arch/powerpc/kernel/security.c
> > +++ b/arch/powerpc/kernel/security.c
> > @@ -183,3 +183,18 @@ ssize_t cpu_show_spectre_v2(struct device *dev,
> > struct device_attribute *attr, c  }  #endif /* CONFIG_PPC_BOOK3S_64
> > */
> > 
> > +#ifdef CONFIG_PPC_FSL_BOOK3E
> > +ssize_t cpu_show_spectre_v1(struct device *dev, struct
> > device_attribute +*attr, char *buf) {
> > +	if (barrier_nospec_enabled)
> > +		return sprintf(buf, "Mitigation: __user pointer
> > sanitization\n"); +
> > +	return sprintf(buf, "Vulnerable\n");
> > +}
> > +
> > +ssize_t cpu_show_spectre_v2(struct device *dev, struct
> > device_attribute +*attr, char *buf) {
> > +	return sprintf(buf, "Vulnerable\n");
> > +}
> > +#endif /* CONFIG_PPC_FSL_BOOK3E */
> > +
> > --
> > 2.5.5  
> 

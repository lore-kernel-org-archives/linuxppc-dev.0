Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0111.outbound.protection.outlook.com [157.56.110.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF18D1A0895
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Apr 2015 02:51:04 +1100 (AEDT)
Message-ID: <1427989850.22867.266.camel@freescale.com>
Subject: Re: [2/4] powerpc/rcpm: add RCPM driver
From: Scott Wood <scottwood@freescale.com>
To: Zhao Chenhui-B35336 <chenhui.zhao@freescale.com>
Date: Thu, 2 Apr 2015 10:50:50 -0500
In-Reply-To: <1427970805609.21194@freescale.com>
References: <1427365095-26396-2-git-send-email-chenhui.zhao@freescale.com>
 ,<20150331013057.GB5667@home.buserror.net>
 <1427970805609.21194@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jin
 Zhengxiong-R64188 <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-02 at 05:33 -0500, Zhao Chenhui-B35336 wrote:
> > +static int rcpm_v2_plat_enter_state(int state)
> > +{
> > +     u32 *pmcsr_reg = &rcpm_v2_regs->powmgtcsr;
> > +     int ret = 0;
> > +     int result;
> > +
> > +     switch (state) {
> > +     case PLAT_PM_LPM20:
> > +             /* clear previous LPM20 status */
> > +             setbits32(pmcsr_reg, RCPM_POWMGTCSR_P_LPM20_ST);
> 
> How would the bit be set when you enter here, given that you wait for it
> to clear when leaving?
> 
> [chenhui] Actually, the bit is not used by software. Just follow the instruction in RM.

Sorry, I missed the "_P_" and thought it was RCPM_POWMGTCSR_LPM20_ST.

-Scott

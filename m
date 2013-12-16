Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC0EB2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 05:26:45 +1100 (EST)
Message-ID: <1387218364.10013.351.camel@snotra.buserror.net>
Subject: Re: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and
 altivec idle
From: Scott Wood <scottwood@freescale.com>
To: Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
Date: Mon, 16 Dec 2013 12:26:04 -0600
In-Reply-To: <0ba4966fa6b54478b2885a0b97f4c2bf@BY2PR03MB191.namprd03.prod.outlook.com>
References: <1381828871-17110-1-git-send-email-dongsheng.wang@freescale.com>
 <1381828871-17110-4-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C08E4@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B1799@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C3279@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B189E@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C34C1@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B195F@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071C362B@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010B33C3@039-SN2MPN1-021.039d.mgd.msft.net>
 <1382124094.7979.885.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BBC86@039-SN2MPN1-021.039d.mgd.msft.net>
 <1383601901.25829.33.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BC83B@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071E442A@039-SN2MPN1-013.039d.mgd.msft.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BD119@039-SN2MPN1-021.039d.mgd.msft.net>
 <1383787214.23598.96.camel@snotra.buserror.net>
 <ABB05CD9C9F68C46A5CEDC7F15439259010BF40C@039-SN2MPN1-021.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071EEABB@039-SN2MPN1-013.039d.mgd.msft.net>
 <0ba4966fa6b54478b2885a0b97f4c2bf@BY2PR03MB191.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Bhushan Bharat-R65777 <Bharat.Bhushan@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-12-15 at 23:53 -0600, Wang Dongsheng-B40534 wrote:
> 
> > -----Original Message-----
> > From: Bhushan Bharat-R65777
> > Sent: Monday, November 11, 2013 12:11 PM
> > To: Wang Dongsheng-B40534; Wood Scott-B07421
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: RE: [PATCH v5 4/4] powerpc/85xx: add sysfs for pw20 state and altivec
> > idle
> > 
> > > > Those codes just for discuss with Bharat. He want to make one flow at
> > > > "show_pw20_wait_time"/" show_altivec_idle_wait_time" function. If we
> > > > do that, we need to initialize pw20_wt/altivec_idle_wt.
> > > >
> > > I will keep this stuff at "show_pw20_wait_time"/"show_altivec_idle_wait_time"
> > > and add a comment before our discussion.
> > >
> > > /*
> > >  * If the "value" less than 10, this will overflow.
> > >  * From benchmark test, the default wait bit will not be set less than 10bit.
> > >  * Because 10 bit corresponds to the wait entry time is 439375573401999609(ns),
> > >  * for wait-entry-idle time this value looks too long, and we cannot use those
> > >  * "long" time as a default wait-entry time. So overflow could not have
> > happened
> > >  * and we use this calculation method to get wait-entry-idle time.
> > >  */
> > 
> > I think now we will use same calculation code for default value and user set
> > value, so adding the comment is not sufficient, we should error out from the
> > code if value is less than 10. As default value is not less than 10 so this will
> > always work with default value but if user tries to set less than 10 then error
> > out and ask user to try more than 9.
> > 
> Again, once the user has set up a time, the code will go to another branch.
> 
> else {
> 	time = pw20_wt;
> }
> 
> We do so much for this a little function processing is not worth it. If we can't
> agree on this sys interface. I will change this sys interface to show_pw20_wait_bit. :)

Please don't change it.

-Scott

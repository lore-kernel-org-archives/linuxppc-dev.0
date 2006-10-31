Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 0933667BD2
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Nov 2006 09:08:40 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so1385910ugc
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Oct 2006 14:08:39 -0800 (PST)
Message-ID: <528646bc0610311408i3a7a9a7ep11ad54c1779aa4bc@mail.gmail.com>
Date: Tue, 31 Oct 2006 15:08:35 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
In-Reply-To: <1162331943.25682.358.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
	<4546F7DE.6070104@bplan-gmbh.de>
	<1162280335.25682.302.camel@localhost.localdomain>
	<4547086D.2050808@bplan-gmbh.de>
	<1162284176.25682.320.camel@localhost.localdomain>
	<454712A4.3000501@bplan-gmbh.de> <4547AC30.3090208@bplan-gmbh.de>
	<1162331943.25682.358.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/31/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Tue, 2006-10-31 at 21:04 +0100, Nicolas DET wrote:
> > +     /* Matching of PSC function */
> > +struct mpc52xx_psc_func {
> > +     int id;
> > +     char *func;
> > +};
> >
> > +extern int mpc52xx_match_psc_function(int psc_idx, const char *func);
> > +extern struct mpc52xx_psc_func mpc52xx_psc_functions[];
> > +     /* This array is to be defined in platform file */
>
> The above doesn't look like it should migrate to arch/powerpc... what is
> it supposed to be ?

This definitely needs to be removed.  It's used to figure out which
driver should drive a PSC (based on function).  We've got a device
tree to provide this information now.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195

Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 58773DE090
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 17:26:40 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 7/8] powerpc/5200: Refactor mpc5200 interrupt controller
	driver
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40901251622j542b6029u83c510f5b4e2f92@mail.gmail.com>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205540.31232.77034.stgit@localhost.localdomain>
	<497CC632.2000402@grandegger.com>
	<fa686aa40901251622j542b6029u83c510f5b4e2f92@mail.gmail.com>
Date: Mon, 26 Jan 2009 07:26:36 +0100
Message-Id: <20090126062636.D3375832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant Likely,

In message <fa686aa40901251622j542b6029u83c510f5b4e2f92@mail.gmail.com> you wrote:
>
> >> -     case IRQF_TRIGGER_HIGH:
> >> -             type = 0;
> >> -             break;
> >> -     case IRQF_TRIGGER_RISING:
> >> -             type = 1;
> >> -             break;
> >> -     case IRQF_TRIGGER_FALLING:
> >> -             type = 2;
> >> -             break;
> >> -     case IRQF_TRIGGER_LOW:
> >> -             type = 3;
> >> -             break;
> >> +     case IRQF_TRIGGER_HIGH: type = 0; break;
> >> +     case IRQF_TRIGGER_RISING: type = 1; handler = handle_edge_irq; break;
> >> +     case IRQF_TRIGGER_FALLING: type = 2; handler = handle_edge_irq; break;
> >> +     case IRQF_TRIGGER_LOW: type = 3; break;
> >
> > The Linux coding style tells us not to do that:
...
> In principle I agree and follow that rule most of the time, but I have
> good reason for not choosing to do so here.
> 
> The whole point of coding style is to promote
> readability/manageability.  ie. the 80 column rule is a very strong
> guideline, but there are places where breaking that rule makes for
> more readable code than breaking things up and it is left to the
> discretion of the coder and the maintainer.

It's not so much the line length, IMO.

It's "Don't put multiple statements on a single line", plus
readability.

I think the new version is more difficult to read. It's plain ugly,
and inconsistent.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is common sense to take a method and try it. If it fails, admit it
frankly and try another. But above all, try something.
                                              - Franklin D. Roosevelt

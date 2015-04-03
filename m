Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C71EC1A09FD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 07:24:26 +1100 (AEDT)
Message-ID: <1428092654.22867.339.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc/83xx: add support for mpc8306
From: Scott Wood <scottwood@freescale.com>
To: Filip =?UTF-8?Q?Brozovi=C4=87?= <fbrozovic@gmail.com>
Date: Fri, 3 Apr 2015 15:24:14 -0500
In-Reply-To: <551E8B65.5010400@gmail.com>
References: <1428057856-26421-1-git-send-email-fbrozovic@gmail.com>
 <1428062487.7898.12.camel@x220> <551E8B65.5010400@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Bolle <pebolle@tiscali.nl>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-03 at 14:45 +0200, Filip Brozović wrote:
> On 4/3/2015 2:01 PM, Paul Bolle wrote:
> > On Fri, 2015-04-03 at 12:44 +0200, Filip Brozovic wrote:
> >> --- a/arch/powerpc/platforms/83xx/Kconfig
> >> +++ b/arch/powerpc/platforms/83xx/Kconfig
> >
> >> +# used for gpio
> >> +config PPC_MPC830x
> >> +	bool
> >> +	select ARCH_WANT_OPTIONAL_GPIOLIB
> >> +
> >> +config PPC_MPC8306
> >> +	bool
> >
> > To me these two new Kconfig symbols look pointless:
> > - they have no prompt, so one cannot set them manually;
> > - no other Kconfig symbol selects them;
> > - they do not default to 'y'.
> >
> > I'm not aware of a way to set these symbols to 'y' outside of those
> > three. Is there perhaps a way for kconfig to set these symbols to 'y'
> > that I have missed?
> >
> > Or do you expect to do one of these three things in a separate patch?
> >
> 
> The idea was that boards in the Kconfig file would select these symbols 
> in order to enable support for the 8306. I mainly wanted to get this 
> patch into mainline in order to make kernel maintenance for a couple of 
> custom in-house developed boards easier. Since these boards are not 
> widely available and our customers are unlikely to want to change and 
> recompile the kernel, I have so far leaned towards not including support 
> for them in mainline. As far as I can see, boards which are included in 
> mainline right now are mostly evaluation boards which are easily 
> available at most electronics distributors.
> 
> That being said, I don't know what the "official" stance on this is; is 
> adding custom boards encouraged regardless of their availability (e.g. 
> if I develop a custom board with the intention of only ever actually 
> making a single prototype for personal use, should I go and submit 
> patches so that support makes it into the mainline kernel?), or should 
> there be a minimum level of public interest before incorporating custom 
> boards into mainline? If it's the latter, I suppose a solution would be 
> to include support for the Freescale MPC8306SOM in mainline. Of course, 
> this has its own problems, since someone would have to write and 
> maintain it (and I don't have an MPC8306SOM nor the time needed to do 
> maintenance).

Custom boards are fine as long as someone will maintain them.

What are you using PPC_MPC8306 for in your custom board code?

-Scott

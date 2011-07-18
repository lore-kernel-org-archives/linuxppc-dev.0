Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E80CB6F72
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2011 01:56:37 +1000 (EST)
Date: Mon, 18 Jul 2011 10:56:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
Message-ID: <20110718105627.245c9fa4@schlenkerla.am.freescale.net>
In-Reply-To: <82C960D7DF4A1F47B94FC1C67A29BEE384D577@ALA-MBA.corp.ad.wrs.com>
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>
	<4E1FCFEF.7070702@windriver.com>
	<20110715134232.56373e03@schlenkerla.am.freescale.net>
	<82C960D7DF4A1F47B94FC1C67A29BEE384D577@ALA-MBA.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 16 Jul 2011 03:25:47 +0000
"Chen, Tiejun" <Tiejun.Chen@windriver.com> wrote:

> > -----Original Message-----
> > From: Scott Wood [mailto:scottwood@freescale.com] 
> > Sent: Saturday, July 16, 2011 2:43 AM
> > To: Chen, Tiejun
> > Cc: Kumar Gala; linuxppc-dev@ozlabs.org
> > Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program 
> > exception to use one dedicated exception stack
> > 
> > On Fri, 15 Jul 2011 13:28:15 +0800
> > tiejun.chen <tiejun.chen@windriver.com> wrote:
> > 
> > > Kumar Gala wrote:
> > > > I'm still very confused why we need a unique stack frame 
> > for kprobe/program exceptions on book-e devices.
> > > 
> > > Its a bug at least for Book-E.
> > 
> > But why only booke?  There's nothing booke-specific about the 
> 
> I don't mean this is reproduced only on booke, so I use 'at least' carefully to notice we really see this problem on booke.
> 
> > stwu instruction.
> 
> Please note this root cause to this bug is not related to how to emulate stwu instruction. That should be issued from the overlap between an exception frame and the kprobed function stack frame on booke. Would you like to see that example I showed?

As I understand it, the problem comes from the fact that stwu combines the
creation of a stack frame with storing into that stack frame.  If they were
separate instructions you'd have a new exception frame at a lower address
by the time you actually store to the non-exception frame.

-Scott

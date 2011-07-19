Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 643E4B6F77
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2011 20:53:08 +1000 (EST)
Message-ID: <4E2561F0.5040701@windriver.com>
Date: Tue, 19 Jul 2011 18:52:32 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>	<4E1FCFEF.7070702@windriver.com>	<20110715134232.56373e03@schlenkerla.am.freescale.net>	<82C960D7DF4A1F47B94FC1C67A29BEE384D577@ALA-MBA.corp.ad.wrs.com>
	<20110718105627.245c9fa4@schlenkerla.am.freescale.net>
In-Reply-To: <20110718105627.245c9fa4@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Sat, 16 Jul 2011 03:25:47 +0000
> "Chen, Tiejun" <Tiejun.Chen@windriver.com> wrote:
> 
>>> -----Original Message-----
>>> From: Scott Wood [mailto:scottwood@freescale.com] 
>>> Sent: Saturday, July 16, 2011 2:43 AM
>>> To: Chen, Tiejun
>>> Cc: Kumar Gala; linuxppc-dev@ozlabs.org
>>> Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program 
>>> exception to use one dedicated exception stack
>>>
>>> On Fri, 15 Jul 2011 13:28:15 +0800
>>> tiejun.chen <tiejun.chen@windriver.com> wrote:
>>>
>>>> Kumar Gala wrote:
>>>>> I'm still very confused why we need a unique stack frame 
>>> for kprobe/program exceptions on book-e devices.
>>>> Its a bug at least for Book-E.
>>> But why only booke?  There's nothing booke-specific about the 
>> I don't mean this is reproduced only on booke, so I use 'at least' carefully to notice we really see this problem on booke.
>>
>>> stwu instruction.
>> Please note this root cause to this bug is not related to how to emulate stwu instruction. That should be issued from the overlap between an exception frame and the kprobed function stack frame on booke. Would you like to see that example I showed?
> 
> As I understand it, the problem comes from the fact that stwu combines the
> creation of a stack frame with storing into that stack frame.  If they were

Yes.

> separate instructions you'd have a new exception frame at a lower address
> by the time you actually store to the non-exception frame.

So when kprobe we should use a unique stack frame to skip that stack frame the
kprobed stwu want to create.

Tiejun

> 
> -Scott
> 
> 

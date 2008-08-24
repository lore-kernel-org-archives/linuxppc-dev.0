Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DB194DDDF5
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 04:55:50 +1000 (EST)
To: Zhou Rui <vancasperz@yahoo.com.cn>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Why does one "stw" fail with address translation disabled in
	PPC405EP?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <1219479992.7565.17.camel@localhost>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
	<20080822184213.GA24526@yoda.jdub.homelinux.org>
	<1219479992.7565.17.camel@localhost>
Date: Sun, 24 Aug 2008 20:55:47 +0200
Sender: wd@denx.de
Message-Id: <20080824185547.94A0724899@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Zhou Rui,

In message <1219479992.7565.17.camel@localhost> you wrote:
>
> > >    I am running a kernel module which will execute a user space
> > >application. The entry point of the application is 0x100000a0. At the
> > 
> > That should be the first clue that you are doing it wrong.  Don't do
> > stuff like that in modules...
> 
> Oh, but our project needs a function like that ...

You should really think about this. Why do you think you  need  this?
What  exactly  are  you  trying  to  do?  [Probably  there are better
approaches to solve your problem...]

> It is physical address at this moment. Address translation is disabled
> automatically (MSR[IR, DR] = [0, 0]) because of TLB Miss Exception and
> Instrunction Storage Exception.

Hm.. are you absolutely sure that the 0x100000a0 mentioned above is a
physical address?

> > Do you have enough DRAM to cover that?  Some of those boards only come
> > with 32MiB of DRAM.
> 
> My board only has 32MB DRAM. Do you mean 32MB is not enough for that?

Well, 0x1000'00A0 is above 256 MB, while you  have  only  32  MB  RAM
which is most probably mapped from 0x0000'0000...0x01FF'FFFF... So
what you claim to be a physical address (and I think your claim is
wrong) is far outside available physical memory.

> The same codes can run well in a PPC440EP (Yosemite Board) which owns
> 256MB DRAM. At the beginning of my work, I thought memory size may be
> the cause of failure. But I did not know how to demonstrate it. So if
> the limitation of 32MB DRAM leads to the failure, are there any methods
> for the codes to solve it?

I think you got lost on the wrong track. Please describe  which  task
you  want  to  implement, and there might be another, better approach
for it.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The management question ... is not _whether_ to build a pilot  system
and  throw  it away. You _will_ do that. The only question is whether
to plan in advance to build a throwaway, or to promise to deliver the
throwaway to customers.       - Fred Brooks, "The Mythical Man Month"

Return-Path: <ericvh@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39198B6FE0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 13:24:13 +1000 (EST)
Received: by fxm5 with SMTP id 5so1506359fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Jun 2011 20:24:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1307662948.2874.293.camel@pasglop>
References: <1307482573-25440-1-git-send-email-ericvh@gmail.com>
	<1307494057.2874.212.camel@pasglop>
	<BANLkTinD+1+QTUhKvQP-T_bZgbi1YS1jwQ@mail.gmail.com>
	<1307662948.2874.293.camel@pasglop>
From: Eric Van Hensbergen <ericvh@gmail.com>
Date: Thu, 9 Jun 2011 22:23:20 -0500
Message-ID: <BANLkTikRYDH3K1wOdMzzvVP--frRezVnRQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC][V3] bluegene: use MMU feature flag to
	conditionalize L1 writethrough code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 9, 2011 at 6:42 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2011-06-09 at 09:58 -0500, Eric Van Hensbergen wrote:
>> On Tue, Jun 7, 2011 at 7:47 PM, Benjamin Herrenschmidt
>> <benh@kernel.crashing.org> wrote:
>> > BTW. Care to explain to me why you have U2 -both- in the arguments to
>> > tlbwe and in MMUCR ? That doesn't look right to me... which one is used
>> > where and when ?
>> >
>>
>> My reading of the databook is that U2SWOAE is an enable bit that lets the U2
>> storage attribute control the behavior.
>
> You mean the MMUCR variant ?
>

Yeah, the MMCR variant acts as an enable/mask for the U2 storage attribute.

>
> Well, point is, parsing the device-tree from early boot asm is nasty,
> unless you start extending the header but that sucks. That's why I'm
> thinking it might be a good idea to look at what it takes to "convert"
> the initial entry instead, even if that involves some cache flushing
> (provided that's workable at all of course).
>

ah, okay.  I guess if its happening before the secondary cpus come up
then that should be workable.   I guess it doesn't hurt to try.

       -eric

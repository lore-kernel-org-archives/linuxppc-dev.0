Return-Path: <cbouatmailru@gmail.com>
Date: Thu, 10 Jun 2010 19:47:41 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
Message-ID: <20100610154741.GA7484@oksana.dev.rtsoft.ru>
References: <20100608194809.GA32732@oksana.dev.rtsoft.ru>
	<1276150663.1962.43.camel@pasglop>
	<AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
	<20100610.091357.513168276793712624.imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100610.091357.513168276793712624.imp@bsdimp.com>
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 09:13:57AM -0600, M. Warner Losh wrote:
[...]
> : >> I told you several ways of how to improve the code (based on
> : >> the ideas from drivers/base/, so the ideas aren't even mine,
> : >> fwiw).
> : >
> : > I tend to agree with Anton here.
> : 
> : The reason I'm confident doing it that way is that it is *not* a
> : structure.  There is no structure relationship between the resource
> : table and the platform_device other than they are allocated with the
> : same kzalloc() call.  All the code that cares about that is contained
> : within 4 lines of code.  I'm resistant to using a structure because it
> : is adds an additional 5-6 lines of code to add a structure that won't
> : be used anywhere else, and is only 4 lines to begin with.
> 
> I tend to agree with Grant here.  The idiom he's using is very wide
> spread in the industry and works extremely well.  It keeps the
> ugliness confined to a couple of lines and is less ugly than the
> alternatives for this design pattern.  It is a little surprising when
> you see the code the first time, granted, but I think its expressive
> power trumps that small surprise.

Oh, come on. Both constructions are binary equivalent.

So how can people seriously be with *that* code:

	dev->resource = (void *)&dev[1];

which, semantically, is a nonsense and asks for a fix.

While
	dev_obj->dev.resource = dev_obj->resource;

simply makes sense.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2

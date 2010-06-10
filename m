Return-Path: <imp@bsdimp.com>
Date: Thu, 10 Jun 2010 10:01:40 -0600 (MDT)
Message-Id: <20100610.100140.8559628065321695.imp@bsdimp.com>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
From: "M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <20100610154741.GA7484@oksana.dev.rtsoft.ru>
References: <AANLkTilpUi1cazljWSFbzliY78RKyHUlvBshUD3NPHPv@mail.gmail.com>
	<20100610.091357.513168276793712624.imp@bsdimp.com>
	<20100610154741.GA7484@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

In message: <20100610154741.GA7484@oksana.dev.rtsoft.ru>
            Anton Vorontsov <cbouatmailru@gmail.com> writes:
: On Thu, Jun 10, 2010 at 09:13:57AM -0600, M. Warner Losh wrote:
: [...]
: > : >> I told you several ways of how to improve the code (based on
: > : >> the ideas from drivers/base/, so the ideas aren't even mine,
: > : >> fwiw).
: > : >
: > : > I tend to agree with Anton here.
: > : 
: > : The reason I'm confident doing it that way is that it is *not* a
: > : structure.  There is no structure relationship between the resource
: > : table and the platform_device other than they are allocated with the
: > : same kzalloc() call.  All the code that cares about that is contained
: > : within 4 lines of code.  I'm resistant to using a structure because it
: > : is adds an additional 5-6 lines of code to add a structure that won't
: > : be used anywhere else, and is only 4 lines to begin with.
: > 
: > I tend to agree with Grant here.  The idiom he's using is very wide
: > spread in the industry and works extremely well.  It keeps the
: > ugliness confined to a couple of lines and is less ugly than the
: > alternatives for this design pattern.  It is a little surprising when
: > you see the code the first time, granted, but I think its expressive
: > power trumps that small surprise.
: 
: Oh, come on. Both constructions are binary equivalent.
: 
: So how can people seriously be with *that* code:
: 
: 	dev->resource = (void *)&dev[1];
: 
: which, semantically, is a nonsense and asks for a fix.

It isn't nonsense.  That's just your opinion of it, nothing more.

: While
: 	dev_obj->dev.resource = dev_obj->resource;
: 
: simply makes sense.

But this requires extra, bogus fields in the structure and creates a
bogus sizeof issue.

There are problems both ways.  Yelling about it isn't going to make
you any more right, or convince me that I'm wrong.  It is an argument
that is at least two decades old...

Warner

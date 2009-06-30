Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CC000B70A8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 20:43:27 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B154FDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 20:43:26 +1000 (EST)
Subject: Re: Inline Assembly queries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Howells <dhowells@redhat.com>
In-Reply-To: <30098.1246291036@redhat.com>
References: <abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	<abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<30098.1246291036@redhat.com>
Content-Type: text/plain
Date: Tue, 30 Jun 2009 20:43:03 +1000
Message-Id: <1246358583.31413.11.camel@pasglop>
Mime-Version: 1.0
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org,
	kernel mailz <kernelmailz@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-29 at 16:57 +0100, David Howells wrote:
> kernel mailz <kernelmailz@googlemail.com> wrote:
> 
> > asm("sync");
> 
> Isn't gcc free to discard this as it has no dependencies, no indicated side
> effects, and isn't required to be kept?  I think this should probably be:
> 
> 	asm volatile("sync");

It should also have a "memory" clobber or it's pointless since gcc would
otherwise be free to move load and stores accross that barrier.

Cheers,
Ben.

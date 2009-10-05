Return-Path: <JBeulich@novell.com>
Received: from vpn.id2.novell.com (vpn.id2.novell.com [195.33.99.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "emea1-mh.id2.novell.com", Issuer "APPS" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C5409B7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Oct 2009 17:58:34 +1100 (EST)
Message-Id: <4AC9B5310200007800017EA1@vpn.id2.novell.com>
Date: Mon, 05 Oct 2009 07:58:25 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Hollis Blanchard" <hollisb@us.ibm.com>
Subject: Re: linux-next: tree build failure
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<1254267572.15622.1621.camel@slab.beaverton.ibm.com>
	<4AC318450200007800017355@vpn.id2.novell.com>
	<1254498517.3839.17.camel@slab.beaverton.ibm.com>
In-Reply-To: <1254498517.3839.17.camel@slab.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part7358FD01.2__="
Cc: sfr@canb.auug.org.au, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part7358FD01.2__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

>>> Hollis Blanchard <hollisb@us.ibm.com> 02.10.09 17:48 >>>
>On Wed, 2009-09-30 at 07:35 +0100, Jan Beulich wrote:
>> The one Rusty suggested the other day may help here. I don't like it
>> as a drop-in replacement for BUILD_BUG_ON() though (due to it
>> deferring the error generated to the linking stage), I'd rather view
>> this as an improvement to MAYBE_BUILD_BUG_ON() (which should
>> then be used here).
>
>Can you be more specific?
>
>I have no idea what Rusty suggested where. I can't even guess what

I'm attaching Rusty's response I was referring to.

>MAYBE_BUILD_BUG_ON() is supposed to do (sounds like a terrible name).

Agreed - but presumably better than just deleting the bogus instances
altogether...

Jan

--=__Part7358FD01.2__=
Content-Type: message/rfc822

Return-path: <rusty@rustcorp.com.au>
Received: from novell.com (hoex.provo.novell.com [130.57.1.153])
	by sinclair.provo.novell.com with ESMTP; Tue, 22 Sep 2009 19:34:01 -0600
Received: from ozlabs.org not authenticated [203.10.76.45]
	by novell.com with M+ Extreme Email Engine 2008.4.debug
	via secured & encrypted transport (TLS);
	Tue, 22 Sep 2009 19:34:00 -0600
X-MailFrom: rusty@rustcorp.com.au
Received: from vivaldi.localnet (unknown [150.101.102.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPSA id 94856B7B73;
	Wed, 23 Sep 2009 10:57:03 +1000 (EST)
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] fix BUILD_BUG_ON() and a couple of bogus uses of it
Date: Wed, 23 Sep 2009 10:27:00 +0930
User-Agent: KMail/1.11.2 (Linux/2.6.28-15-generic; KDE/4.2.2; i686; ; )
Cc: linux-kernel@vger.kernel.org
References: <4A8AEBFD0200007800010580@vpn.id2.novell.com>
In-Reply-To: <4A8AEBFD0200007800010580@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200909231027.01006.rusty@rustcorp.com.au>

On Wed, 19 Aug 2009 01:29:25 am Jan Beulich wrote:
> gcc permitting variable length arrays makes the current construct
> used for BUILD_BUG_ON() useless, as that doesn't produce any diagnostic
> if the controlling expression isn't really constant. Instead, this
> patch makes it so that a bit field gets used here. Consequently, those
> uses where the condition isn't really constant now also need fixing.
> 
> Note that in the gfp.h, kmemcheck.h, and virtio_config.h cases
> MAYBE_BUILD_BUG_ON() really just serves documentation purposes - even
> if the expression is compile time constant (__builtin_constant_p()
> yields true), the array is still deemed of variable length by gcc, and
> hence the whole expression doesn't have the intended effect.
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>

We used to use an undefined symbol here; diagnostics are worse but it catches
more stuff.

Perhaps a hybrid is the way to go?

#ifndef __OPTIMIZE__
#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
#else
/* If it's a constant, catch it at compile time, otherwise at link time. */
extern int __build_bug_on_failed;
#define BUILD_BUG_ON(condition) \
	do { 								\
		((void)sizeof(char[1 - 2*!!(condition)]));		\
		if (condition) __build_bug_on_failed = 1;		\
	} while(0)
#endif

Thanks,
Rusty.

--=__Part7358FD01.2__=--

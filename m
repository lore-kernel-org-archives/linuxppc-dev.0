Return-Path: <ericvh@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2D5F6B71C1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 11:08:50 +1000 (EST)
Received: by fxm5 with SMTP id 5so2702009fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 18:08:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305851709.7481.89.camel@pasglop>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-2-git-send-email-ericvh@gmail.com>
	<1305851709.7481.89.camel@pasglop>
Date: Thu, 19 May 2011 20:08:46 -0500
Message-ID: <BANLkTimEqYnTn10rV2=gfDkXfgxX+2OSCg@mail.gmail.com>
Subject: Re: [PATCH 2/7] [RFC] add bluegene entry to cputable
From: Eric Van Hensbergen <ericvh@gmail.com>
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

On Thu, May 19, 2011 at 7:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2011-05-18 at 16:24 -0500, Eric Van Hensbergen wrote:
>> + =A0 =A0 =A0 =A0 =A0 =A0 .dcache_bsize =A0 =A0 =A0 =A0 =A0 =3D 32,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .cpu_setup =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D __se=
tup_cpu_460gt,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0^^^^^^^^^^^^^^^^^^
> Are you sure ?
>

That surprised me too, I figured it must have been a close enough
match (at least in the 2.6.29.1 time frame which is where I'm trying
to merge the BG/P patches up from.  The kittyhawk patches don't even
use this, so its possible we could just remove it.


_GLOBAL(__setup_cpu_460ex)
_GLOBAL(__setup_cpu_460gt)
        mflr    r4
        bl      __init_fpu_44x
        bl      __fixup_440A_mcheck
        mtlr    r4
        blr

Looks like the 460 setup invokes a bunch of 440 calls!  Would you
prefer I setup my own entry point (setup_cpu_bgp or setup_cpu_450)
which makes the same calls?

     -eric

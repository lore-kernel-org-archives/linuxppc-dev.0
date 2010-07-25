Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f170.google.com (mail-gx0-f170.google.com
	[209.85.161.170]) by ozlabs.org (Postfix) with ESMTP id 20204B6F06
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 06:37:59 +1000 (EST)
Received: by gxk25 with SMTP id 25so1000487gxk.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 13:37:58 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100725130723.a5192793.sfr@canb.auug.org.au>
References: <20100724154331.22701.3409.stgit@angua>
	<20100725130723.a5192793.sfr@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 25 Jul 2010 14:37:38 -0600
Message-ID: <AANLkTinE4X0iAJAiatc7Qtj2QP6dhyBKo9fqxqUt40Y6@mail.gmail.com>
Subject: Re: [PATCH] of: Provide default of_node_to_nid() when CONFIG_NUMA is
	not set
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 24, 2010 at 9:07 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> Hi Grant,
>
> On Sat, 24 Jul 2010 09:43:31 -0600 Grant Likely <grant.likely@secretlab.c=
a> wrote:
>>
>> of_node_to_nid() is only relevant for NUMA. =A0Don't force architectures=
 to
>> implement it if CONFIG_NUMA is not set.
>
> Why not just do:
>
> #ifndef of_node_to_nid
> static inline int of_node_to_nid(struct device_node *device) { return 0; =
}
> #define of_node_to_nid =A0of_node_to_nid
> #endif
>
> in include/linux/of.h
>
> and then add:
>
> #define of_node_to_nid =A0of_node_to_nid
>
> Where it is declared/defined for each arch ...
> (it would be nice if all the archs were consistent in where it was
> declared).

Two reasons; I had started doing that in topology.h, but it caused a
bunch of collateral damage with files missing the include, so I punted
and took the easy way out.  Also, I didn't know if that was an
acceptable or safe pattern for override symbols.

I'll spin it again with this pattern and see what it looks.

g.


> --
> Cheers,
> Stephen Rothwell =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sfr@canb.auug.org=
.au
> http://www.canb.auug.org.au/~sfr/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

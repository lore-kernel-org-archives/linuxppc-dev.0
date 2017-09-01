Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkKq25bFXzDqkb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 23:29:50 +1000 (AEST)
In-Reply-To: <1501707705-32425-1-git-send-email-Julia.Lawall@lip6.fr>
To: Julia Lawall <Julia.Lawall@lip6.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: powerpc/macintosh: constify wf_sensor_ops structures
Message-Id: <3xkKq244Czz9t3F@ozlabs.org>
Date: Fri,  1 Sep 2017 23:29:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-02 at 21:01:45 UTC, Julia Lawall wrote:
> The wf_sensor_ops structures are only stored in the ops field of a
> wf_sensor structure, which is declared as const.  Thus the
> wf_sensor_ops structures themselves can be const.
> 
> Done with the help of Coccinelle.
> 
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct wf_sensor_ops i@p = { ... };
> 
> @ok1@
> identifier r.i;
> struct wf_sensor s;
> position p;
> @@
> s.ops = &i@p
> 
> @ok2@
> identifier r.i;
> struct wf_sat_sensor s;
> position p;
> @@
> s.sens.ops = &i@p
> 
> @bad@
> position p != {r.p,ok1.p,ok2.p};
> identifier r.i;
> struct wf_sensor_ops e;
> @@
> e@i@p
> 
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct wf_sensor_ops i = { ... };
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/de854e54d79bc0ad5c45c5be50821b

cheers

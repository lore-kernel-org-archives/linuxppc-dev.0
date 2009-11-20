Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B06AF33.1000400@austin.ibm.com>
References: <4B06AF33.1000400@austin.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 20 Nov 2009 14:40:22 -0700
Message-ID: <fa686aa40911201340i77bc4098ud866d103acaefd30@mail.gmail.com>
Subject: Re: [PATCH 0/4 v2] Merge OF dynamic patches
To: Nathan Fontenot <nfont@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 20, 2009 at 8:01 AM, Nathan Fontenot <nfont@austin.ibm.com> wro=
te:
> This set of patches merges the common dynamic device tree
> updating routines of_attach_node() and of_detach_node() to
> drivers/of/of_dynamic.c.
>
> Built and tested on powerpc, I have no access to build/test
> this on microblaze.

Heh.  Actually, I've got a patch in my tree that does the same thing
(except to a different location).  I could pick up your version and
drop mine, but you need to rework it to be bi-sectable.  As the series
exists right now, the build will fail if only part of the series is
applied.  This change is simple enough that you can do the whole thing
in a single patch.  Or, fix the Kconfig and include stuff in the first
patch with the merge of of_attach_node, and then move of_detach_node
in the second.

But I'm really close to posting my 3rd series, so it may be better to
wait until that is published and build a patch on top of that to move
them into of_dynamic.c

Cheers,
g.

> ---
>
> 1/4 - Merge of_attach_node
> 2/4 - Merge of_detach_node
> 3/4 - Makefile/Kconfig updates
> 4/4 - Update powerpc/pseries to include of_dynamic.h
>
> arch/microblaze/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01
> arch/microblaze/include/asm/prom.h =A0 =A0 =A0 =A0| =A0 =A04 -
> arch/microblaze/kernel/prom.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 59 ----------=
-------------
> arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1
> arch/powerpc/include/asm/prom.h =A0 =A0 =A0 =A0 =A0 | =A0 =A04 -
> arch/powerpc/kernel/prom.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 59 ------=
-----------------
> arch/powerpc/platforms/pseries/reconfig.c | =A0 =A01 drivers/of/Kconfig
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> drivers/of/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
1 drivers/of/of_dynamic.c
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 75 ++++++++++++++++++++++++++++++
> include/linux/of_dynamic.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 27 ++++++=
++++
> 11 files changed, 110 insertions(+), 126 deletions(-)
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

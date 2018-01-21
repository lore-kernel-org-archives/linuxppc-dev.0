Return-Path: <SRS0=5ZSR=EQ=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPpS96jBrzF0XS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 09:01:45 +1100 (AEDT)
Date: Sun, 21 Jan 2018 17:01:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devicetree@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Rob
 Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/1] of: introduce event tracepoints for dynamic
 device_node lifecyle
Message-ID: <20180121170140.23d1ff12@gandalf.local.home>
In-Reply-To: <20180121143117.19805-2-wsa+renesas@sang-engineering.com>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <20180121143117.19805-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 21 Jan 2018 15:31:17 +0100
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>=20
> This patch introduces event tracepoints for tracking a device_nodes
> reference cycle as well as reconfig notifications generated in response
> to node/property manipulations.
>=20
> With the recent upstreaming of the refcount API several device_node
> underflows and leaks have come to my attention in the pseries (DLPAR)
> dynamic logical partitioning code (ie. POWER speak for hotplugging
> virtual and physcial resources at runtime such as cpus or IOAs). These
> tracepoints provide a easy and quick mechanism for validating the
> reference counting of device_nodes during their lifetime.
>=20
> Further, when pseries lpars are migrated to a different machine we
> perform a live update of our device tree to bring it into alignment with
> the configuration of the new machine. The of_reconfig_notify trace point
> provides a mechanism that can be turned for debuging the device tree
> modifications with out having to build a custom kernel to get at the
> DEBUG code introduced by commit 00aa37206e1a54 ("of/reconfig: Add debug
> output for OF_RECONFIG notifiers").
>=20
> The following trace events are provided: of_node_get, of_node_put,
> of_node_release, and of_reconfig_notify. These trace points require a
> kernel built with ftrace support to be enabled. In a typical environment
> where debugfs is mounted at /sys/kernel/debug the entire set of
> tracepoints can be set with the following:
>=20
>   echo "of:*" > /sys/kernel/debug/tracing/set_event
>=20
> or
>=20
>   echo 1 > /sys/kernel/debug/tracing/events/of/enable
>=20
> The following shows the trace point data from a DLPAR remove of a cpu
> from a pseries lpar:
>=20
> cat /sys/kernel/debug/tracing/trace | grep "POWER8@10"
>=20
> cpuhp/23-147   [023] ....   128.324827:
>         of_node_put: refcount=3D5, dn->full_name=3D/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324829:
>         of_node_put: refcount=3D4, dn->full_name=3D/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324829:
>         of_node_put: refcount=3D3, dn->full_name=3D/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324831:
>         of_node_put: refcount=3D2, dn->full_name=3D/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439000:
>         of_node_put: refcount=3D1, dn->full_name=3D/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439002:
>         of_reconfig_notify: action=3DDETACH_NODE, dn->full_name=3D/cpus/P=
owerPC,POWER8@10,
>                             prop->name=3Dnull, old_prop->name=3Dnull
>    drmgr-7284  [009] ....   128.439015:
>         of_node_put: refcount=3D0, dn->full_name=3D/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439016:
>         of_node_release: dn->full_name=3D/cpus/PowerPC,POWER8@10, dn->_fl=
ags=3D4
>=20
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> [wsa: fixed commit abbrev and one of the sysfs paths in commit desc,
> removed trailing space and fixed pointer declaration in code]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

=46rom the tracing perspective:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---

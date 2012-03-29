Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92160B6EEC
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2012 02:48:46 +1100 (EST)
Received: from mail146-ch1 (localhost [127.0.0.1])	by
 mail146-ch1-R.bigfish.com (Postfix) with ESMTP id 986F42074C	for
 <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2012 15:48:42 +0000 (UTC)
Received: from CH1EHSMHS014.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.227])	by mail146-ch1.bigfish.com (Postfix) with ESMTP id
 C6E913C0056	for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2012 15:48:40 +0000
 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: why use 'raw_spin_lock_irqsave' inf function
 'of_find_node_with_property'
Date: Thu, 29 Mar 2012 15:48:37 +0000
Message-ID: <CAOZdJXVRsGQJ5js4uUgQuq0CFY==suYWTXuRPnpV+5QDHUe9DA@mail.gmail.com>
References: <110EED8CC96DFC488B7E717A2027A27C05F5BA@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C05F5BA@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2012 at 5:01 AM, Huang Changming-R66093
<r66093@freescale.com> wrote:
> Hi, all
>
> In function =93of_find_node_with_property=94, why use =93raw_spin_lock_ir=
qsave=94 to
> disable preemption and disable interrupt?

Where do you see raw_spin_lock_irqsave?

struct device_node *of_find_node_with_property(struct device_node *from,
	const char *prop_name)
{
	struct device_node *np;
	struct property *pp;

	read_lock(&devtree_lock);
	np =3D from ? from->allnext : allnodes;
	for (; np; np =3D np->allnext) {
		for (pp =3D np->properties; pp !=3D 0; pp =3D pp->next) {
			if (of_prop_cmp(pp->name, prop_name) =3D=3D 0) {
				of_node_get(np);
				goto out;
			}
		}
	}
out:
	of_node_put(from);
	read_unlock(&devtree_lock);
	return np;
}

We need a lock so that we don't parse the tree while it's being
modified.  That would cause the for-loop to fail in strange ways.

--=20
Timur Tabi
Linux kernel developer at Freescale=

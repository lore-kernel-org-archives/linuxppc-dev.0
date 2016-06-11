Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRq8T3W7LzDqT2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 05:38:17 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c74so7457161pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 12:38:17 -0700 (PDT)
Subject: Re: case sensitivity for devicetree node names
References: <575B1D84.2010703@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely
 <grant.likely@secretlab.ca>, David Gibson <david@gibson.dropbear.id.au>,
 "devicetree-spec@vger.kernel.org" <devicetree-spec@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <575C68A1.1020701@gmail.com>
Date: Sat, 11 Jun 2016 12:38:09 -0700
MIME-Version: 1.0
In-Reply-To: <575B1D84.2010703@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

(and adding other powerpc folks)

On 06/10/16 13:05, Frank Rowand wrote:
> I had assumed that devicetree node names were case sensitive. But a recent
> email thread asserted that they were not, which made me curious.
> 
> dtc treats node names as case sensitive:
> 
> $ cat test_node_case_1.dts
> 
> /dts-v1/;
> 
> / {
> 	node-x {
> 		prop_a = < 1 >;
> 	};
> };
> 
> / {
> 	node-X {
> 		prop_a = < 2 >;
> 	};
> };
> 
> $ cat test_node_case_2.dts
> 
> /dts-v1/;
> 
> / {
> 	node-x {
> 		prop_a = < 1 >;
> 	};
> };
> 
> / {
> 	node-x {
> 		prop_a = < 2 >;
> 	};
> };
> 
> $ dtc -O dts test_node_case_1.dts
> /dts-v1/;
> 
> / {
> 
> 	node-x {
> 		prop_a = <0x1>;
> 	};
> 
> 	node-X {
> 		prop_a = <0x2>;
> 	};
> };
> 
> $ dtc -O dts test_node_case_2.dts
> /dts-v1/;
> 
> / {
> 
> 	node-x {
> 		prop_a = <0x2>;
> 	};
> };
> 
> 
> But the Linux kernel source code defines of_node_cmp() as:
> 
>   include/linux/of.h:
> 
>   /* Default string compare functions, Allow arch asm/prom.h to override */
>   #if !defined(of_compat_cmp)
>   #define of_node_cmp(s1, s2) strcasecmp((s1), (s2))
> 
> arch/sparc/include/asm/prom.h uses strcmp() instead of strcasecmp().
> 
> Examples of using of_node_cmp() to check for a node name can be found,
> for example, of_find_node_by_name().
> 
> Is case insensitivity for node names a bug in the Linux kernel, or desired
> for some reason?
> 
> -Frank
> 

I chased through the history and found a 2.6.0-test5 announcement
which noted the patch from you which adds:

  of_find_node_by_path()
  of_find_node_by_name()
  of_find_node_by_type()
  of_find_compatible_node()

(And the patch is commit 394edd852a14 in the git recreation
of bitkeeper days, which is found at
git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git)

That version of the functions uses a case insensitive compare for
devicetree node names.

Do you remember why you chose to not use a case sensitive compare?

Thanks,

-Frank

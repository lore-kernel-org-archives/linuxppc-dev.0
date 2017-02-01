Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCn0R1DQzzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 13:20:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com
Subject: Re: [PATCH] cxl: fix build when CONFIG_DEBUG_FS=n
In-Reply-To: <20170131141000.24636-1-andrew.donnellan@au1.ibm.com>
References: <20170131141000.24636-1-andrew.donnellan@au1.ibm.com>
Date: Wed, 01 Feb 2017 13:20:19 +1100
Message-ID: <871sviveho.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

> Stub out the debugfs functions so that the build doesn't break when
> CONFIG_DEBUG_FS=n.

It's not a big deal, but it's preferable to do the stubs as static
inlines in a header. That way they generate no code.

Doing it this way, in a C file, you'll still get lots of one and two
instruction functions generated in your vmlinux, which is less neat.

cheers

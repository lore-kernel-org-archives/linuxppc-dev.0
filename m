Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC83V2RKmzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:36:06 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Paul Clarke <pc@us.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] kallsyms: optimize kallsyms_lookup_name() for a few cases
Date: Tue, 25 Apr 2017 16:36:00 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFDB161@AcuExch.aculab.com>
References: <20170425161822.18764-1-naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <20170425161822.18764-1-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Naveen N. Rao
> Sent: 25 April 2017 17:18
> 1. Fail early for invalid/zero length symbols.
> 2. Detect names of the form <mod:name> and skip checking for kernel
> symbols in that case.
>=20
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Masami, Michael,
> I have added two very simple checks here, which I felt is good to have,
> rather than the elaborate checks in the previous version. Given the
> change in module code to use strnchr(), the checks are now safe and
> further tests are not probably not that useful.
...
> +	if (strnchr(name, MODULE_NAME_LEN, ':'))
> +		return module_kallsyms_lookup_name(name);

Should that be MODULE_NAME_LEN - 1 ?

	David

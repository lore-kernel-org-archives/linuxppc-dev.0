Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D3EAB70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 16:10:54 +1100 (EST)
Subject: Re: [PATCH v2 3/3] powerpc: Add IO event interrupt support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1294267483.24377.30.camel@flin.austin.ibm.com>
References: <1294267483.24377.30.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 16:10:37 +1100
Message-ID: <1297055437.14982.57.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-01-05 at 16:44 -0600, Tseng-Hui (Frank) Lin wrote:
> This patch adds support for handling IO Event interrupts which come
> through at the /event-sources/ibm,io-events device tree node.

 .../...

The previous patches regarding the error log sometimes call it error log
and sometimes event log. Can you consolidate that ?

> +int pseries_ioei_register_handler(pseries_ioei_handler_t handler)
> +{

Shouldn't we have a void * to attach with each client so it can put
its private data there and get them back in the handler ?

We are -really- re-inventing interrupts and/or notifiers here, which
I find a tad annoying..

Cheers,
Ben.

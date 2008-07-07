Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BB53DDDEF
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 15:00:36 +1000 (EST)
Subject: Re: [PATCH] Power5,Power6 BSR driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sonny Rao <sonnyrao@us.ibm.com>
In-Reply-To: <20080618065123.GB13318@localhost.localdomain>
References: <20080616185344.GB16192@gamma> <20080617223952.GA9594@localdomain>
	<20080617224443.GD7552@localhost.localdomain>
	<20080618065123.GB13318@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 14:59:35 +1000
Message-Id: <1215406775.8970.57.camel@pasglop>
Mime-Version: 1.0
Cc: sonnyrao@linux.vnet.ibm.com, paulus@samba.org, Nathan Lynch <ntl@pobox.com>,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +		cur->bsr_addr   = reg[i * 2];
> +		cur->bsr_len    = reg[i * 2 + 1];

That's fishy... hand-reading of "reg" property without taking
into account the parent's #size-cells/#address-cells... can't you
use of_address_to_resource or something similar and carry a struct
resource around instead ?

In fact, same goes with the way you do num_bsr_devs = reg_len / 16.

You should rather use -another- property of well known lenght, or
get the #address/#size-cells of the parent and use those appropriately.

Cheers,
Ben.

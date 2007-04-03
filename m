Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 04579DDE3C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 00:26:54 +1000 (EST)
Date: Tue, 3 Apr 2007 09:28:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/19] PCI: rpaphp: Cleanup flow of control for
	rpaphp_add_slot
Message-ID: <20070403142828.GK8423@localdomain>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403003346.3D32D3A65C@topology.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403003346.3D32D3A65C@topology.austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> 
> Cleanup the flow of control for rpaphp_add_slot(), so as to
> make it easier to read. The ext patch will fix a bug in this 
> same code. 

This:

> +	if (!dn || strcmp(dn->name, "pci"))
> +		return 0;

is not equivalent to the code it's replacing:

> -	if (dn->name != 0 && strcmp(dn->name, "pci") == 0) {

With your version we'll oops if dn->name is NULL.

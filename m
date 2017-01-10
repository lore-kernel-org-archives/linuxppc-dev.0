Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyXbC6hn4zDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 00:16:07 +1100 (AEDT)
Date: Tue, 10 Jan 2017 07:15:42 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Steven Munroe <munroesj@linux.vnet.ibm.com>
Subject: Re: [PATCH 9/9] powerpc: A new cache shape aux vectors
Message-ID: <20170110131542.GK28613@gate.crashing.org>
References: <20170104051535.9454-1-benh@kernel.crashing.org>
 <20170104051535.9454-9-benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170104051535.9454-9-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 04, 2017 at 04:15:35PM +1100, Benjamin Herrenschmidt wrote:
> + * For all these fields, a value of 0 means that the information
> + * is not known.

> +	if (sets == 0)
> +		info->assoc = 0xffff;
> +	else
...

Is this correct?  A fully associative cache should be encoded as sets == 1,
if there are buggy firmwares that set it to 0 instead it should do the same
as 1 here I think?  Or is 0xffff indicating "unknown" here...  But in that
case the comment above says assoc should be 0 instead.


Segher

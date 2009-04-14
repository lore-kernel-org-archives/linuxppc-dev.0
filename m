Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B9D7DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 18:08:38 +1000 (EST)
In-Reply-To: <1238755594-18869-2-git-send-email-tiejun.china@gmail.com>
References: <1238755594-18869-1-git-send-email-tiejun.china@gmail.com>
	<1238755594-18869-2-git-send-email-tiejun.china@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3C36E383-13A3-49E9-B87B-D22D966B6F79@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [v1 PATCH 1/1] Fix 64bit Maple Host Bridge Address and Size Nodes
Date: Tue, 14 Apr 2009 10:11:02 +0200
To: tiejun.china@gmail.com
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In the DTB tree created by firmware on some Maple 64bit targets,  
> such as ATCA6101,
> these two properties, address&size, should be 2.

And they are.

> But the actual corresponding values
> of host bridge node are set 1 incorrectly by the firmware, we have  
> to provide one
> fixup function to fix that.

It is the "reg" property that is incorrectly encoded as-if
#address-cells and #size-cells were 1.

Please fix the commit message (and subject line).

> +	name = "/hostbridge@f8000000";
> +	hb = call_prom("finddevice", 1, 1, ADDR(name));

It's interesting that the firmware can find your node this way,
it won't match the "reg"!  Looks like there is more than one
bug in there.

Code looks good,

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher

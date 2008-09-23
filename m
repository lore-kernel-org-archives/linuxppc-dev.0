Return-Path: <lark@linux.net.cn>
Received: from mx.linux.net.cn (unknown [210.82.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C60EDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 00:25:01 +1000 (EST)
Message-ID: <48D8FC36.9080407@linux.net.cn>
Date: Tue, 23 Sep 2008 22:24:54 +0800
From: Wang Jian <lark@linux.net.cn>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: mpc8541 pci1 ioport allocation address space problem
References: <48D4DB89.3040607@linux.net.cn> <1222062464.12085.25.camel@pasglop>
In-Reply-To: <1222062464.12085.25.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Confirmed.

I had this patch and 2 fixes on dts applied simultaneously, and the board
works. I thought this patch was necessary.

I reverted this patch and tried again, the board still works. Thanks for
your insight.

Anyway, the io port read from /proc/ioports is misleading, so I wish it
can be changed a little.


Regards

Benjamin Herrenschmidt wrote:
> This is expected and should work. Depending on the relative
> physical addresses of IO space and the order in which the bridges are
> discovered, the bridge IO ports will look at either positive or negative
> values. This should be fine, as port numbers are supposed to be 32 bits
> and in-kernel arithmetic should do the right thing... I suppose unless a
> driver stores those in a 64 bits integer and doesn't sign extend.
> 
> I would like to change that whole thing to something more similar to
> 64 bits where I reserve a portion of the address space for IO ports,
> though address space on 32 bits platforms is scarce, but nothing I have
> time to toy with right now.
> 
> Cheers,
> Ben. 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

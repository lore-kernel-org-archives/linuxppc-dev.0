Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4AD7D1007D4
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 14:22:55 +1100 (EST)
In-Reply-To: <20111202222623.GA31354@us.ibm.com>
References: <20111202222623.GA31354@us.ibm.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <144CAEA6-C129-4935-B6D1-A7D6F24530A5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/1] Punch a hole in /dev/mem for librtas
Date: Sat, 3 Dec 2011 04:22:59 +0100
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: sbest@us.ibm.com, paulus@samba.org, anton@samba.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +static inline int page_is_rtas_user_buf(unsigned long pfn)
> +{
> +	unsigned long paddr = (pfn << PAGE_SHIFT);
> +	if (paddr >= rtas_rmo_buf && paddr < (rtas_rmo_buf +  
> RTAS_RMOBUF_MAX))

It probably cannot overflow with actual values of rtas_rmo_buf
and RTAS_RMOBUF_MAX, but otherwise it is an incorrect test;
please write

	if (paddr >= rtas_rmo_buf && paddr - rtas_rmo_buf < RTAS_RMOBUF_MAX)

(and, _MAX?  Shouldn't it be the actual size here?  Or is _MAX
just a confusing name :-) )


Segher

Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8405FDE115
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 02:44:54 +1100 (EST)
In-Reply-To: <47CFEE9D.1020300@tiscali.nl>
References: <47CFEE9D.1020300@tiscali.nl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5adf51cc1df72cfd261e3c6e7bead312@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PPC: in celleb_show_cpuinfo() convert strncpy(x, y,
	sizeof(x)) to strlcpy
Date: Thu, 6 Mar 2008 16:44:24 +0100
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	lkml <linux-kernel@vger.kernel.org>, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch was not yet tested. Please confirm it's right.
> ---
> strncpy does not append '\0' if the length of the source string equals
> the size parameter, strlcpy does.

strlcpy() doesn't fill the rest of the array with zeroes, strncpy()
does.  This could matter (information leak, for example), although
I doubt it does here.

> -	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
> +	strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
>  	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;

That last statement makes the strncpy() case always zero-terminated,
so this patch isn't necessary.  Oh, and neither the old nor the new
code handles the case where the string doesn't fit (other than just
cutting it short); is that the wanted behaviour?


Segher

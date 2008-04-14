Return-Path: <jirislaby@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by ozlabs.org (Postfix) with ESMTP id 91A20DDF9C
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 00:24:16 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so2064944fkz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 07:24:15 -0700 (PDT)
Message-ID: <4803690A.3080105@gmail.com>
Date: Mon, 14 Apr 2008 16:24:10 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>	<12053582231281-git-send-email-yorksun@freescale.com>	<47D8572C.8090501@gmail.com>	<47FFDBFF.1030809@gmail.com>
	<20080411221817.0b1eb414.akpm@linux-foundation.org>
	<48035E93.6070300@freescale.com> <48035F98.1020404@gmail.com>
	<48036001.10905@freescale.com> <4803620C.6020905@gmail.com>
	<48036649.6000409@freescale.com>
In-Reply-To: <48036649.6000409@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 04/14/2008 04:12 PM, Timur Tabi wrote:
> Unfortunately, the author of the patch, York, is out this week, so I'll have to
> take care of this.  It'd be easier to modify rh_alloc() so that it doesn't
> sleep, so that's what I'm going to do.

Anyway, why do you need the spin lock there (and not mutex)? As I think you are 
still trying to avoid the problem instead of fixing it. Removing GFP_WAIT 
(fsl_diu_alloc) doesn't seem to me as mm friendly solution, especially if you 
allocate that much memory and you can sleep. But I might be wrong, you may need 
the spinlock...

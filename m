Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (unknown [192.88.158.102])
	by ozlabs.org (Postfix) with ESMTP id 18DC3679E0
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 10:05:17 +1000 (EST)
Subject: Re: [PATCH] powerpc: Auto reserve of device tree blob
From: Jon Loeliger <jdl@freescale.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20060518220408.49C6567A44@ozlabs.org>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<20060518220408.49C6567A44@ozlabs.org>
Content-Type: text/plain
Message-Id: <1148315146.17549.8.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Mon, 22 May 2006 11:25:47 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-18 at 17:03, Michael Neuling wrote:
> From: Jimi Xenidis <jimix@watson.ibm.com>
> 
> A devtree compiler (dtc) generated devtree blob is "relocatable" and so
> does not contain a reserved_map entry for the blob itself.  This means
> that if passed to Linux, Linux will not get lmb_reserve() the blob and
> it could be over.  The following patch will explicitly reserve the
> "blob" as it was given to us and stops prom_init.c from creating a
> reserved mapping for the blob.
> 
> NOTE: that the dtc/kexec should not generate the blob reservation entry.
> Although if they do, LMB reserver handles overlaps.

The current DTC does not issue the memory reservation request.
As discussed earlier, it is now relying on the kernel
to do a reservation for the itself.  While I've not seen
it applied yet, I am assuming that Jimi's patch from 14 April
is what is needed here and will be applied.  (Maybe it
just needs a "Signed-off" to make it happen.  Dunno.)

Thanks,
jdl

Return-Path: <stern+4a1a87d0@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id B93D4DE05C
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 06:28:30 +1000 (EST)
Date: Thu, 14 May 2009 16:21:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [RFC Patch 6/6] Adapt kexec and samples code to recognise PPC64
	hardware breakpoint usage
In-Reply-To: <20090514134614.GG14229@in.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0905141621040.4344-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, paulus@samba.org,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 14 May 2009, K.Prasad wrote:

> Index: linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c
> ===================================================================
> --- linux-2.6-tip.hbkpt.orig/samples/hw_breakpoint/data_breakpoint.c	2009-05-14 00:17:24.000000000 +0530
> +++ linux-2.6-tip.hbkpt/samples/hw_breakpoint/data_breakpoint.c	2009-05-14 00:58:06.000000000 +0530
> @@ -54,6 +54,10 @@
>  	sample_hbp.info.type = HW_BREAKPOINT_WRITE;
>  	sample_hbp.info.len = HW_BREAKPOINT_LEN_4;
>  #endif /* CONFIG_X86 */
> +#ifdef CONFIG_PPC64
> +	sample_hbp.info.name = ksym_name;
> +	sample_hbp.info.type = DABR_DATA_WRITE;

This should be HW_BREAKPOINT_WRITE, not DABR_DATA_WRITE.

Alan Stern
